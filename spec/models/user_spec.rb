require 'rails_helper'

RSpec.describe User, type: :model do

  context "ActiveModel validations" do
    it { expect(described_class.new).to validate_presence_of(:username) }
    it { expect(described_class.new).to validate_presence_of(:email) }
    it { expect(described_class.new).to validate_presence_of(:password_digest) }
  end

  # context "ActiveRecord associations" do
  #   it { should belong_to(:role) }
  #   it { should have_many(:stocks) }
  #   it { should have_many(:markets) }
  #   it { should have_many(:transactions) }
  #   it { should have_many(:sale) }
  #   it { should have_many(:purchases) }
  # end

end
