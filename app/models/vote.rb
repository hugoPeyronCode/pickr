class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :deck_item
  validates_inclusion_of :value, in: [0, 1]
end
