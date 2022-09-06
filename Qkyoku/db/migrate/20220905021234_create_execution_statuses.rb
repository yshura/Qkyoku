class CreateExecutionStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :execution_statuses do |t|
      t.string :name ,null: false
      t.timestamps
    end
  end
end
