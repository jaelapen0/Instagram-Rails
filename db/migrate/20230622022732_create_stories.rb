class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :caption
      t.float :longitude
      t.float :latitude
      t.references :user, null: false, foreign_key: true
      t.boolean :allow_response
      t.boolean :show_likes_count
      t.timestamps
    end
  end
end
