class ProfilesController < ApplicationController

  def show
    @post = Post.all
    @user = User.find(params[:id])
    @comments = Comment.all
    @comment = Comment.new
  end

end
