class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @user = current_user
    @users = @user.following_user.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
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
end
