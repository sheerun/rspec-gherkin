# This feature should be marked as pending
# because it is tagged as @updated in gherkin
feature 'Feature with updated scenario' do
  scenario 'Updated scenario' do
    expect(1).to eq(1)
  end

  scenario 'Attack another monster' do
    expect(1).to eq(1)
  end
end
