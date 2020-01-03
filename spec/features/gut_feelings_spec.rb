require 'rails_helper'

describe 'As a user' do
  describe 'when I visit the gut feelings page' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(@user)
      
    end


  end
end
