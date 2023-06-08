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
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(legs_attributes: [:description, :provider, :vehicle_id, :origin_address, :destination_address])
  end

  def leg_markers(leg)
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
  end

end
