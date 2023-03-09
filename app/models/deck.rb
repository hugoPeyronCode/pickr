class Deck < ApplicationRecord
  #before_create :set_default_status
  belongs_to :user
  validates :name, presence: true

  has_many :deck_items, dependent: :destroy
  has_many :items, through: :deck_items
  has_many :votes, through: :deck_items

  def set_default_status
    self.status = 'pending'
  end

  def most_voted_deck_item
    self.deck_items.joins(:votes)
    .group('deck_items.id')
    .select('deck_items.*, COUNT(votes.id) AS votes_count')
    .order('votes_count DESC')
    .first
  end
  #private

  #def set_default_status
  #  self.status = 'pending'
  #end
end
