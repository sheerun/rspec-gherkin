require 'spec_helper'

feature 'Missing feature' do
  scenario 'This should never be executed' do
    raise 'Scenario in spec with missing feature should not be executed'
  end
end
