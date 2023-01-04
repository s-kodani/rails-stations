class ReservationsController < ApplicationController
    def new
        @date = params[:date]
        @schedule = Schedule.find(params[:schedule_id])
        if @date == nil || params[:sheet_id] == nil
            redirect_to movie_reservation_path(@schedule.movie, date: @date, schedule_id: params[:schedule_id])
        else
            @sheet = Sheet.find(params[:sheet_id])
            @reservation = Reservation.new(session[:reservation] || {})
        end
    end

    def create
        @schedule = Schedule.find(params[:reservation]["schedule_id"])
        @reservation = Reservation.new(reservation_params)
        if @reservation.save
            session[:reservation] = nil
            flash[:success] = '登録が完了しました'
            redirect_to movie_path(@schedule.movie)
        else
            session[:reservation] = @reservation.attributes.slice(*reservation_params.keys)
            puts @reservation.errors.full_messages_for(:sheet_id)
            puts @reservation.errors.full_messages_for(:sheet_id).size
            if @reservation.errors.full_messages_for(:sheet_id).size > 0
                flash[:danger] = @reservation.errors.full_messages_for(:sheet_id)
                redirect_to movie_reservation_path(@schedule.movie, date: params[:reservation]["date"], schedule_id: @schedule.id)
            else
                flash[:danger] = @reservation.errors.full_messages
                redirect_to request.referer
            end
        end
    end

    private
        def reservation_params
            params.require(:reservation).permit(:id, :date, :schedule_id, :sheet_id, :email, :name, :created_at, :updated_at)
        end
end
