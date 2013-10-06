require "rspec-gherkin"
require "rspec"

module RspecGherkin
  module RSpec
    module Loader
      def load(*paths, &block)

        # Override feature exclusion filter if running features
        if paths.any? { |path| RspecGherkin.feature?(path) }
          ::RSpec.configuration.filter_manager.exclusions.reject! do |key, value|
            key == :feature || (key == :type && value == 'feature')
          end
        end

        paths = paths.map do |path|
          if RspecGherkin.feature?(path)
            spec_path = RspecGherkin.feature_to_spec(path)
            if File.exist?(spec_path)
              spec_path
            else
              RspecGherkin::Builder.build(path).features.each do |feature|
                ::RSpec::Core::ExampleGroup.describe("Feature: #{feature.name}", :type => :feature, :feature => true) do
                  it do
                    example.metadata[:file_path] = spec_path
                    example.metadata[:line_number] = 1
                    pending('Not yet implemented')
                  end
                end.register
              end

              nil
            end
          else
            path
          end
        end.compact

        super(*paths, &block) if paths.size > 0
      end
    end

    class << self
      def run(feature_file)
        RspecGherkin::Builder.build(feature_file).features.each do |feature|
          describe feature.name, feature.metadata_hash do
            before do
              # This is kind of a hack, but it will make RSpec throw way nicer exceptions
              example.metadata[:file_path] = feature_file

              # feature.backgrounds.map(&:steps).flatten.each do |step|
              #   run_step(feature_file, step)
              # end
            end
            feature.scenarios.each do |scenario|
              # describe scenario.name, scenario.metadata_hash do
              #   it scenario.steps.map(&:description).join(' -> ') do
              #     scenario.steps.each do |step|
              #       run_step(feature_file, step)
              #     end
              #   end
              # end
            end
          end
        end
      end
    end
  end
end
