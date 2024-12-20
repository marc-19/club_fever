class Quiniela < ApplicationRecord
  belongs_to :club
  has_many :predictions, dependent: :destroy
  has_many :wins
  scope :playable, -> { where("start_date > ?", Date.today) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }
  scope :past, -> { where("end_date < ?", Date.today) }
  validates :local_teams, :visitor_teams, presence: true
  validate :teams_length_match
  validate :minimum_matches
  validates :title, length: { maximum: 20, message: "must be 20 characters or less" }

  def teams_length_match
    if local_teams.size != visitor_teams.size
      errors.add(:base, "Every match needs a local and visitant team")
    end
  end

  def participants_count
    predictions.count
  end

  def minimum_matches
    filled_local_teams = local_teams.reject(&:blank?)
    filled_visitor_teams = visitor_teams.reject(&:blank?)

    if filled_local_teams.size < 5 || filled_visitor_teams.size < 5
      errors.add(:base, "At least 5 matches must be filled out with both local and visitor teams.")
    end
  end

end
