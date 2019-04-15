class DefaultMatchType < ActiveRecord::Migration[5.2]
  def up
    remove_column :matches, :match_type
    add_column :matches, :match_type, :integer, null: false, default: 0
  end
  def down
    remove_column :matches, :match_type
    add_column :matches, :match_type, :integer
  end
end
