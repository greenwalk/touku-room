class Theme < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :season

  belongs_to :user
  has_one_attached :image

  validates :season_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :status, presence: true 
  validates :image, presence: true
end
