class Instructor < ApplicationRecord
  has_secure_password
  has_many :students
  has_many :templates
end
