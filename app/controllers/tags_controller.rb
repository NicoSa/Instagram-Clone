class TagsController < ApplicationController

  def show
    @tag = Tag.find_by(name: '#' +  params[:id])
    @comments = Comment.all
    @comment = Comment.new
  end

end
