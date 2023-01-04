class SheetsController < ApplicationController
  def index
    @date = params[:date]
    @schedule_id = params[:schedule_id]
    @movie_id = params[:movie_id]
    @sheets = Sheet.order(:row, :column)
    if @date == nil || @schedule_id == nil
      redirect_to movie_path(@movie_id)
    end
  end
end
