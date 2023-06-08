class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    @markers = @trip.legs.map do |leg|
      [
        {
          lat: leg.origin_latitude,
          lng: leg.origin_longitude
        },
        {
          lat: leg.destination_latitude,
          lng: leg.destination_longitude
        }
      ]
    end.flatten
  end

  def new
    @trip = Trip.new
    @trip.legs.build
    @vehicles = Vehicle.all
  end

  def create

    @trip = Trip.new
    @trip.user = current_user
    @trip.legs.build(trip_params[:legs_attributes]["0"])

    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(legs_attributes: [:description, :provider, :vehicle_id, :origin, :destination])
  end
end
