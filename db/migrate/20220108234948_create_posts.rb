class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :content, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :rate, null: false

      t.timestamps
    end
  end
end
