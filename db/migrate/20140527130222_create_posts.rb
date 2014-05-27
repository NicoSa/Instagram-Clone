class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :comment
      t.string :image

      t.timestamps
    end
  end
end
