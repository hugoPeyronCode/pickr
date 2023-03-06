class Item < ApplicationRecord
  validates :name, presence: true
  validates :rating, presence: true
  validates_numericality_of :rating, greater_than_or_equal_to: 3
  validates :photo_url, presence: true
  validates :price_range, presence: true

  has_many :deck_items
end
