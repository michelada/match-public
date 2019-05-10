class AddStatusToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :status, :int, default: 0
  end
end
