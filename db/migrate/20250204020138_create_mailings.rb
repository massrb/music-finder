# rails g model Mailing email:references profile:references 

class CreateMailings < ActiveRecord::Migration[8.0]
  def change
    create_table :mailings do |t|
      t.references :email, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
