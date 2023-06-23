class EditLikes < ActiveRecord::Migration[7.0]
  def change
    # rename_column :likes, :likes, :likeable
    add_reference :likes, :likeable, polymorphic: true
  end
end
