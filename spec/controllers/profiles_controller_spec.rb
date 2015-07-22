require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  context "unauthenticated" do
    [:new, :edit, :show].each do |a|
      it "GET ##{a} redirects to login" do
        get a
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    [:create, :update, :destroy].each do |a|
      it "POST ##{a} redirects to login" do
        post a
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
