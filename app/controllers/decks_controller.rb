class DecksController < ApplicationController
  def index
    @decks = Decks.all
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

    if @deck.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

    @items = Item.near(@deck.address, 0.5).limit(10)
    @items.where(price_range: @deck.price_range)
    @items = @items.where(rating: @deck.rating)

    @items.each do |item|
      deck_item = DeckItem.new(deck: @deck, item: item, user: current_user)
      deck_item.save!
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :address, :rating, :price_range)
  end
end
