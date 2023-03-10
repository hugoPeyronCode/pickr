class VotesController < ApplicationController

  def create
    @deck_item = DeckItem.find(params[:deck_item_id])
    @vote = Vote.new
    @vote.deck_item = @deck_item
    @vote.user = current_user
    if params[:liked]
      @vote.value = 1
    else
      @vote.value = 0
    end
    @vote.save!
  end
end
