class DecksController < ApplicationController
  def index
    @decks = Deck.all
    @all_my_decks = Deck.joins(:deck_items).joins(:votes).where("decks.user_id = ? OR votes.user_id = ?", current_user.id, current_user.id).distinct
    @my_decks = @all_my_decks.where.not(status: "Hidden").order(created_at: :desc)
    @pending_decks = @my_decks.where(status: "Pending").order(created_at: :desc)
    @closed_decks = @my_decks.where(status: "Closed").order(created_at: :desc)
    @hidden_decks = @my_decks.all.where(status: "Hidden").order(created_at: :desc)
  end

  def progress
    @user_id = current_user.id
    @deck = Deck.find(params[:id])
    @completed_percent =
      (@deck.deck_items.select{ |deck_item| deck_item.votes.where(user: current_user).any? }.size / @deck.deck_items.size.to_f * 100).round
    render json: { completed_percent: @completed_percent }
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
    @deck.item_type = params[:item_type]
    @deck.status = "Pending"
    if @deck.save!

      if params[:item_type] == "Restaurant"
        @items = Item.near(@deck.address, 10).limit(10)
        @items = @items.where("price_range >= ?", @deck.price_range)
      elsif params[:item_type] == "Movie"
        @items = Item.where(item_type: "Movie")
        @items = @items.where(movie_genre: @deck.movie_genre) if params[:deck][:movie_genre] != ""
      end
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
    @my_votes = Vote.where(user: current_user)
    @deck_items_voted = @my_votes.pluck(:deck_item_id)
    @deck_items = @deck.deck_items.where.not(id: @deck_items_voted)
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

  def hide
    @deck = Deck.find(params[:id])
    @deck.status = "Hidden"
    @deck.save
    redirect_to decks_path
  end


  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :address, :rating, :price_range, :movie_title, :movie_genre, :item_type)
  end
end
