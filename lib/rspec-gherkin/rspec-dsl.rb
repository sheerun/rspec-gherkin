module RSpecGherkin
  module DSL
    module Global
      def feature(name = nil, &block)
        raise ArgumentError.new("requires a name") if name.nil?

        matching_feature = RSpecGherkin.features.find do |feature|
          feature.name == name
        end

        if matching_feature
          describe("Feature: #{name}",
                   :type => :feature, :feature => true, :current_feature => matching_feature,
                   &block)
        else
          describe "Feature: #{name}", :type => :feature, :feature => true do
            it do
              file_path, line_number = block.source_location
              feature_path = RSpecGherkin.spec_to_feature(file_path, false)
              example.metadata.merge!(
                file_path: file_path,
                line_number: line_number
              )
              pending "No such feature in '#{feature_path}'"
            end
          end
        end

      end
    end

    module Rspec
      def background(&block)
        before(:each, &block)
      end

      def scenario(name = nil, &block)
        raise ArgumentError.new("requires a name") if name.nil?

        matching_scenario = metadata[:current_feature].scenarios.find do |scenario|
          scenario.name == name
        end

        if matching_scenario
          if matching_scenario.arguments
            specify "Scenario: #{name}" do
              instance_exec(*matching_scenario.arguments, &block)
            end
          else
            specify("Scenario: #{name}", &block)
          end
        else
          # Heavy hacking on message format
          specify name do
            file_path, line_number = block.source_location
            feature_path = RSpecGherkin.spec_to_feature(file_path, false)
            example.metadata.merge!(
              file_path: file_path,
              line_number: line_number
            )
            example.metadata[:example_group].merge!(
              description_args: ["Scenario:"]
            )
            pending "No such scenario in '#{feature_path}'"
          end
        end
      end
    end
  end
end
