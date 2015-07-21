require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  context "unauthenticated" do
    describe "GET #show" do
      it "redirects to login" do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #update" do
      it "redirects to login" do
        get :update
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "authenticated" do
    before do
      @user = create(:user)
      sign_in @user
    end
    describe 'GET #show' do
      it 'returns http success' do
        get :show
        expect(response).to be_success
      end
    end
  end

end
