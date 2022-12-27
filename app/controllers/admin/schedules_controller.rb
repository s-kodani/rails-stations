class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.order(:movie_id, :id)
  end

  def new
    @schedule = Schedule.new
    @movie = Movie.find(params[:movie_id])
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      flash[:success] = '登録が完了しました'
      redirect_to action: :new
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new, status: 400
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
    @movie =@schedule.movie
  end

  def update
    @schedule = Schedule.find(params[:id])
    @movie =@schedule.movie

    if @schedule.update(schedule_params)
      redirect_to edit_admin_movie_schedule_path(@movie, @schedule), flash: {success: "編集に成功しました"}
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule_id = @schedule.id
    @schedule.destroy

    redirect_to admin_movies_path, flash: {success: "スケジュールID「#{@schedule_id}」の削除に成功しました"}
  end

  private
    def schedule_params
      params.require(:schedule).permit(:id, :movie_id, :start_time, :end_time, :created_at, :updated_at)
    end
end
