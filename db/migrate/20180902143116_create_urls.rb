class CreateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.string :shortened_url
      t.string :original_url
      t.integer :user_id
      t.boolean :is_deleted, default: false

      t.timestamps
    end
  end
end
