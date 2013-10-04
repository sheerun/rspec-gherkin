require "rspec-gherkin"
require "rspec"

module RspecGherkin
  module RSpec

    ##
    #
    # This module hooks RspecGherkin into RSpec by duck punching the load Kernel
    # method. If the file is a feature file, we run RspecGherkin instead!
    #
    module Loader
      def load(*a, &b)
        if a.first.end_with?('.feature')
          require_if_exists 'gherkin_helper'
          require_if_exists 'spec_helper'

          RspecGherkin::RSpec.run(a.first)
        else
          super
        end
      end

      private

      def require_if_exists(filename)
        require filename
      rescue LoadError => e
        # Don't hide LoadErrors raised in the spec helper.
        raise unless e.message.include?(filename)
      end
    end

    ##
    #
    # This module provides an improved method to run steps inside RSpec, adding
    # proper support for pending steps, as well as nicer backtraces.
    #
    module Execute
      include RspecGherkin::Execute

      def run_step(feature_file, step)
        begin
          step(step)
        rescue RspecGherkin::Pending => e
          pending("No such step: '#{e}'")
        rescue StandardError => e
          e.backtrace.push "#{feature_file}:#{step.line}:in `#{step.description}'"
          raise e
        end
      end
    end

    class << self
      def run(feature_file)
        RspecGherkin::Builder.build(feature_file).features.each do |feature|
          describe feature.name, feature.metadata_hash do
            before do
              # This is kind of a hack, but it will make RSpec throw way nicer exceptions
              example.metadata[:file_path] = feature_file

              feature.backgrounds.map(&:steps).flatten.each do |step|
                run_step(feature_file, step)
              end
            end
            feature.scenarios.each do |scenario|
              describe scenario.name, scenario.metadata_hash do
                it scenario.steps.map(&:description).join(' -> ') do
                  scenario.steps.each do |step|
                    run_step(feature_file, step)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

::RSpec::Core::Configuration.send(:include, RspecGherkin::RSpec::Loader)

::RSpec.configure do |config|
  config.include RspecGherkin::RSpec::Execute, rspecgherkin: true
  config.include RspecGherkin::Steps, rspecgherkin: true
  config.pattern << ",**/*.feature"
end
