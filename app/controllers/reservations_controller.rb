class ReservationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show]
  
  def index
    @reservations = current_user.reservations
  end

  def new
    @reservation = current_user.reservations.build(reservation_params) 
  
    if @reservation.start_date.nil? || @reservation.end_date.nil? || @reservation.person_num.nil?
      flash[:danger] = "必須項目は全て入力してください"
      redirect_to @reservation.room
    elsif @reservation.start_date > @reservation.end_date
      flash[:danger] = "終了日は開始日より後にしてください"
      redirect_to @reservation.room
    elsif Date.today - 1 > @reservation.start_date || Date.today - 1 > @reservation.end_date
      flash[:danger] = "過去の日付は無効です"
      redirect_to @reservation.room
    elsif @reservation.person_num < 0
      flash[:danger] = "人数は正の整数で入力して下さい"
      redirect_to @reservation.room
    else
      @days_of_user = days_of_user(@reservation.start_date, @reservation.end_date)
      @total_price = total_price(@reservation.person_num, @days_of_user, @reservation.room.price)
    end
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.save
    flash[:success] = "Resevation was successfully created."
    redirect_to @reservation
  end
  
  def show
  end
  
  private
  
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :person_num, :total_price, :room_id)
    end
    
    #使用日数の計算
    def days_of_user(start_date, end_date)
      return ((end_date - start_date) / ( 60 * 60 * 24)).to_i
    end
    
    #合計金額の計算
    def total_price(person_num, days_of_user, price)
      return person_num * days_of_user * price
    end
end
