class ChatsController < ApplicationController
  before_action :authorized
  before_action :get_role
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    # @chats = Chat.all
    if @role.name == "user"
      @chats = Chat.where(user_id: @user.id)
    else 
      @chats = Chat.where(partner_id: @user.id)
    end

    render json: {
                  status: "Success",
                  message: "Chats loaded.",
                  data: @chats
                  }, status: :ok
  end

  # GET /chats/1
  def show
    get_messages
    render json: {
                  status: "Success",
                  message: "Chat loaded.",
                  data: { 
                        chat: @chat,
                        messages: @messages
                        }
                  }, status: :ok
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: {
                    status: "Success",
                    message: "Chat created.",
                    data: @chat
                    }, status: :created
    else
      render json: {
                    status: "Error",
                    message: "Chat not created.",
                    data: @chat.errors
                    }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    
    if @chat.update(chat_params)
      render json: {
                    status: "Success",
                    message: "Chat updated.",
                    data: @chat
                    }, status: :ok
    else
      render json: {
                    status: "Error",
                    message: "Chat not updated.",
                    data: @chat.errors
                    }, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    if @chat.present?
      @chat.destroy
      render json: {
          status: "Success",
          message: "Chat deleted.",
      }, status: :ok
    else
      render json: {
          status: "Error",
          message: "Chat not deleted.",
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_role
      @role = Role.find(@user.role_id)
    end

    def get_messages
      @messages = Message.where(chat_id:@chat.id)
    end

    def set_chat
      if @role.name == "user"
        @chat = Chat.where({id: params[:id], user_id: @user.id })
      else 
        @chat = Chat.where({id: params[:id], partner_id: @user.id })
      end
      return item_not_found
    end

    def item_not_found
      if @chat.length == 0
        render json: {
                      status: "Error",
                      message: "Chat not found.",
                      }, status: 404
      else
        @chat = @chat[0]
      end
    end

    def verify_user(user_id)
      return @user.id.to_i == user_id.to_i
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:success, :user_id, :partner_id, :property_id)
    end

end
