class AddAttributesToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :is_admin, :boolean, default: false
  end
end
