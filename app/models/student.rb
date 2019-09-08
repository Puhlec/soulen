class Student < ApplicationRecord
  has_secure_password
  belongs_to :instructor
  has_many :lessons, dependent: :destroy
  has_one_attached :avatar
end
