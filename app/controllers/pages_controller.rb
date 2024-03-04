class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :search]
  ALL_AREAS = "Berlin"

  def home
    @area = ALL_AREAS
    @areas = [ALL_AREAS] + Location.select(:district).distinct.map { |loc| loc.district }
    @books = Book.last(6)
  end

  def search
    books = Book.with_title_or_author(params[:query]).in_area(params[:area], ALL_AREAS)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "search_results",
          partial: "search_results",
          locals: { books:, query: params[:query], area: params[:area]})
      end
    end
  end
end
