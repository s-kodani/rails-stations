class Admin::MoviesController < ApplicationController
  def index
    @keyword = params[:keyword]
    @is_showing = params[:is_showing]

    @movies = Movie.search_movies(@keyword, @is_showing)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      flash[:success] = '登録が完了しました'
      redirect_to action: :new
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new, status: 400
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to edit_admin_movie_path(@movie.id), flash: {success: "編集に成功しました"}
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie_name = @movie.name
    @movie.destroy

    redirect_to admin_movies_path, flash: {success: "映画「#{@movie_name}」の削除に成功しました"}
  end

  private
    def movie_params
      params.require(:movie).permit(:id, :name, :year, :description, :image_url, :is_showing, :created_at, :updated_at)
    end
end
