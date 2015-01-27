require 'spec_helper'

describe RSpecGherkin::Builder do
  context "with scenario outlines" do
    let(:feature_file) { File.expand_path('../example_project/features/scenario_outline.feature', File.dirname(__FILE__)) }
    let(:builder) { RSpecGherkin::Builder.build(feature_file) }
    let(:feature) { builder.features.first }

    it "extracts scenario" do
      expect(feature.scenarios.map(&:name)).to eq(['a simple outline', 'a simple outline'])
    end

    it "add additional arguments to scenarios" do
      expect(feature.scenarios[0].arguments).to eq([10.0, 13, "dead", false])
      expect(feature.scenarios[1].arguments).to eq([8.0, 5, "alive", true])
    end
  end
end
