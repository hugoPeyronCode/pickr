class DecksController < ApplicationController
  def index
     @decks = Deck.all
     @pending_decks = Deck.where(status: "Pending")
     @closed_decks = Deck.all.where(status: "Closed")
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
    @items.each do |item|
      deck_item = DeckItem.new(deck: @deck, item: item)
      deck_item.save!
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end
