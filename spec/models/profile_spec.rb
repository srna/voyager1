require 'rails_helper'

RSpec.describe Profile, type: :model do

  it { should validate_presence_of :agenda }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  context "validates e-mail address" do
    it "rejects wrong e-mail address" do
      profile = Profile.new(email: 'asdasd')
      profile.valid?
      expect(profile.errors[:email]).to include 'is invalid'
    end
    it "accepts right e-mail address" do
      profile = Profile.new(email: 'asd@asd.com')
      profile.valid?
      expect(profile.errors[:email]).to be_empty
    end
  end
end
