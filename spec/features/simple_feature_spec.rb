require 'spec_helper'

feature 'A simple feature' do
  # ensure background is executed as before(:each)
  background do
    @number ||= 41
    @number += 1 
  end

  scenario 'A simple scenario' do
    expect(@number).to eq(42)
  end
end
