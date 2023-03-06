class DeckItem < ApplicationRecord
  belongs_to :item
  belongs_to :deck
  has_many :votes
end
