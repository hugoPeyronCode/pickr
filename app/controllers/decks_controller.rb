class DecksController < ApplicationController
  def index
    # @decks = Decks.all
  end

  def choose
  end

  def new
    @deck = Deck.new
    @deckitem = DeckItem.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user = current_user
    @items = Item.near(params[:address], 0.5).limit(10)
    if @deck.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end
