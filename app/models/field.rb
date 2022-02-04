class Field < ApplicationRecord
  belongs_to :theme

  enum status: { touku: 0, voting: 1, finished: 2 }
end
