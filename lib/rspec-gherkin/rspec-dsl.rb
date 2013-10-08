module RSpecGherkin
  module DSL
    module Global
      def feature(name = nil, &block)
        raise ArgumentError.new("requires a name") if name.nil?

        matching_feature = find_feature(name)

        if matching_feature
          if matching_feature.tags.include?('updated')
            describe "Feature: #{name}", :type => :feature, :feature => true do
              it do
                file_path, line_number = block.source_location
                feature_path = RSpecGherkin.spec_to_feature(file_path, false)
                example.metadata.merge!(
                  file_path: file_path,
                  line_number: line_number
                )
                pending "Feature has been marked as updated\n" +
                  "    #  Update specs for this feature and remove the @updated tag\n" +
                  "    #  Feature file: '#{feature_path}'"
              end
            end
          else
            describe(
              "Feature: #{name}",
              :type => :feature, :feature => true,
              :current_feature => matching_feature,
              &block
            )
          end

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

      private

      def find_feature(name)
        RSpecGherkin.features.find do |feature|
          feature.name == name
        end
      end
    end

    module Rspec
      def background(&block)
        before(:each, &block)
      end

      def scenario(name = nil, &block)
        raise ArgumentError.new("requires a name") if name.nil?

        matching_scenario = find_scenario(metadata[:current_feature], name)

        if matching_scenario
          if matching_scenario.tags.include?('updated')
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
              pending "Scenario has been marked as updated\n" +
                "    #  Update specs for this scenario and remove the @updated tag\n" +
                "    #  Scenario file: '#{feature_path}'"
            end
          elsif matching_scenario.arguments
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

      private

      def find_scenario(feature, name)
        feature.scenarios.find do |scenario|
          scenario.name == name
        end
      end
    end
  end
end
