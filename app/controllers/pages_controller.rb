class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :search]

  def home
    @all = "All"
    @search_district = params[:district] || @all
    @search_term = params[:query]
    @districts = [@all] + Location.select(:district).distinct.map { |loc| loc.district }
    sql_query = "title LIKE :query OR author LIKE :query"
    @filtered_books = Book.includes(:locations, :copies)
    @filtered_books = @filtered_books.where(locations: {district: @search_district}) if (@search_district != @all)

    @filtered_books = @filtered_books
      .where(sql_query, query: "%#{@search_term}%")
      .select { |book| book.copies.size > 0 }
  end

  def search
    @all = "All"
    @search_district = params[:district] || @all
    @search_term = params[:query]
    @districts = [@all] + Location.select(:district).distinct.map { |loc| loc.district }
    sql_query = "title LIKE :query OR author LIKE :query"
    @filtered_books = Book.includes(:locations, :copies)
    @filtered_books = @filtered_books.where(locations: {district: @search_district}) if (@search_district != @all)

    @filtered_books = @filtered_books
      .where(sql_query, query: "%#{@search_term}%")
      .select { |book| book.copies.size > 0 }

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "search_results")
      end
    end
  end
end
