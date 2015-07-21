require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "validates presence of agenda" do
    should validate_presence_of :agenda
  end
  it "validates presence of email" do
    should validate_presence_of :email
  end
  it "validates presence of password" do
    should validate_presence_of :password
  end

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
