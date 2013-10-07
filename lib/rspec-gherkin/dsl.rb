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
              pending 'No matching feature file'
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
          it do
            example.metadata[:description_args] = ""
            pending "No matching scenario: '#{name}'"
          end
        end
      end
    end
  end
end
