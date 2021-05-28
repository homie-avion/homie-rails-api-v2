require 'rails_helper'

RSpec.describe "Chats:", type: :request do
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
      @message1 = create :message, :message1, chat_id: @chat.id
      @message1_params = attributes_for :message, :message1, chat_id: @chat.id

      @message2 = create :message, :message2, chat_id: @chat.id
      @message2_params = attributes_for :message, :message2, chat_id: @chat.id
      
      # single chat params
      @single_chat_params = {user_id: @user.id, partner_id: @partner.id, property_id: @property.id}
    end


    it "Should GET all chat by user_id" do
      get chats_url, headers: @auth1 , as: :json
      
      # puts JSON.parse(response.body)["data"][0]["id"]
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["data"][0]["id"]).to eq(@chat.id)
    end

    it "Should GET all chat by partner_id" do
      # puts get_all_chats_by_partner_id_url
      get chats_url, headers: @auth2 , as: :json
      # puts JSON.parse(response.body)["data"][0]["id"]
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["data"][0]["id"]).to eq(@chat.id)
    end

    it "Should GET a single chat with messages by chat_id" do
      get chat_url(id: @chat.id), headers: @auth1 , as: :JSON
      puts JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["data"]["chat"]["id"]).to eq(@chat.id)
    end

    it "Should POST chat by property_id, user_id, and partner_id" do
      post chats_url, headers: @auth1, params: @single_chat_params, as: :json
      chat = JSON.parse(response.body)["data"]

      expect(response.status).to eq(201)
      expect(chat["user_id"]).to eq(@user.id)
    end

    it "Should PUT/PATCH edit chat 'success' field and POST create Transaction" do
      patch chat_url(id: @chat.id), params: {success: true}, headers: @auth1, as: :json
      chat = JSON.parse(response.body)["data"]

      expect(response.status).to eq(200)
      expect(chat["success"]).to eq(true)
    end

    # it "Should PUT/PATCH edit disassociate user from chat (delete chat in user front end)" do
    #   patch chat_url(id: @chat.id), params: {user_id: nil}, headers: @auth1, as: :json
    #   chat = JSON.parse(response.body)["data"]
    #   puts response.body
    #   expect(response.status).to eq(200)
    #   expect(chat["user_id"]).to eq(nil)
    # end

    it "should delete chat and cascade delete messages" do
      expect(Message.count).to eq(2)
      expect do
        delete chat_url(id: @chat.id),  headers: @auth1, as: :json
        expect(response.status).to eq(200)
      end.to change { Chat.count }.by(-1)
      expect(Message.count).to eq(0)
    end
  end
end
