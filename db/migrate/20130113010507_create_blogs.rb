class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.string :repo
      t.references :user

      t.timestamps
    end
    add_index :blogs, :user_id
  end
end
