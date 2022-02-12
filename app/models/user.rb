class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :themes
  has_many :haikus
  has_many :votes
  
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  validates :name, presence: true

  def already_voted?(haiku)
    self.votes.exists?(haiku_id: haiku.id)
  end
end
