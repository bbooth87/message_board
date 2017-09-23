class MessagesController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :upvote, :downvote, :destroy]
  before_action :authenticate_user!, except: [:index , :recent, :oldest, :upvoted, :downvoted, :show]

  def index
    @messages = Message.all
  end

  def recent
    @messages = Message.recent
    render action: :index
  end

  def oldest
    @messages = Message.oldest
    render action: :index
  end

  def upvoted
    @messages = Message.upvoted
    render action: :index
  end

  def downvoted
    @messages = Message.downvoted
    render action: :index
  end

  def show
  end

  def upvote
    @message.upvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @message.downvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @message.update(message_params)
      redirect_to message_path
    else
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    redirect_to root_path
  end

  private
  def self.sort_by(sort_param)
    if %w(recent oldest downvoted upvoted).include? sort_param
      send sort_param
    else
      all
    end
  end

    def message_params
      params.require(:message).permit(:title, :description, :video)
    end

    def find_message
      @message = Message.find(params[:id])
    end
end
