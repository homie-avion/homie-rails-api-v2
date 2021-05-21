require 'rails_helper'

RSpec.describe Property, type: :model do

  context "ActiveModel validations" do
    it { expect(described_class.new).to validate_presence_of(:name) }
  end

  context "ActiveRecord associations" do
    it { should have_many(:posts) }
  end

  context "create property type" do
    let(:condominium){ create :name, :condominium }
    let(:other){ Property.create(name: "other") }

    it { expect(condominium.errors).to be_empty }
    it { expect(other.errors.messages[:name][0]).to eq "other is not a valid property" }
  end

end