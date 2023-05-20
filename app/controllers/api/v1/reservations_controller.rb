class Api::V1::ReservationsController < ApplicationController
  # GET /reservations
  def index
    @reservations = Reservation.all

    render json: @reservations, include: :bike
  end

  # GET /reservations/1
  def show
    @reservation = Reservation.find(params[:id])
    render json: @reservation, include: :bike
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: { message: 'Reservation created' }, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation = Reservation.find(params[:id])

    if @reservation.destroy
      render json: { message: 'Reservation deleted' }, status: :no_content
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # Fetch RESERVED BIKE

  private

  # Only allow a list of trusted parameters through.

  def reservation_params
    params.require(:reservation).permit(:reservation_date, :due_date, :user_id, :bike_id, :city)
  end
end
