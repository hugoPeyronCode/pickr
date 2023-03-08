class Deck < ApplicationRecord
  before_create :set_default_status
  belongs_to :user
  validates :name, presence: true

  has_many :deck_items, dependent: :destroy


  private

  def set_default_status
    self.status = 'pending'
  end
end
