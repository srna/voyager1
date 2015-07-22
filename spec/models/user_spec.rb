require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe "with profile" do
    let(:uwp) { create(:user_with_profile) }
    it "has profile" do
      expect(uwp.profile).not_to be_nil
    end
  end
end
