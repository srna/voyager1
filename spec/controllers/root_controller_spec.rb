require 'spec_helper'

describe RootController, type: :controller do

  context "unauthenticated" do
    describe 'GET index' do
      it 'returns http success' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "authenticated" do
    before do
      @user = create(:user)
      sign_in @user
    end
    describe 'GET index' do
      it 'returns http success' do
        get :index
        expect(response).to be_success
      end
    end
  end

end
