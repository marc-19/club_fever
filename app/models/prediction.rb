class Prediction < ApplicationRecord
  belongs_to :quiniela
  belongs_to :user

  validate :result_matches_quiniela

  private

  def result_matches_quiniela
    if result.blank? || result.length != quiniela.local_teams.length
      errors.add(:result)
    end
  end
end
