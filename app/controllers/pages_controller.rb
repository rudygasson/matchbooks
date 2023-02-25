class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @search_district = params[:district]
    @search_term = params[:query]
    sql_query = "title ILIKE :query OR author ILIKE :query"
    if (@search_term != nil && @search_term != "") && @search_district != "All areas"
      @filtered_books = Book.where(sql_query, query: "%#{@search_term}%", locations: { district: @search_district })
    elsif (@search_term != nil && @search_term != "") && @search_district == "All areas"
      @filtered_books = Book.where(sql_query, query: "%#{@search_term}%")
    elsif @search_term == "" && @search_district != "All areas"
      @filtered_books = Book.includes(:locations).where(locations: { district: @search_district })
    else
      @filtered_books = Book.includes(:copies).select { |book| book.copies.size > 0 }
    end
    @districts = ["All areas", "Charlottenburg-Wilmersdorf", "Friedrichshain-Kreuzberg", "Lichtenberg", "Marzahn-Hellersdorf", "Mitte", "Neukölln", "Pankow", "Reinickendorf", "Spandau", "Steglitz-Zehlendorf", "Tempelhof-Schöneberg", "Treptow-Köpenick"]

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def book_districts(book)
    users = book.users
    locations = []
    users.each do |user|
      locations += user.locations
    end
    districts = locations.map { |location| location.district.downcase }
    return districts
  end
end
