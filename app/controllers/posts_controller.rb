class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
    @comment = Comment.new
    @comments = Comment.all
  end

  def new
    @post = Post.new
  end

  def create
	@post = Post.new(params[:post].permit(:picture, :comment))
	@post.save
    redirect_to('/posts')
  end

  def destroy
    @post = Post.find(params[:id]) 
    @post.destroy
    redirect_to('/posts')
  end
end
