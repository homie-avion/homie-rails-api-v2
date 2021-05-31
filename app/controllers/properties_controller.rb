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

  # GET /properties/1
  def show
    render json: {
      status: "Success",
      message: "Property loaded.",
      data: @property
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

    # def verify_user_from_required_params
    #   if @user.id != property_params[:user_id]
    #     render json: {
    #       status: "Error",
    #       message: "Unauthorized access.",
    #       }, status: :unauthorized 
    #   end
    # end

    # def verify_user_from_params
    #   if @user.id != params[:user_id]
    #     render json: {
    #       status: "Error",
    #       message: "Unauthorized access.",
    #       }, status: :unauthorized 
    #   end
    # end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:name, :rent_price, :tenant_count, :property_count, :bldg_no, :street, :barangay, :complete_address, :picture_urls, :latitude, :longitude, :like_count, :watch_list_count, :homie_value, :cost_living_index, :flood_index, :posted, :user_id, :city_id, :rent_id, :stay_period_id, :property_type_id)
    end
end
