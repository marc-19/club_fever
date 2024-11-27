class AddDetailsToClubs < ActiveRecord::Migration[7.1]
  def change
    add_column :clubs, :description, :text
    add_column :clubs, :logo, :string
    add_column :clubs, :picture, :string
  end
end
