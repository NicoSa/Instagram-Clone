class PostsController < ApplicationController

	before_action :authenticate_user!, except: [:index]

	def index
		@posts = Post.all
		@post = Post.new
	end

	def create
		
		Post.create(params[:post].permit(:image, :comment))
		redirect_to('/posts')
	end
end
