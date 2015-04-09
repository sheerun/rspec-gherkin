feature 'using scenario outlines' do
  scenario 'a simple outline' do |hp, damage, state, happy|
    expect(hp).to be_a(Float)
    expect(damage).to be_a(Fixnum)
    expect(state).to be_a(String)
    expect([true, false]).to include happy
  end
end
