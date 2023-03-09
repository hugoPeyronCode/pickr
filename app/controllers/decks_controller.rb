class DecksController < ApplicationController
  def index
     @decks = Deck.all
     @pending_decks = Deck.where(status: "Pending")
     @closed_decks = Deck.all.where(status: "Closed")
     @my_decks = Deck.all.where(user_id: current_user.id.to_s)
  end

  def choose
  end

  def new
    @deck = Deck.new
    @deckitem = DeckItem.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.status = "Pending"
    @deck.user = current_user
    @deck.status = "Pending"

    if @deck.save!
      redirect_to deck_path(@deck)
    else
      render :new, status: :unprocessable_entity
    end

    @items = Item.near(@deck.address, 0.5).limit(10)
    @items.where(price_range: @deck.price_range)
    @items = @items.where(rating: @deck.rating)

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
    params.require(:deck).permit(:name, :address, :rating, :price_range)
  end
end
