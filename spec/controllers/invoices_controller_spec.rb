require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  context "unauthenticated" do
    [:new, :index].each do |a|
      it "GET ##{a} redirects to login" do
        get a
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  context "authenticated" do
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

      describe 'GET #import' do
        it 'creates an invoice' do
          expect { get :import, id: 1234 }.to change{ Invoice.all.count }.by(1)
        end
      end

      describe 'other user\'s invoices' do
        let(:user1) { create(:user_with_profile) }
        let(:user2) { create(:user_with_profile) }
        before do
          sign_in user1
          invoice = create(:invoice)
          invoice.profile = user1.profile
          invoice.save
          sign_in user2
        end
        it 'can\'t see' do
          bypass_rescue
          expect{get :show,
                     { id: Invoice.last.id }}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
