class RoomsController < ApplicationController
  def search
    @rooms = Room.all
    @results = @rooms.where('address LIKE ?', "%#{params[:area]}%") if params[:area].present?
    @results = @rooms.where('name LIKE ?', "%#{params[:keyword]}%")
            .or(@rooms.where('introduction LIKE ?', "%#{params[:keyword]}%"))
            .or(@rooms.where('address LIKE ?', "%#{params[:keyword]}%")) if params[:keyword].present?
  end
end
