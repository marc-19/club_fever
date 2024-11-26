class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :quiniela

  validates :result, presence: true
end
