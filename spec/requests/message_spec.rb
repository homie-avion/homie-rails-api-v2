require 'rails_helper'

RSpec.describe "Message:", type: :request do
  describe "Requests" do
    before do
      # create role, user, city, rent, stay_period, property_type, property
      @user_role = create :role, :user_role
      @partner_role = create :role, :partner_role

      @user = create :user, :user1, role_id: @user_role.id
      @partner = create :user, :partner, role_id: @partner_role.id
      
      @city = create :city, :makati
      @city_1 = create :city, :quezon
 
      @rent = create :rent, :price1
      @stay_period = create :stay_period, :months6
      @property_type = create :property_type, :condo 
 
      @property = create :property, :sample_property, user_id: @partner.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      # @property_params = attributes_for :property, :sample_property, user_id: @user.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      
      # log in a user
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      @token1 = JSON.parse(response.body)["token"]
      @auth1 = { "Authorization" => "Bearer #{@token1}" }

      # log in a partner
      post login_url, params: {email: @partner.email, password: @partner.password }, as: :json
      @token2 = JSON.parse(response.body)["token"]
      @auth2 = { "Authorization" => "Bearer #{@token2}" }

      # create a chat
      @chat = create :chat, :sample_chat , user_id: @user.id, partner_id: @partner.id, property_id: @property.id

      # create message inside chat
      @message1 = create :message, :message1, chat_id: @chat.id, user_id: @user.id
      @message1_params = attributes_for :message, :message1, chat_id: @chat.id, user_id: @user.id

      @message2 = create :message, :message2, chat_id: @chat.id, user_id: @partner.id
      @message2_params = attributes_for :message, :message2, chat_id: @chat.id, user_id: @partner.id
      
      # single chat params
      @single_chat_params = {user_id: @user.id, partner_id: @partner.id, property_id: @property.id}
    end


    it "Should GET all messages by user_id" do
      get messages_url, headers: @auth1 , as: :json
      
      # puts JSON.parse(response.body)["data"][0]["id"]
      expect(response.status).to eq(200)
      # puts JSON.parse(response.body)
      expect(JSON.parse(response.body)["data"][0]["id"]).to eq(@message1.id)
    end

    it "Should GET a single message by message_id" do
      get message_url(id: @message1.id), headers: @auth1 , as: :JSON
      # puts JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["data"]["content"]).to eq(@message1.content)
    end

    it "Should POST message" do
      post messages_url, headers: @auth1, params: @message1_params, as: :json
      message = JSON.parse(response.body)["data"]

      expect(response.status).to eq(201)
      expect(message["user_id"]).to eq(@user.id)
    end

    it "Should PUT/PATCH edit message content" do
      patch message_url(id: @message1.id), params: {content: "hello"}, headers: @auth1, as: :json
      message = JSON.parse(response.body)["data"]
      # puts response.body
      expect(response.status).to eq(200)
      expect(message["content"]).to eq("hello")
    end

    it "should delete message" do
      expect do
        delete message_url(id: @message1.id),  headers: @auth1, as: :json
        expect(response.status).to eq(200)
      end.to change { Message.count }.by(-1)
    end
  end
end
