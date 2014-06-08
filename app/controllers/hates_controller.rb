class HatesController < ApplicationController

  def index
    @hates = Hate.all
  end

  def create
    @post = Post.find(params[:post_id])
    @hate = Hate.new
    @post.hates << @hate
    # @hate = Hate.new(post: @post) alternative version of line 6
    @hate.user = current_user
    @hate.save!
    flash[:notice] = "Thanks for the hate!"
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = "Can´t touch this, also you need to be logged in!"
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Record has been deleted already"
  ensure
    WebsocketRails[:hates].trigger 'hate', { id: @post.id, new_hate_count: @post.hates.count }
    render 'create', formats: [:json]
  end

  def destroy
    @post = Post.find(params[:post_id])
    @hate = current_user.hates.find(params[:id])
    @hate.destroy!
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Can´t delete a hate that is not yours!"
  ensure
    WebsocketRails[:hates].trigger 'hate', { id: @post.id, new_hate_count: @post.hates.count }
    render 'destroy', formats: [:json]
  end
end
