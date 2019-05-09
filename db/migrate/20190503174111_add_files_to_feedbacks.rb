class AddFilesToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :file, :string
  end
end
