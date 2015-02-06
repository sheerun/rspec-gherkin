describe RSpecGherkin, unit:true do
  let(:feature_path) { '/project/features/awesome-def_file.feature' }
  let(:spec_path) { '/project/spec/features/awesome-def_file_spec.rb' }

  let(:short_feature_path) { 'features/awesome-def_file.feature' }
  let(:short_spec_path) { 'spec/features/awesome-def_file_spec.rb' }

  context '#feature?' do
    it 'recognizes if path is feature path' do
      expect(RSpecGherkin.feature?(feature_path)).to eq(true)
    end

    it 'recognizes if path is not feature path' do
      expect(RSpecGherkin.feature?(spec_path)).to eq(false)
    end
  end

  context '#feature_spec?' do
    it 'recognizes if path is spec path' do
      expect(RSpecGherkin.feature_spec?(spec_path)).to eq(true)
    end

    it 'recognizes if path is not spec path' do
      expect(RSpecGherkin.feature_spec?(feature_path)).to eq(false)
    end
  end

  context '#feature_to_spec' do
    it 'properly translates feature file to spec file' do
      expect(RSpecGherkin.feature_to_spec(feature_path)).to eq(spec_path)
    end

    it 'excludes prefix when requested' do
      expect(RSpecGherkin.feature_to_spec(feature_path, false)).
        to eq(short_spec_path)
    end
  end

  context '#spec_to_feature' do
    it 'properly translates spec file to feature file' do
      expect(RSpecGherkin.spec_to_feature(spec_path)).
        to eq(feature_path)
    end

    it 'excludes prefix when requested' do
      expect(RSpecGherkin.spec_to_feature(spec_path, false)).
        to eq(short_feature_path)
    end
  end

  specify '#spec_to_feature and #feature_to_spec should be independent' do
    p1 = RSpecGherkin.feature_to_spec(RSpecGherkin.spec_to_feature(spec_path))
    p2 = RSpecGherkin.feature_to_spec(feature_path)
    expect(p1).to eq(p2)
  end
end
