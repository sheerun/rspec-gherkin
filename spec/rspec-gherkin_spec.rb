describe RspecGherkin do
  let(:feature_path) { '/project/features/awesome-def_file.feature' }
  let(:spec_path) { '/project/spec/features/awesome-def_file_spec.rb' }

  context '#feature?' do
    it 'recognizes if path is feature path' do
      expect(RspecGherkin.feature?(feature_path)).to eq(true)
    end

    it 'recognizes if path is not feature path' do
      expect(RspecGherkin.feature?(spec_path)).to eq(false)
    end
  end

  context '#feature_to_spec' do
    it 'properly translates feature file to spec file' do
      expect(RspecGherkin.feature_to_spec(feature_path)).to eq(spec_path)
    end
  end

  context '#spec_to_feature' do
    it 'properly translates spec file to feature file' do
      expect(RspecGherkin.spec_to_feature(spec_path)).to eq(feature_path)
    end
  end

  specify '#spec_to_feature and #feature_to_spec should be idempotent' do
    p1 = RspecGherkin.feature_to_spec(RspecGherkin.spec_to_feature(spec_path))
    p2 = RspecGherkin.feature_to_spec(feature_path)
    expect(p1).to eq(p2)
  end
end
