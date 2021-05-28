class MessagesController < ApplicationController
  before_action :authorized
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    # @messages = Message.all
    @messages = Message.where(user_id: @user.id)

    render json: {
                  status: "Success",
                  message: "Messages loaded.",
                  data: @messages
                  }, status: :ok
  end

  # GET /messages/1
  def show
    render json: {
      status: "Success",
      message: "Message loaded.",
      data: @message
      }, status: :ok
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: {
                    status: "Success",
                    message: "Message created.",
                    data: @message
                    }, status: :created
    else
      render json: {
                    status: "Error",
                    message: "Message not created.",
                    data: @message.errors
                    }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    
    if @message.update(message_params)
      render json: {
                    status: "Success",
                    message: "Message updated.",
                    data: @message
                    }, status: :ok
    else
      render json: {
                    status: "Error",
                    message: "Message not updated.",
                    data: @message.errors
                    }, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    if @message.present?
      @message.destroy
      render json: {
          status: "Success",
          message: "Message deleted.",
      }, status: :ok
    else
      render json: {
          status: "Error",
          message: "Message not deleted.",
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      # @message = Message.find(params[:id])
      @message = Message.where({id: params[:id], user_id: @user.id })
      return item_not_found
    end

    def item_not_found
      if @message.length == 0
        render json: {
                      status: "Error",
                      message: "Message not found.",
                      }, status: 404
      else
        @message = @message[0]
      end
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content, :chat_id, :user_id)
    end
end
