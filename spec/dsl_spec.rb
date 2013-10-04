require 'spec_helper'

describe RspecGherkin::DSL do
  let(:context) { stub.tap { |s| s.extend(RspecGherkin::DSL) }}
  let(:an_object) { Object.new.tap { |o| o.extend(RspecGherkin::Execute) }}
  describe '.steps_for' do
    before do
      ::RSpec.stub(:configure)
    end

    it 'creates a new module and adds steps to it' do
      mod = context.steps_for(:foo) do
        step("foo") { "foo" }
      end
      an_object.extend mod
      an_object.step("foo").should == "foo"
    end

    it 'remembers the name of the module' do
      mod = context.steps_for(:foo) {}
      mod.tag.should == :foo
    end

    it 'tells RSpec to include the module' do
      config = stub
      RSpec.should_receive(:configure).and_yield(config)
      config.should_receive(:include)

      context.steps_for(:foo) {}
    end

    it 'warns of deprecation when called with :global' do
      context.should_receive(:warn)
      mod = context.steps_for(:global) do
        step("foo") { "foo" }
      end
      an_object.extend RspecGherkin::Steps
      an_object.step("foo").should == "foo"
    end
  end

  describe '.step' do
    it 'adds steps to RspecGherkin::Steps' do
      context.step('this is a test') { "foo" }
      context.step('this is another test') { "bar" }
      an_object.extend RspecGherkin::Steps
      an_object.step("this is a test").should == "foo"
    end
  end

  describe '.placeholder' do
    before { RspecGherkin::Placeholder.send(:placeholders).clear }

    it 'registers the placeholder globally' do
      context.placeholder('example') { true }
      RspecGherkin::Placeholder.send(:placeholders).should have_key('example')
    end
  end
end
