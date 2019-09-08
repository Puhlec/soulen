class Entry < ApplicationRecord
  belongs_to :lesson
  belongs_to :template, optional: true
end
