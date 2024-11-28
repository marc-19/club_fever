class Quiniela < ApplicationRecord
  belongs_to :club
  has_many :predictions, dependent: :destroy
  has_many :wins

  validates :local_teams, :visitor_teams, presence: true
  validate :teams_length_match

  private

  def teams_length_match
    if local_teams.size != visitor_teams.size
      errors.add(:base, "Every match needs a local and visitant team")
    end
  end

end
