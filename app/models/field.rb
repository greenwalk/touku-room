class Field < ApplicationRecord
  belongs_to :theme
  has_many :haikus

  validates :status, presence: true
  validates :theme, presence: true

  enum status: { touku: 0, voting: 1, finished: 2 }
end
