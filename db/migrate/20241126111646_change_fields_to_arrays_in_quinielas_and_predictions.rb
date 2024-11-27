class ChangeFieldsToArraysInQuinielasAndPredictions < ActiveRecord::Migration[7.1]
  change_column :quinielas, :local_teams, :string, array: true, default: [], using: "string_to_array(local_teams, ',')"
  change_column :quinielas, :visitor_teams, :string, array: true, default: [], using: "string_to_array(visitor_teams, ',')"

  change_column :quinielas, :result, :string, array: true, default: [], using: "string_to_array(result, ',')"

  change_column :predictions, :result, :string, array: true, default: [], using: "string_to_array(result, ',')"
end
