class Prediction < ApplicationRecord
  belongs_to :quiniela
  belongs_to :user

  validate :result_change
  validates :user_id, uniqueness: { scope: :quiniela_id, message: "You can only submit one prediction per quiniela." }
  validates :result, presence: true

  def result_matches_quiniela
    if result.blank? || result.length != quiniela.local_teams.length
      errors.add(:result)
    end
  end

end
