class UsersController < ApplicationController

  before_action :authorized, only: [:auto_login, :update, :destroy]

  # REGISTER
  def create
  
    if user_params[:password] == params[:confirm_password]
      @user = User.create(user_params)
      # puts @user.errors.inspect
      if @user.valid?
        token = encode_token({user_id: @user.id})
        render json: {
          data: @user,
          message: "Account created.",
          status: "Success",
          token: token
        }
      else
        render json: {
          message: "Invalid email or password.",
          status: "Error"}, status: :unprocessable_entity
      end
    else
      render json: {
        message: "Passwords does not match.",
        status: "Error"}, status: :unprocessable_entity
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {
        data: @user,
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
    render json: {
      data: @user
    }
  end

  # PATCH or PUT /user
  def update
    # check_user 
    if @user.update(user_params)
      render json: {
                    status: "Success",
                    message: "User updated.",
                    data: @user
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

  def user_params
    params.permit(:username, :password, :email, :role_id, :first_name, :last_name,
                  :property_type_preference, :rent_price_preference,
                  :length_of_stay_preference, :city_preference)
  end
end
