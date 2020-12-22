class AddDetailstoTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :status, :string, default: "未着手", null: false
    add_column :tasks, :priority, :integer, default: 0, null: false
  end
end
