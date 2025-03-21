class AddTagToEmails < ActiveRecord::Migration[8.0]
  def change
    add_column :emails, :tag, :string
  end
end
