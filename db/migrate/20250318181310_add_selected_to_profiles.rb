class AddSelectedToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :selected, :boolean
  end
end
