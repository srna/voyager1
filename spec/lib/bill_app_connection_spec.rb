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

  context 'requests' do
    let(:profile) { build(:profile) }
    let(:ba) { BillApp::Connection.new(profile) }
    context 'invoices' do
      it 'can be listed' do
        expect(ba.invoices).to be_an_instance_of(Hash)
      end
      it 'can be retrieved' do
        expect(ba.invoice(123)).to be_an_instance_of(BillApp::Invoice)
      end
      it 'has lines' do
        expect(ba.invoice(353).lines).to be_an_instance_of(Array)
      end
    end
    context 'contacts' do
      it 'can be retrieved' do
        expect(ba.contact(567)).to be_an_instance_of(BillApp::Contact)
      end
    end
  end
end
