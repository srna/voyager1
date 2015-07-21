require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "should validate presence of agenda" do
    should validate_presence_of :agenda
  end
  it "should validate presence of email" do
    should validate_presence_of :email
  end
  it "should validate presence of password" do
    should validate_presence_of :password
  end

  context "should validate e-mail address" do
    it "should reject wrong e-mail address" do
      profile = Profile.new(email: 'asdasd')
      profile.valid?
      expect(profile.errors[:email]).to include 'is invalid'
    end
    it "should accept right e-mail address" do
      profile = Profile.new(email: 'asd@asd.com')
      profile.valid?
      expect(profile.errors[:email]).to be_empty
    end
  end
end
