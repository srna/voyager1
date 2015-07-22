require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  context "without profile" do
    let (:user) { create(:user) }
    before do
      sign_in user
    end
    describe "GET #new" do
      before do
        get :new
      end
      it "redirects to profiles#show" do
        expect(response).to redirect_to(profile_path)
      end
    end
  end

  context "with profile" do
    let (:user) { build(:user) }
    let (:profile) { build :profile }
    before do
      user.profile = profile
      user.save
      sign_in user
    end

    describe 'GET #new' do
      before do
        get :new
      end
      it 'returns http success' do
        expect(response).to be_success
      end
    end
  end
end
