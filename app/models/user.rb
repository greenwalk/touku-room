class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :themes
  has_many :haikus
  has_many :votes

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }, on: :create
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }, allow_blank: true, on: :update
  validates :name, presence: true

  def already_voted?(haiku)
    votes.exists?(haiku_id: haiku.id)
  end
end
