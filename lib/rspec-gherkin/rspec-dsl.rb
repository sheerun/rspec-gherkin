
class << self
  def feature(name = nil, new_metadata = {}, &block)
    raise ArgumentError.new("requires a name") if name.nil?

    new_metadata = ::RSpec.configuration.feature_metadata.merge(new_metadata)
    matching_feature = find_feature(name)

    if matching_feature
      if matching_feature.tags.include?('updated')
        pending_feature(name, new_metadata, block.source_location,
                        "Feature has been marked as updated\n \t# Update specs for this feature and remove the @updated tag\n \t# Feature file: '#{feature_path(block.source_location)}"
        )
      else
        describe("Feature: #{name}", new_metadata.merge(:current_feature => matching_feature), &block)
      end
    else
      pending_feature(name, new_metadata, block.source_location, "No such feature in '#{feature_path(block.source_location)}'")
    end
  end

  private

  def find_feature(name)
    RSpecGherkin.features.find do |feature|
      feature.name == name
    end
  end

  def feature_path(spec_location)
    RSpecGherkin.spec_to_feature(spec_location.first, false)
  end

  def pending_feature(name, new_metadata, spec_location, reason)
    describe "Feature: #{name}", new_metadata do
      it do |example|
        example.metadata.merge!(
            file_path: spec_location[0],
            location: "#{spec_location[0]}:#{spec_location[1]}"
        )
        pending reason
        raise "pending"
      end
    end
  end
end

module RSpecGherkin
  module DSL
    module Rspec
      def background(&block)
        before(:each, &block)
      end

      def scenario(name = nil, new_metadata = {}, &block)
        raise ArgumentError.new("requires a name") if name.nil?

        matching_scenario = find_scenario(self.metadata[:current_feature], name)

        if matching_scenario
          if matching_scenario.tags.include?('updated')
            pending_scenario(name, new_metadata, block.source_location,
                             "Scenario has been marked as updated\n \t# Update specs for this scenario and remove the @updated tag\n \t# Feature file: '#{feature_path(block.source_location)}'"
            )
          elsif matching_scenario.arguments
            specify "Scenario: #{name}", new_metadata do
              instance_exec(*matching_scenario.arguments, &block)
            end
          else
            specify("Scenario: #{name}", new_metadata, &block)
          end
        else
          pending_scenario(name, new_metadata, block.source_location, "No such scenario in '#{feature_path(block.source_location)}'")
        end
      end

      private

      def find_scenario(feature, name)
        feature.scenarios.find do |scenario|
          scenario.name == name
        end
      end

      def feature_path(spec_location)
        RSpecGherkin.spec_to_feature(spec_location.first, false)
      end

      def pending_scenario(name, new_metadata, spec_location, reason)
        specify name, new_metadata do |example|
          example.metadata.merge!(
              full_description: "Scenario: #{name}",
              location: "#{spec_location[0]}:#{spec_location[1]}"
          )
          pending reason
          raise('pending')
        end
      end
    end
  end
end
