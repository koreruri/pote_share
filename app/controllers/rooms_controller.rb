class RoomsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :posts]
  
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
  
  def show
    @room = Room.find(params[:id])
    @reservation = @room.reservations.build if logged_in?
  end
  
  def search
    @rooms = Room.all
    
    if params[:area].present?
      @results = @rooms.where('address LIKE ?', "%#{params[:area]}%")
    elsif params[:keyword].present?
      @results = @rooms.where('name LIKE ?', "%#{params[:keyword]}%")
            .or(@rooms.where('introduction LIKE ?', "%#{params[:keyword]}%"))
            .or(@rooms.where('address LIKE ?', "%#{params[:keyword]}%"))
    else
      @results = @rooms
    end
  end
  
  def posts
    @rooms = current_user.rooms
  end
  
  private
    def room_params
      params.require(:room).permit(:name, :introduction, :price, :address, :image)
    end
end
