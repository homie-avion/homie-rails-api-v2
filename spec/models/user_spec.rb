require 'rails_helper'

RSpec.describe User, type: :model do

  context "ActiveModel validations" do
    it { expect(described_class.new).to validate_presence_of(:username) }
    it { expect(described_class.new).to validate_presence_of(:email) }
    it { expect(described_class.new).to validate_presence_of(:password_digest) }
  end

  context "ActiveRecord associations" do
    it { should belong_to(:role) }

    it { should have_many(:properties) }
    it { should have_many(:chats) }
    it { should have_many(:user) }
    it { should have_many(:partner) }
    it { should have_many(:city_preferences) }
    it { should have_many(:cities) }
  end

end
