module RspecGherkin
  module DSL
    module Global
      def feature(name = nil, &block)
        raise ArgumentError.new("requires a name") if name.nil?
        describe("Feature: #{name}", :feature => true, &block)
      end
    end

    module Rspec
      def background(&block)
        before(:each, &block)
      end

      def scenario(name = nil, &block)
        raise ArgumentError.new("requires a name") if name.nil?
        specify("Scenario: #{name}", &block)
      end
    end
  end
end
