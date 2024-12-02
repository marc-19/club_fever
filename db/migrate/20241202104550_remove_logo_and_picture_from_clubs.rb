class RemoveLogoAndPictureFromClubs < ActiveRecord::Migration[7.1]
  def change
    remove_column :clubs, :logo, :string
    remove_column :clubs, :picture, :string
  end
end
