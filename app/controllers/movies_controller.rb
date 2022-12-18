class MoviesController < ApplicationController
  def index
    @keyword = params[:keyword]
    @is_showing = params[:is_showing]

    @movies = Movie.search_movies(@keyword, @is_showing)
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
