class CreateWins < ActiveRecord::Migration[7.1]
  def change
    create_table :wins do |t|
      t.references :quiniela, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
