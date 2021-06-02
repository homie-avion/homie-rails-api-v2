require 'rails_helper'
require 'json'
RSpec.describe "Models : User's Preferences", type: :request do
  context "Requests" do
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

      (1..20).each do |id|
        create(:random_property,
          user_id: [@user.id, @partner.id].sample, 
          city_id: City.all.pluck(:id).sample, 
          rent_id: Rent.all.pluck(:id).sample, 
          stay_period_id: StayPeriod.all.pluck(:id).sample, 
          property_type_id: PropertyType.all.pluck(:id).sample
        )
      end

      # log in a user
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      @token = JSON.parse(response.body)["token"]
      @auth = { "Authorization" => "Bearer #{@token}" }

      # 
      @user_input_prefer = {city: [City.find_by(name: "Makati City").id, City.find_by(name: "Quezon City").id],
                                rent: [Rent.all.pluck(:id).sample], 
                                stay_period: [StayPeriod.all.pluck(:id).sample],
                                property_type_id:[]}
      @user_input_prefer2 = {city: [City.find_by(name: "Mandaluyong City").id, City.find_by(name: "Quezon City").id],
                                rent: [Rent.all.pluck(:id).sample], 
                                stay_period: [StayPeriod.all.pluck(:id).sample],
                                property_type_id:[PropertyType.all.pluck(:id).sample]}
    end
  
    it "Should get user info and preferences during sign up : must be empty" do
      
      newUser = {username: "test",
        email:"test@gmail.com", 
        password: "Applepen123", 
        confirm_password: "Applepen123", 
        role_id: @user_role.id, 
        role:@user_role.name # comes from react
      }

      post users_url, params: newUser, as: :json
      # puts response.inspect
      data = JSON.parse(response.body)["data"]
      expect(response.status).to eq(200)
      expect(data["preferences"]["city"].length).to eq(0) 
      expect(data["preferences"]["rent"].length).to eq(0) 
      expect(data["preferences"]["stay_period"].length).to eq(0) 
      expect(data["preferences"]["property_type"].length).to eq(0) 
    end

    it "Should get user info and preferences during login and auto-login" do
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      # puts response.inspect
      token = JSON.parse(response.body)["token"]
      data = JSON.parse(response.body)["data"]
      expect(response.status).to eq(200)
      expect(data["preferences"]["city"].length).to eq(0) 
      expect(data["preferences"]["rent"].length).to eq(0) 
      expect(data["preferences"]["stay_period"].length).to eq(0) 
      expect(data["preferences"]["property_type"].length).to eq(0) 

      get auto_login_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
      data = JSON.parse(response.body)["data"]
      expect(response.status).to eq(200)
      expect(data["preferences"]["city"].length).to eq(0) 
      expect(data["preferences"]["rent"].length).to eq(0) 
      expect(data["preferences"]["stay_period"].length).to eq(0) 
      expect(data["preferences"]["property_type"].length).to eq(0) 
    end


    it "Should create, and update user preference" do
      post login_url, params: {email: @user.email, password: @user.password }, as: :json
      token = JSON.parse(response.body)["token"]
      data = JSON.parse(response.body)["data"]
      # puts data

      post do_update_preferences_url, params: @user_input_prefer, headers: { "Authorization" => "Bearer #{@token}"}, as: :json

      get auto_login_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
      data = JSON.parse(response.body)["data"]
      # puts data
      expect(data["preferences"]["city"]).to match_array(@user_input_prefer[:city]) 
      expect(data["preferences"]["rent"]).to match_array(@user_input_prefer[:rent]) 
      expect(data["preferences"]["stay_period"]).to match_array(@user_input_prefer[:stay_period]) 
      expect(data["preferences"]["property_type"]).to match_array(@user_input_prefer[:property_type])

      post do_update_preferences_url, params: @user_input_prefer, headers: { "Authorization" => "Bearer #{@token}"}, as: :json

      get auto_login_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
      data = JSON.parse(response.body)["data"]
      # puts data
      expect(data["preferences"]["city"]).to match_array(@user_input_prefer[:city]) 
      expect(data["preferences"]["rent"]).to match_array(@user_input_prefer[:rent]) 
      expect(data["preferences"]["stay_period"]).to match_array(@user_input_prefer[:stay_period]) 
      expect(data["preferences"]["property_type"]).to match_array(@user_input_prefer[:property_type]) 


      post do_update_preferences_url, params: @user_input_prefer2, headers: { "Authorization" => "Bearer #{@token}"}, as: :json

      get auto_login_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
      data = JSON.parse(response.body)["data"]
      # puts data
      expect(data["preferences"]["city"]).to match_array(@user_input_prefer2[:city]) 
      expect(data["preferences"]["rent"]).to match_array(@user_input_prefer2[:rent]) 
      expect(data["preferences"]["stay_period"]).to match_array(@user_input_prefer2[:stay_period]) 
      expect(data["preferences"]["property_type"]).to match_array(@user_input_prefer2[:property_type])
    end

  end
end
