feature 'Notification of update to specification' do
  before(:all) do
    @result = %x(rspec example_project/spec --tag feature --format documentation 2>&1)
  end

  context 'updated features and scenarios' do
    scenario 'recognizes and notifies when feature is marked as @updated' do
      expect(@result).to include('Feature has been marked as updated')
    end

    scenario 'recognizes and notifies when scenario is marked as @updated' do
      expect(@result).to include('Scenario has been marked as updated')
    end
  end
end