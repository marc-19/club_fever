class Club < ApplicationRecord
  belongs_to :user
  has_many :quinielas, dependent: :destroy

  has_one_attached :logo
  has_one_attached :header_img

  validates :name, presence: true
  validates :description, length: { maximum: 300 }
end
