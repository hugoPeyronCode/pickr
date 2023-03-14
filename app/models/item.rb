class Item < ApplicationRecord

  # validates :rating, presence: true
  # validates_numericality_of :rating, greater_than_or_equal_to: 1
  # validates :price_range, presence: true
  validates :name, presence: true
  validates :photo_url, presence: true

  has_many :deck_items, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


end
