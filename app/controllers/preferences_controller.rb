class PreferencesController < ApplicationController
  before_action :authorized
  before_action :get_preferences
  # before_action :preference_params
  def do_get_preferences
    get_preferences

    render json: {
      data: {
        preferences: { 
          city: @cities,
          rent: @rents,
          stay_period: @stay_periods,
          property_type: @property_types
        }
      }
    }
  end

  def do_update_preferences
    
    # puts preference_params
    ActiveRecord::Base.transaction do
      update_preferences(params["preference"][:city], @cities , City, CityPreference, "city_id")
      update_preferences(params["preference"][:rent], @rents , Rent, RentPreference, "rent_id")
      update_preferences(params["preference"][:stay_period], @stay_periods , StayPeriod, StayPeriodPreference, "stay_period_id")
      update_preferences(params["preference"][:property_type], @property_types , PropertyType, PropertyTypePreference, "property_type_id")
      get_preferences
    end

    render json: {
      data: {
        preferences: { 
          city: @cities,
          rent: @rents,
          stay_period: @stay_periods,
          property_type: @property_types
        }
      },
      message: "User Preferences updated.",
      status: "Success",
    }
  end

  private
    # preference_params[:city], @cities , City, CityPreference, city_id
    def update_preferences(params, old_params, model, model_preference, id_name)
      if params != nil# if new or non-existing
        new_ids = params - old_params
        ids_to_remove = old_params - params

        #identify which to create and identify which to delete
        if new_ids.length > 0
          new_ids.each do | value |
            indicator = model.find_by(id:value)
            # puts value, model.exists?(value)
            if indicator != nil then model_preference.create(user_id:@user.id, id_name => value) end
          end
        end

        if ids_to_remove.length > 0
          ids_to_remove.each do | value |
            indicator = model_preference.find_by(user_id:@user.id, id_name => value)
            # print id_name," ", value," ", model.exists?(value)," ", indicator.inspect
            # puts ""
            if indicator != nil then indicator.destroy end
          end
        end
      end
    end

    def get_preferences
      @cities = @user.cities.pluck(:id)
      @rents = @user.rents.pluck(:id)
      @stay_periods = @user.stay_periods.pluck(:id)
      @property_types = @user.property_types.pluck(:id)
    end

    # def preference_params
    #   return params["preference"].permit(:city, :rent, :stay_period, :property_type)
    # end
end
