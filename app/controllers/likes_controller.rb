class LikesController < ApplicationController

  def index
    @likes = Like.all
  end

  def create
    raise "Hello " unless current_user
    @post = Post.find(params[:post_id])
    @like = Like.new 
    @post.likes << @like
    @like.user = current_user
    @like.save!
    flash[:notice] = "Thanks for the like!"
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = "Can´t touch this, also you need to be logged in!"
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Record has been deleted already"
  ensure
    if @like.save!
      # WebsocketRails[:likes].trigger 'new', { id: @post.id, new_like_count: @post.likes.count }
      render 'create', formats: [:json]
    else
      redirect_to('/')
    end
  end

  def destroy
    @post = Post.find(params[:post_id])

    @like = current_user.likes.find(params[:id])
    @like.destroy!
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Can´t delete a like that is not yours!"
  ensure
    render 'destroy', formats: [:json]
  end
end
