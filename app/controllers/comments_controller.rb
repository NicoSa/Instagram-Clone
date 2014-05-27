class CommentsController < ApplicationController

	def new
		@comment = Comment.new
		@post = Post.find(params[:post_id])
	end

	def create
		@post = Post.find(params[:post_id])
		@post.comments.create(params[:comment].permit(:comment))
    	redirect_to('/posts')
	end
end
