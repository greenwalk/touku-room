class Theme < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :season

  belongs_to :user
  has_one_attached :image
  has_one :field

  validates :season_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :status, presence: true
  validates :image, presence: true
  validate :image_content_type, if: :was_attached?

  def image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:image, "に使用可能な拡張子は .png/.jpg/.jpeg のみです") unless image.content_type.in?(extension)
  end

  def was_attached?
    self.image.attached?
  end

  enum status: { set: 0, used: 1 }
end
