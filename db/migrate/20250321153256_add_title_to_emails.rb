class AddTitleToEmails < ActiveRecord::Migration[8.0]
  def change
    add_column :emails, :title, :string
  end
end
