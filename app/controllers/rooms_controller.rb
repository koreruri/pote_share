class RoomsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  
  def new
  end
  
  def create
  end
  
  def search
    @rooms = Room.all
    @results = @rooms.where('address LIKE ?', "%#{params[:area]}%") if params[:area].present?
    @results = @rooms.where('name LIKE ?', "%#{params[:keyword]}%")
            .or(@rooms.where('introduction LIKE ?', "%#{params[:keyword]}%"))
            .or(@rooms.where('address LIKE ?', "%#{params[:keyword]}%")) if params[:keyword].present?
  end
end
