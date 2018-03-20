class TownsController < ApplicationController
  before_action :set_town, only: [:show, :edit, :update, :destroy]

  # GET /towns
  # GET /towns.json
  def index
    @towns = Town.all
  end

  # GET /towns/1
  # GET /towns/1.json
  def show
    wheather = @town.get_wheather
    puts wheather.latitude
    puts wheather.currently.temperature
    puts wheather.currently.summary
  end

  # GET /towns/new
  def new
    @town = Town.new
  end

  # GET /towns/1/edit
  def edit
  end
  
  def resource_name
    Town
  end

  def resource_params
    town_params
  end

  def resource
    @town
  end

  # DELETE /towns/1
  # DELETE /towns/1.json
  def destroy
    @town.destroy
    respond_to do |format|
      format.html { redirect_to towns_url, notice: 'Town was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_town
      @town = Town.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def town_params
      params.require(:town).permit(:name, :postalcode, :latitude, :longitude)
    end
end
