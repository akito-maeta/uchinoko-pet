class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post

  def create
    like = @post.likes.new(user_id: current_user.id)
    like.save
  end

  def destroy
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end

  def likedby
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end