require 'rails_helper'

RSpec.describe Role, type: :model do

  context "ActiveModel validations" do
    it { expect(described_class.new).to validate_presence_of(:name) }
  end

  context "ActiveRecord associations" do
    it { should have_many(:users) }
  end

  context "create roles" do
    let(:partners){ create :role, :partner_role }
    let(:other){ Role.create(name: "other") }

    it { expect(partners.errors).to be_empty }
    it { expect(other.errors.messages[:name][0]).to eq "other is not a valid role" }
  end

end