module RspecGherkin
  module DSL
    module Global
      def feature(name, &block)
        describe("Feature: #{name}", :feature => true, &block)
      end
    end

    module Rspec
      def background(&block)
        before(:each, &block)
      end

      def scenario(name, &block)
        specify("Scenario: #{name}", &block)
      end
    end
  end
end
