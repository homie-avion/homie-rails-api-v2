require 'rails_helper'

RSpec.describe "Chats and Messages:", type: :request do
  describe "GET /chat_and_messages" do
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
      @message2 = create :message, :message2, chat_id: @chat.id
      
    end


    i
  end
end
