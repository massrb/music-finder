class AddDetailsToProfiless < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :location, :string
    add_column :profiles, :zip, :string
    add_column :profiles, :user, :string
    add_column :profiles, :plays, :string
  end
end
