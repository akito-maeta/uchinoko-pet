class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :edit, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
    @user = current_user
    @users = @user.following_user.order("created_at DESC")
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def hashtag
    @user = current_user
    @hashtag = Hashtag.find_by(hashname: params[:name])
    @posts = @hashtag.posts.build
    @post = @hashtag.posts
  end

  private
  def post_params
    params.require(:post).permit(:image, :title, :introduction)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
end
