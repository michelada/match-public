class AddEnglishApproveToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :english_approve, :boolean
  end
end
