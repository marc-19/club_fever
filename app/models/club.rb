class Club < ApplicationRecord
  belongs_to :user
  has_many :quinielas, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :followers, through: :followings, source: :user

  has_one_attached :logo
  has_one_attached :header_img

  validates :name, presence: true
  validates :description, length: { maximum: 300 }


  def logo_url
    logo || "https://via.placeholder.com/150" # Default placeholder if no logo exists
  end
end
