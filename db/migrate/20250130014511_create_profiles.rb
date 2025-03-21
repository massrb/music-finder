class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :url
      t.string :title
      t.string :instrument

      t.timestamps
    end
  end
end
