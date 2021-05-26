require 'rails_helper'

RSpec.describe "CreateProperties", type: :request do

  describe "Create properties" do
    before do
      @role = create :role, :partner_role
      @user = create :user, :user1, role_id: @role.id
      @city = create :city, :makati
      @rent = create :rent, :price1
      @stay_period = create :stay_period, :months6
      @property_type = create :property_type, :condo 
      @property = attributes_for :property, :sample_property, user_id: @user.id, city_id: @city.id, rent_id: @rent.id, stay_period_id: @stay_period.id, property_type_id: @property_type.id
      
    end
    
    it "Should create a property" do
      # puts @property
    end
  end

end
