class ChatsController < ApplicationController
  before_action :authorized
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    # @chats = Chat.all
    @chats = Chat.where(user_id: @user.id)

    render json: {
                  status: "Success",
                  message: "Chats loaded.",
                  data: @chats
                  }, status: :ok
  end

  # GET /chats/1
  def show
    render json: {
      status: "Success",
      message: "Chat loaded.",
      data: @chat
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
    def set_chat
      # @chat = Chat.find(params[:id])
      @chat = Chat.where({id: params[:id], user_id: @user.id })
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

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:success, :user_id, :partner_id, :property_id)
    end
end
