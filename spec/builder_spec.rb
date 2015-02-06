describe RSpecGherkin::Builder, unit: true do
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

  context 'with background' do
    let(:feature_file) { File.expand_path('../example_project/features/simple_feature.feature', File.dirname(__FILE__)) }
    let(:builder) { RSpecGherkin::Builder.build(feature_file) }
    let(:feature) { builder.features.first }

    it 'extracts background' do
      expect(feature.backgrounds.first.name).to eq 'a simple background'
    end
  end

  context 'with tags' do
    let(:feature_with_feature_tag) { File.expand_path('../example_project/features/updated_feature.feature', File.dirname(__FILE__)) }
    let(:feature_with_scenario_tag) { File.expand_path('../example_project/features/updated_scenario.feature', File.dirname(__FILE__)) }

    it 'extracts feature level tags' do
      builder = RSpecGherkin::Builder.build(feature_with_feature_tag)
      expect(builder.features.first.tags).to include('updated')
    end

    it 'extracts scenario level tags' do
      builder = RSpecGherkin::Builder.build(feature_with_scenario_tag)

      expect(builder.features.first.scenarios.first.tags).to include('updated')
    end
  end

end

