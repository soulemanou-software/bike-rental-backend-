class Api::V1::BikesController < ApplicationController
  # GET /bikes
  def index
    @bikes = Bike.all

    render json: @bikes
  end

  # GET /bikes/1
  def show
    @bike = Bike.find(params[:id])
    render json: @bike
  end

  # POST /bikes
  def create
    @bike = Bike.new(bike_params)

    if @bike.save
      render json: { message: 'Bike created' }, status: :created
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bikes/1
  def destroy
    @bike = Bike.find(params[:id])
    # refressh id
    if @bike.destroy
      render json: { message: 'Bike deleted' }, status: :no_content
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def bike_params
    params.require(:bike).permit(:name, :bike_type, :description, :brand, :daily_rate, :user_id,
                                 { images: {}, color: [] })
  end
end
