class Lesson < ApplicationRecord
  has_rich_text :content
  belongs_to :student
  has_many :entries, dependent: :destroy
  has_many :comms, dependent: :destroy
  accepts_nested_attributes_for :entries
end
