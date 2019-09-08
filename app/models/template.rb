class Template < ApplicationRecord
  belongs_to :instructor
  has_many :entries
end
