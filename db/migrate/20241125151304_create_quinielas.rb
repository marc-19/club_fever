class CreateQuinielas < ActiveRecord::Migration[7.1]
  def change
    create_table :quinielas do |t|
      t.string :title
      t.references :club, null: false, foreign_key: true
      t.string :reward
      t.date :start_date
      t.date :end_date
      t.string :result

      t.timestamps
    end
  end
end
