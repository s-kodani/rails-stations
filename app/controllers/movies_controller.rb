class MoviesController < ApplicationController
  def index
    @keyword = params[:keyword]
    @is_showing = params[:is_showing]

    if @keyword == nil && (@is_showing == nil || @is_showing == "all") then
      @movies = Movie.all
    elsif @keyword == nil then
      @movies = Movie.where('is_showing = (?)', @is_showing)
    elsif @is_showing == "all" || @is_showing == nil then
      @like_keyword = '%'.concat(@keyword).concat('%')
      @movies = Movie.where('name LIKE (?) OR description LIKE (?)', @like_keyword, @like_keyword)
    else
      @like_keyword = '%'.concat(@keyword).concat('%')
      @movies = Movie.where('is_showing = (?) AND (name LIKE (?) OR description LIKE (?))', @is_showing, @keyword, @like_keyword)
    end
  end
end
