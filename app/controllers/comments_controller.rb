class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    unless current_user.nil?
      @post = Post.find(params[:post_id])
      new_comment = @post.comments.new(params[:comment].permit(:comment))
      new_comment.user = current_user
      new_comment.save
      # redirect_to('/')
      WebsocketRails[:comments].trigger 'new', { comment: new_comment, user: new_comment.user }
      render nothing: true
    else
      flash[:notice] = "FUCK YOU!"
	end
  end
end
