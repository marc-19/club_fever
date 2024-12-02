class User < ApplicationRecord
  has_many :predictions, dependent: :destroy
  has_many :wins, dependent: :destroy
  has_many :clubs, dependent: :destroy
  has_many :followings, dependent: :destroy, foreign_key: :user_id
  has_many :followed_clubs, through: :followings, source: :club
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
