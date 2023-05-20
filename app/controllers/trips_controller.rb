class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])
  end

  private

  def trip_params
    params.require(:trip).permit(:user_id)
  end

end
