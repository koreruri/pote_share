class ReservationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create]
  
  def index
    @reservations = current_user.reservations
  end

  def new
  end

  def create
  end
end
