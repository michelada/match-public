class AddMatchToMatchProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :match_products, :match, foreign_key: true
  end
end
