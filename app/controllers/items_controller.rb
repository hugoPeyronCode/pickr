class ItemsController < ApplicationController
  def index
    @items = Item.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @items.geocoded.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { item: item }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end
end
