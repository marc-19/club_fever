class AddTeamsToQuinielas < ActiveRecord::Migration[7.1]
  def change
    add_column :quinielas, :local_teams, :text
    add_column :quinielas, :visitor_teams, :text
  end
end
