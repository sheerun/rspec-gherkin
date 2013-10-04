module RspecGherkin
  module DSL
    def placeholder(name, &block)
      RspecGherkin::Placeholder.add(name, &block)
    end

    def step(description, &block)
      RspecGherkin::Steps.step(description, &block)
    end

    def steps_for(tag, &block)
      if tag.to_s == "global"
        warn "[RspecGherkin] using steps_for(:global) is deprecated, add steps to RspecGherkin::Steps instead"
        RspecGherkin::Steps.module_eval(&block)
      else
        Module.new do
          singleton_class.send(:define_method, :tag) { tag }
          module_eval(&block)
          ::RSpec.configure { |c| c.include self, tag => true }
        end
      end
    end
  end
end
