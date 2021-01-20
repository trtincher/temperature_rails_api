class TemperaturesController < ApplicationController
  before_action :set_temperature, only: [:show, :update, :destroy]

  # GET /temperatures
  def index
    @temperatures = Temperature.all

    render json: @temperatures
  end

  # GET /temperatures/1
  def show
    render json: @temperature
  end

  # POST /temperatures
  def create
    @temperature = Temperature.new(temperature_params)
    #this adds a :location_id key to temperature from the params
    @temperature.location_id = params[:location_id]

    if @temperature.save
      render json: @temperature, status: :created #, location: @temperature ## removed to prevent redirect and erros ##
    else
      render json: @temperature.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /temperatures/1
  def update
    if @temperature.update(temperature_params)
      render json: @temperature
    else
      render json: @temperature.errors, status: :unprocessable_entity
    end
  end

  # DELETE /temperatures/1
  def destroy
    @temperature.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temperature
      @temperature = Temperature.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def temperature_params
      params.require(:temperature).permit(:average_high_f, :average_low_f)
    end
end
