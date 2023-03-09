class DecksController < ApplicationController
  def index
     @decks = Deck.all
     @my_decks = Deck.joins(:deck_items).joins(:votes).where("decks.user_id = ? OR votes.user_id = ?", current_user.id, current_user.id).distinct
     @pending_decks = @my_decks.where(status: "Pending")
     @closed_decks = @my_decks.all.where(status: "Closed")
     # @my_decks = Deck.all.where(user_id: current_user.id.to_s)

     # here i want to see all the decks that I created or that I've voted into.
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
    @deck.status = "Pending"
    if @deck.save!
      @items = Item.near(@deck.address, 10).limit(10)
      @items = @items.where("price_range >= ?", @deck.price_range)
      @items = @items.where(rating: @deck.rating)

      @items.each do |item|
        deck_item = DeckItem.new(deck: @deck, item: item)
        deck_item.save!
      end
      redirect_to deck_path(@deck)
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @deck = Deck.find(params[:id])
    @deck_items = @deck.deck_items
    @deck_winning_item = @deck.most_voted_deck_item
  end

  def close_vote
    @deck = Deck.find(params[:id])
    if @deck.update(status: "Closed")
      redirect_to deck_path(@deck), notice: "Vote closed successfully."
    else
      redirect_to deck_path(@deck), alert: "Error closing vote."
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :address, :rating, :price_range, :movie_title)
  end
end
