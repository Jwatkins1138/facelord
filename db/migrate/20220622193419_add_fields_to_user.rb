class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :birthday, :date
    add_column :users, :company, :string
    add_column :users, :bio, :text
    
  end
end
