require 'rails_helper'
require 'bill_app/connection'

RSpec.describe BillApp::Connection do
  it "can be initialized with a profile" do
    profile = build(:profile)
    ba = BillApp::Connection.new(profile)
    expect(ba.agenda).to eql profile.agenda
    expect(ba.email).to eql profile.email
    expect(ba.password).to eql profile.password
  end
  it "can be initialized with a hash" do
    profile_attributes = attributes_for(:profile)
    ba = BillApp::Connection.new(profile_attributes)
    expect(ba.agenda).to eql profile_attributes[:agenda]
    expect(ba.email).to eql profile_attributes[:email]
    expect(ba.password).to eql profile_attributes[:password]
  end
  it "accepts valid credentials" do
    ba = BillApp::Connection.new(attributes_for(:profile))
    expect(ba).to be_truthy
  end
end