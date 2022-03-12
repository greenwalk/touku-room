class Haiku < ApplicationRecord
  belongs_to :user
  belongs_to :field
  has_many :votes

  validates :content, presence: true, length: { minimum: 5, maximum: 25 }
  validates :content_sub, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: 'は「ひらがな」のみ入力可能です（スペースも不可）' },
                          length: { minimum: 5, maximum: 25 }
end
