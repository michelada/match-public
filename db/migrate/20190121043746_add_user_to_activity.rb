class AddUserToActivity < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :user, foreign_key: true, null: false
  end
end
