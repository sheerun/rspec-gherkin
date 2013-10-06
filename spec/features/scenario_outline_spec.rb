require 'spec_helper'

feature 'using scenario outlines' do
  scenario 'a simple outline' do |hp, damage, state, happy|
    puts "example: #{hp}, #{damage}, #{state}, #{happy}"
    expect(1).to eq(1)
  end
end
