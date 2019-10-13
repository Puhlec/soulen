class Student < ApplicationRecord
  has_secure_password
  belongs_to :instructor
  has_many :lessons, dependent: :destroy
  has_one_attached :avatar
  validates :name, :password, presence: true
  validates :name, uniqueness: true
end
