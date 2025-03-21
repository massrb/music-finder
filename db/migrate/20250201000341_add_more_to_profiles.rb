class AddMoreToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :music, :string
  end
end
