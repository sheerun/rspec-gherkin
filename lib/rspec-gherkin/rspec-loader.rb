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
                ::RSpec::Core::ExampleGroup.describe(
                  "Feature: #{feature.name}", :type => :feature, :feature => true
                ) do
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

        # Load needed features to RspecGherkin.features array
        paths.each do |path|
          if RspecGherkin.feature_spec?(path)
            feature_path = RspecGherkin.spec_to_feature(path)

            if File.exists?(feature_path)
              RspecGherkin.features += RspecGherkin::Builder.build(feature_path).features
            end
          end
        end

        super(*paths, &block) if paths.size > 0
      end
    end
  end
end
