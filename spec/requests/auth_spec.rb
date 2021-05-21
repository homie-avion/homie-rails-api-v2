require 'rails_helper'
require 'json'

RSpec.describe "Auth", type: :request do

  describe "Signing Up" do

    before do
      @role = create :role, :tenant
      @newUser = {username: "test", email:"test@gmail.com", password: "Applepen123", confirm_password: "Applepen123", role_id: @role.id}
      @duplicateUser = @newUser
      @passwordsDoesNotMatch = { username: "test1", email:"test1@gmail.com", password: "Applepen123", confirm_password: "agentOrange123", role_id: @role.id }
    end
    
    it "Should sign-up a user" do
      post users_url, params: @newUser, as: :json
      puts response.inspect
      expect(response.status).to eq(200)
    end

    it "Shouldn't sign-up a duplicate user" do
      post users_url, params: @newUser, as: :json
      post users_url, params: @duplicateUser, as: :json
      expect(response.status).to eq(422)
    end

    it "Shouldn't sign-up a request with passwords that does not match" do
      post users_url, params: @passwordsDoesNotMatch, as: :json
      expect(response.status).to eq(422)
    end

  end

  describe "Logging In" do
    before do
      # Create a user in test database
      @role = create :role, :tenant
      @user = create :user, :user1, role_id: @role.id
    end

    it "Should log-in a valid user" do
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      # puts response.inspect
      expect(response.status).to eq(200)
    end

    it "Shouldn't log-in an invalid user" do
      post login_url, params: {email: "sadasd@gmail.com", password: "sadasdasdas" }, as: :json
      # puts eval(@response.body)[:token]
      expect(response.status).to eq(422)
    end
  end

  describe "Auto Log-in" do
    before do
      #  create user in db

      @role = create :role, :tenant
      @user = create :user, :user1, role_id: @role.id
      # log in a user
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      @token = JSON.parse(response.body)["token"]

    end

    it "Should auto log-in a valid user" do
      get auto_login_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
      expect(response.status).to eq(200)
    end

    it "Shouldn't auto log-in in an invalid user" do
      get auto_login_url, headers: { "Authorization" => "Bearer ewqfeqfqwrqqweqqw" }, as: :json
      expect(response.status).to eq(401)
    end
  end

  # describe "Update Current User (In Session)" do
  # end

  # describe "Delete Current User (In Session)" do
  # end

end
