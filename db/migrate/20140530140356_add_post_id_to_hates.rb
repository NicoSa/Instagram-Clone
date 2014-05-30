class AddPostIdToHates < ActiveRecord::Migration
  def change
    add_reference :hates, :post, index: true
  end
end
