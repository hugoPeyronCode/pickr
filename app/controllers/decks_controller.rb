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
    @items.where(price_range: set_price_range)
    @items = @items.where("rating >= ?", 2)
    raise
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

  # def set_price_range
  #   params[:price_range] / 15
  # end
end
