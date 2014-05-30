class AddUserIdToHates < ActiveRecord::Migration
  def change
    add_reference :hates, :user, index: true
  end
end
