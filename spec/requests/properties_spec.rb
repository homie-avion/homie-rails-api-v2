require 'rails_helper'
require 'json'

RSpec.describe "Properties API:", type: :request do

  context "REQUESTS" do

    before do
      cities = City.create([
        {name: "Quezon City", latitude: 14.6760, longitude: 121.0437}, 
        {name: "Makati City", latitude: 14.5547, longitude: 121.0244},
        {name: "Mandaluyong City", latitude: 14.5794, longitude: 121.0359},
        {name: "San Juan City", latitude: 14.6019, longitude: 121.0355},
        {name: "Taguig City", latitude: 14.5176, longitude: 121.0509},
        {name: "Pasig City", latitude: 14.5764, longitude: 121.0851},
        {name: "Marikina City", latitude: 14.6507, longitude: 121.1029},
        {name: "Parañaque City",latitude: 14.4793, longitude: 121.0198},
        {name: "Pasay City", latitude: 14.5378, longitude: 121.0014},
        {name: "Manila City", latitude: 14.5995, longitude: 120.9842}
        ])
  
      rents = Rent.create([
            {name: "Less than 10K Php"},
            {name: "Between 10K to 15K Php"},
            {name: "Between 15K to 20K Php"},
            {name: "20K php and up"}
            ])
  
      stay_periods  = StayPeriod.create([
            {name: "Up to 6 months"},
            {name: "Maximum of 1 year"}
          ])
  
      property_type = PropertyType.create([
              {name: "Condominium"},
              {name: "Townhouse"},
              {name: "Dormitory"}
            ])
      # create role, user, city, rent, stay_period, property_type, property
      @user_role = create :role, :user_role
      @partner_role = create :role, :partner_role

      @user = create :user, :user1, role_id: @user_role.id
      @partner = create :user, :partner, role_id: @partner_role.id
      
      @city = City.find_by(name: "Makati City")
      @city_1 = City.find_by(name: "Quezon City")
      @rent = Rent.find_by(name: "Between 15K to 20K Php")
      @stay_period = StayPeriod.find_by(name: "Maximum of 1 year")
      @property_type = PropertyType.find_by(name: "Condominium")

      # @property = create :property, :sample_property, user_id: @user.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      @property = create :random_property, user_id: @user.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      
      # @properties = create_list :random_property, 20,
      #                   user_id: @user.id,
      #                   city_id: City.all.pluck(:id).sample, 
      #                   rent_id: Rent.all.pluck(:id).sample, 
      #                   stay_period_id: StayPeriod.all.pluck(:id).sample, 
      #                   property_type_id: PropertyType.all.pluck(:id).sample
      (1..20).each do |id|
        create(:random_property,
          user_id: [@user.id, @partner.id].sample, 
          city_id: City.all.pluck(:id).sample, 
          rent_id: Rent.all.pluck(:id).sample, 
          stay_period_id: StayPeriod.all.pluck(:id).sample, 
          property_type_id: PropertyType.all.pluck(:id).sample
        )
      end

      @property_params = attributes_for :property, :sample_property, user_id: @user.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      
      # log in a user
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      @token = JSON.parse(response.body)["token"]
      @auth = { "Authorization" => "Bearer #{@token}" }

      # 
      @user_based_peferences = {city_id: [1,2],
                                rent_id: Rent.all.pluck(:id).sample, 
                                stay_period_id: StayPeriod.all.pluck(:id).sample,
                                property_type_id: nil}
    end
    
    # GET /properties
    it "GET /properties should get the properties of a valid user" do
      get properties_url({page: 1}), headers: @auth , as: :json

      place_name = JSON.parse(response.body)["data"]
      # puts JSON.parse(response.body)["data"]
      expect(response.status).to eq(200)
      expect(place_name.length).to eq(5)
      # expect(place_name["user_id"]).to eq(@user.id)
    end

    # GET /properties
    it "GET /properties should NOT get the properties of a valid user" do
      get properties_url
      
      expect(response.status).to eq(401)
      # expect(response.body).to eq(200)
      expect(JSON.parse(response.body)["message"]).to eq("Unauthorized access. Please log in")
    end

    # GET /properties
    it "GET /properties should get the properties based on user preferences " do
      get get_properties_based_on_preferences_url(@user_based_peferences, page:1), headers: @auth , as: :json
      # puts Property.count
      # puts @user_based_peferences
      place_name = JSON.parse(response.body)["data"]
      # puts JSON.parse(response.body)["data"]
      expect(response.status).to eq(200)
      expect(place_name.length).to eq(5)
      # expect(place_name["user_id"]).to eq(@user.id)
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
      expect(place_name["name"]).to eq(@property_params[:name])
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
