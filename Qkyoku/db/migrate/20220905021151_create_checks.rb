class CreateChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :checks do |t|
      t.integer :user_id ,null: false
      t.integer :post_id ,null: false
      t.boolean :complete ,null: false, default: false
      t.timestamps
    end
  end
end
