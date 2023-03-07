class Deck < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  has_many :deck_items, dependent: :destroy
end
