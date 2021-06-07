class UsersController < ApplicationController

  before_action :authorized, only: [:auto_login, :update, :destroy]

  # REGISTER
  def create
  
    if user_params[:password] != params[:confirm_password]
      render json: {
        message: "Passwords does not match.",
        status: "Error"}, status: :unprocessable_entity
    else
      
      role = Role.find_by(name: params[:role])

      @user = User.new(user_params)

      # puts @user.errors.inspect
      if @user.save && @user.role_id == role.id
        token = encode_token({user_id: @user.id})
        get_preferences
        include_role_name
        render json: {
          data: {
            user: @user,
            preferences: { 
              city: @cities,
              rent: @rents,
              stay_period: @stay_periods,
              property_type: @property_types
            },
            role: @role
          },
          message: "Account created.",
          status: "Success",
          token: token
        }
      else
        render json: {
          message: "Invalid email or password.",
          status: "Error"}, status: :unprocessable_entity
      end
    end
  end

  # LOGGING IN
  def login
    #
    @user = User.find_by(email: params[:email])

    if @user &&  @user.authenticate(params[:password])
      
      get_preferences
      include_role_name
      token = encode_token({user_id: @user.id})
      render json: {
        data: {
          user: @user,
          preferences: { 
            city: @cities,
            rent: @rents,
            stay_period: @stay_periods,
            property_type: @property_types
          },
          role: @role
        },
        message: "User successfully logged in.",
        status: "Success",
        token: token
      }
    else
      render json: {
        message: "Invalid email or password.",
        status:"Error"}, status: :unprocessable_entity
    end

  end


  def auto_login
    get_preferences
    include_role_name
    render json: {
      data: {
        user: @user,
        preferences: { 
          city: @cities,
          rent: @rents,
          stay_period: @stay_periods,
          property_type: @property_types
        },
        role: @role
      }
    }
  end

  # PATCH or PUT /user
  def update
    # check_user 
    get_preferences
    include_role_name
    if @user.update(user_params)
      render json: {
                    status: "Success",
                    message: "User updated.",
                    data: {
                      user: @user,
                      preferences: { 
                        city: @cities,
                        rent: @rents,
                        stay_period: @stay_periods,
                        property_type: @property_types
                      },
                      role: @role
                    }
                    }, status: :ok
    else
      render json: {
                    status: "Error",
                    message: "User not updated.",
                    data: @user.errors
                    }, status: :unprocessable_entity
    end
  end

  # DELETE /user
  def destroy
    # auto_login
    # check_user
    if @user.present?
      @user.destroy
      render json: {
          status: "Success",
          message: "User deleted.",
      }, status: :ok
    else
      render json: {
          status: "Error",
          message: "User not deleted.",
      }, status: :unprocessable_entity
    end
  end

  private

    def get_preferences
      @cities = @user.cities.pluck(:id)
      @rents = @user.rents.pluck(:id)
      @stay_periods = @user.stay_periods.pluck(:id)
      @property_types = @user.property_types.pluck(:id)
    end
    
    def include_role_name 
      @role = @user.role[:name]
    end

    def user_params
      params.permit(:username, :password, :email, :first_name, :last_name,
                    :property_type_preference, :rent_price_preference,
                    :length_of_stay_preference, :city_preference, :role_id)
    end
end
