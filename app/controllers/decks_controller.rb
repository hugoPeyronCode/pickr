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
      redirect_to deck_path(@deck)
    else
      render :new, status: :unprocessable_entity
    end
    @items.each do |item|
      deck_item = DeckItem.new(deck: @deck, item: item)
      deck_item.save!
    end
  end

  def show
    @deck = Deck.find(params[:id])
    @deck_items = @deck.deck_items
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end
