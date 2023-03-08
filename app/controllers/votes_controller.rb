class VotesController < ApplicationController

  def create
    @deck_item = DeckItem.find(params[:deck_item_id])
    @vote = Vote.new
    @vote.deck_item = @deck_item
    @vote.user = current_user
    @vote.save!
  end
end
