class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :decks, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :deck_items, through: :votes
  has_many :pending_decks, through: :deck_items, source: :deck
end
