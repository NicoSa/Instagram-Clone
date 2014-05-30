class LikesController < ApplicationController

  def index
    @likes = Like.all
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user = current_user
    @like.save!
    flash[:notice] = "Thanks for the like!"
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = "Can´t touch this, also you need to be logged in!"
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Record has been deleted already"
  ensure
    redirect_to('/posts')
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy!
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Can´t delete a like that is not yours!"
  ensure
    redirect_to('/')
  end
end
