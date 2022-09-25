class CreateWorkplaces < ActiveRecord::Migration[6.1]
  def change
    create_table :workplaces do |t|
      t.string :name ,null: false
      t.boolean :is_checked, default: false, null: false
      t.timestamps
    end
  end
end
