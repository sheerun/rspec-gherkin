module RspecGherkin
  module DSL
    def feature(name, &block)
      # RspecGherkin::Feature.add(name, &block)
      context(name, &block)
    end

    def scenario(name, &block)
      # RspecGherkin::Scenario.add(name, &block)
      context(name, &block)
    end
  end
end
