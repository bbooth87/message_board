class CommentsController < ApplicationController
  before_action :find_message
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  def create
    @comment = @message.comments.create(comment_params)
    @comment.user_id = current_user.id
  #allowing comments to save and redirecting to the message page otherwise it creates a new comment option.
    if @comment.save
      redirect_to message_path(@message)
    else
      render 'new'
    end
  end
  #allows comments to edit.
  def edit
  end

#Allows comments to update if the content params are satisfied updates and redirects to the message otherwise redirects to edit.
  def update
    if @comment.update(comment_params)
      redirect_to message_path(@message)
    else
      render 'edit'
  end
end
  #deletes comments
  def destroy
    @comment.destroy
    redirect_to message_path(@message)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
    def find_message
      @message = Message.find(params[:message_id])
    end

    def find_comment
      @comment = @message.comments.find(params[:id])
    end
  end
