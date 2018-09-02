class CreateUserApis < ActiveRecord::Migration[5.0]
  def change
    create_table :user_apis do |t|
      t.integer :user_id
      t.string :key

      t.timestamps
    end
  end
end
