class AddMoreDetailsToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :gender, :string
    add_column :profiles, :town, :string
    add_column :profiles, :age, :integer
    add_column :profiles, :state, :string
    add_column :profiles, :parsed, :boolean
  end
end
