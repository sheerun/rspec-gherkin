require 'spec_helper'

describe RspecGherkin::Builder do
  context "with scenario outlines" do
    let(:feature_file) { File.expand_path('../features/scenario_outline.feature', File.dirname(__FILE__)) }
    let(:builder) { RspecGherkin::Builder.build(feature_file) }
    let(:feature) { builder.features.first }

    it "extracts scenario" do
      feature.scenarios.map(&:name).should eq([
        'a simple outline',
        'a simple outline'
      ])
    end

    it "add additional arguments to scenarios" do
      feature.scenarios[0].arguments.should eq([ 10.0, 13, "dead", false ])
      feature.scenarios[1].arguments.should eq([ 8.0, 5, "alive", true ])
    end
  end
end
