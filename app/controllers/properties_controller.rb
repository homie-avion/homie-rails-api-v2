class PropertiesController < ApplicationController
  before_action :authorized
  before_action :set_property, only: [:show, :update, :destroy]

  # GET /properties
  def index
    # @properties = Property.all
    @properties = Property.where(user_id: @user.id).order(created_at: :DESC).page(params[:page])

    render json: {
                  status: "Success",
                  message: "Properties loaded.",
                  data: @properties
                  }, status: :ok
  end

  def get_properties_based_on_preferences
    # puts params[:page]
    user_properties = Property.where(user_preferences_params).order(created_at: :DESC).page(params[:page])
    user_final = []
    user_properties.each { |item|
      user_properties1 = item.attributes.inject({}) { |new_hash, (key, value)|
        new_hash.merge(key=>value) 
      }
      user_properties1["username"] = item.user[:username]
      # puts item.user.inspect
      user_final.push(user_properties1)
    }

    render json: {
      status: "Success",
      message: "Properties loaded.",
      data: user_final,
      }, status: :ok
  end

  # GET /properties/1
  def show
    render json: {
      status: "Success",
      message: "Property loaded.",
      data: @property
      }, status: :ok
  end

  # GET /properties/1
  def get_property
    set_property_public

    user_properties1 = @property.attributes.inject({}) { |new_hash, (key, value)|
      new_hash.merge(key=>value) 
    }
    user_properties1["username"] = @property.user[:username]
    # puts item.user.inspect
      

    render json: {
      status: "Success",
      message: "Property loaded.",
      data: user_properties1
      }, status: :ok
  end

  # POST /properties
  def create
    @property = Property.new(property_params)

    if @property.save
      render json: {
                    status: "Success",
                    message: "Property created.",
                    data: @property
                    }, status: :created
    else
      render json: {
                    status: "Error",
                    message: "Property not created.",
                    data: @property.errors
                    }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /properties/1
  def update
    
    if @property.update(property_params)
      render json: {
                    status: "Success",
                    message: "Property updated.",
                    data: @property
                    }, status: :ok
    else
      render json: {
                    status: "Error",
                    message: "Property not updated.",
                    data: @property.errors
                    }, status: :unprocessable_entity
    end
  end

  # DELETE /properties/1
  def destroy
    if @property.present?
      @property.destroy
      render json: {
          status: "Success",
          message: "Property deleted.",
      }, status: :ok
    else
      render json: {
          status: "Error",
          message: "Property not deleted.",
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      # @property = Property.find(params[:id])
      @property = Property.where({id: params[:id], user_id: @user.id })
      return item_not_found
    end

    def set_property_public
      @property = Property.where(id: params[:id])
      return item_not_found
    end

    def item_not_found
      if @property.length == 0
        render json: {
                      status: "Error",
                      message: "Property not found.",
                      }, status: 404
      else
        @property = @property[0]
      end
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:name, :rent_price, :tenant_count, :property_count, :bldg_no, :street, :barangay, :complete_address, :picture_urls, :latitude, :longitude, :like_count, :watch_list_count, :homie_value, :cost_living_index, :flood_index, :posted, :user_id, :city_id, :rent_id, :stay_period_id, :property_type_id)
    end

    def user_preferences_params
      f_params = {}
      permitted_params = [:city_id, :rent_id, :stay_period_id, :property_type_id] 
      
      permitted_params.each do | value |
        if params[value] != nil
          f_params[value] = params[value]
          # puts f_params[value]
        end
      end
      return f_params
      # {city_id: params[:city_id], rent_id: params[:rent_id], stay_period_id: params[:stay_period_id], property_type_id: params[:property_type_id]}
    end
end
