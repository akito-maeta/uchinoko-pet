class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    @post = @comment.post
    if @comment.user != current_user
      redirect_to request.referer
    end
    @comment.destroy
    redirect_to request.referer
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
