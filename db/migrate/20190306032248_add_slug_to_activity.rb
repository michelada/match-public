class AddSlugToActivity < ActiveRecord::Migration[5.2]
  def up
    add_column :activities, :slug, :string
    add_index :activities, :slug, unique: true

    ActiveRecord::Base.connection.execute('update activities set slug = name;')

    Activity.all.each do |activity|
      if activity.valid?
        activity.slug = activity.name.parameterize
        activity.save!
      end
    end
  end

  def down
    remove_index :activities, :slug
    remove_column :activities, :slug
  end
end
