class Club < ApplicationRecord
  belongs_to :user
  has_many :quinielas, dependent: :destroy
end
