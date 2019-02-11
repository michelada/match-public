class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.belongs_to :activity, null: false
      t.belongs_to :user, null: false
      t.belongs_to :poll, null: false

      t.timestamps
    end
  end
end
