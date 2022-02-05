class Haiku < ApplicationRecord
  belongs_to :user
  belongs_to :field

  validates :content, presence: true
  validates :content_sub, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: "「ひらがな」のみ入力可能です" }
end
