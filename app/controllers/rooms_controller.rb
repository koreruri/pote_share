class RoomsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  
  def new
    @room = current_user.rooms.build if logged_in?
  end
  
  def create
    @room = current_user.rooms.build(room_params)
    @room.image.attach(params[:room][:image])
    if @room.save
      flash[:success] = "Room was successfully created."
      redirect_to @room
    else
      render 'new'
    end
  end
  
  def search
    @rooms = Room.all
    @results = @rooms.where('address LIKE ?', "%#{params[:area]}%") if params[:area].present?
    @results = @rooms.where('name LIKE ?', "%#{params[:keyword]}%")
            .or(@rooms.where('introduction LIKE ?', "%#{params[:keyword]}%"))
            .or(@rooms.where('address LIKE ?', "%#{params[:keyword]}%")) if params[:keyword].present?
  end
  
  private
    def room_params
      params.require(:room).permit(:name, :introduction, :price, :address, :image)
    end
end
