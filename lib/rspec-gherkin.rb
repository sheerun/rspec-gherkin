require "rspec-gherkin/builder"
require "rspec-gherkin/dsl"
require "rspec-gherkin/execute"
require "rspec-gherkin/rspec-loader"
require "rspec-gherkin/version"

module RSpecGherkin extend self

  class << self
    attr_accessor :features
  end

  class Pending < StandardError; end
  class Malformed < StandardError; end
  class Ambiguous < StandardError; end

  def feature?(path)
    !!path.match(mask_to_pattern(feature_mask))
  end

  def feature_spec?(path)
    !!path.match(mask_to_pattern(spec_mask))
  end

  def feature_to_spec(path)
    path.sub(mask_to_pattern(feature_mask), mask_to_replacement(spec_mask))
  end

  def spec_to_feature(path, prefix = true)
    path = path.match(mask_to_pattern(spec_mask))[0] unless prefix
    path.sub(mask_to_pattern(spec_mask), mask_to_replacement(feature_mask))
  end

  protected

  def spec_mask
    ::RSpec.configuration.feature_mapping[:spec]
  end

  def feature_mask
    ::RSpec.configuration.feature_mapping[:feature]
  end

  def mask_to_pattern(mask)
    Regexp.new("#{Regexp.escape(mask).sub("\\*\\*/\\*", '(.+)')}$")
  end

  def mask_to_replacement(mask)
    "#{mask.sub('**/*'){ '\\1' }}"
  end

end

RSpecGherkin.features = []

self.extend RSpecGherkin::DSL::Global

::RSpec.configure do |config|
  config.extend RSpecGherkin::DSL::Rspec
  config.pattern << ",**/*.feature"
  config.add_setting :feature_mapping
  config.feature_mapping = {
    :feature => 'features/**/*.feature',
    :spec => 'spec/features/**/*_spec.rb'
  }
end

::RSpec::Core::Configuration.send(:include, RSpecGherkin::RSpec::Loader)
