require 'rails_helper'
require 'json'

RSpec.describe "Properties API:", type: :request do

  describe "REQUESTS" do
    before do
      # create role, user, city, rent, stay_period, property_type, property
      @role = create :role, :partner_role
      @user = create :user, :user1, role_id: @role.id
      @city = create :city, :makati
      @city_1 = create :city, :quezon
      @rent = create :rent, :price1
      @stay_period = create :stay_period, :months6
      @property_type = create :property_type, :condo 
      @property = create :property, :sample_property, user_id: @user.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      @property_params = attributes_for :property, :sample_property, user_id: @user.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      
      # log in a user
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      @token = JSON.parse(response.body)["token"]
      @auth = { "Authorization" => "Bearer #{@token}" }
    end
    
    # GET /properties
    it "GET /properties should get the properties of a valid user" do
      get properties_url, headers: @auth , as: :json

      place_name = JSON.parse(response.body)["data"][0]
      
      expect(response.status).to eq(200)
      expect(place_name["name"]).to eq(@property.name)
      expect(place_name["user_id"]).to eq(@user.id)
    end

    # GET /properties
    it "GET /properties should NOT get the properties of a valid user" do
      get properties_url
      
      expect(response.status).to eq(401)
      # expect(response.body).to eq(200)
      expect(JSON.parse(response.body)["message"]).to eq("Unauthorized access. Please log in")
    end

    # GET /properties/1
    it "GET /properties/:id should get a property of a valid user" do
      get property_url(id: @property.id), headers: @auth , as: :json
      place_name = JSON.parse(response.body)["data"]
      # puts place_name
      expect(response.status).to eq(200)
      expect(place_name["name"]).to eq(@property.name)
      expect(place_name["user_id"]).to eq(@user.id)
    end

    it "GET /properties/:id should NOT get a property if not existing" do
      get property_url(id: 101), headers: @auth , as: :json
      msg = JSON.parse(response.body)["message"]
      
      expect(response.status).to eq(404)
      expect(msg).to eq("Property not found.")
    end

    # POST /properties
    it "POST /properties should create a property" do
      post properties_url, headers: @auth, params: @property_params, as: :json
      place_name = JSON.parse(response.body)["data"]

      expect(response.status).to eq(201)
      expect(place_name["name"]).to eq(@property.name)
      expect(place_name["user_id"]).to eq(@user.id)
    end

    # PATCH/PUT /properties/1
    it "PATCH/PUT /properties/:id should edit/update a property" do
      patch property_url(id: @property.id), params: {city_id: @city_1.id}, headers: @auth , as: :json
      place_name = JSON.parse(response.body)["data"]

      expect(response.status).to eq(200)
      expect(place_name["city_id"]).to eq(@city_1.id)
      expect(place_name["user_id"]).to eq(@user.id)
    end

    # DELETE /properties/1
    it "DELETE /properties/:id should delete a property" do  
      expect do
        delete property_url(id: @property.id),  headers: @auth, as: :json
        expect(response.status).to eq(200)
      end.to change { Property.count }.by(-1)
    end
  end
end
