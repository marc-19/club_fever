class Quiniela < ApplicationRecord
  belongs_to :club
  has_many :predictions, dependent: :destroy
  has_many :wins
  scope :playable, -> { where("start_date > ?", Date.today) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }
  scope :past, -> { where("end_date < ?", Date.today) }
  validates :local_teams, :visitor_teams, presence: true
  validate :teams_length_match
  validates :title, length: { maximum: 20, message: "must be 20 characters or less" }

  def teams_length_match
    if local_teams.size != visitor_teams.size
      errors.add(:base, "Every match needs a local and visitant team")
    end
  end

  def participants_count
    predictions.count
  end

end
