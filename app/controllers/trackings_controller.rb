class TrackingsController < ApplicationController
  before_action :set_tracking, only: [:show, :edit, :update, :destroy]

  # GET /trackings
  # GET /trackings.json
  def index
    @trackings = Tracking.all
    #respond_with @trackings
  end

  # GET /trackings/1
  # GET /trackings/1.json
  def show
  end

  # GET /trackings/new
  def new
    @tracking = Tracking.new
  end

  # GET /trackings/1/edit
  def edit
  end

  # POST /trackings
  # POST /trackings.json
  def create
    @tracking = Tracking.new(tracking_params)
    #respond_with tracking_params.create(tracking_params)

    respond_to do |format|
      if @tracking.save
        format.html { redirect_to @tracking, notice: 'Tracking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tracking }
      else
        format.html { render action: 'new' }
        format.json { render json: @tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trackings/1
  # PATCH/PUT /trackings/1.json
  def update
    respond_to do |format|
      if @tracking.update(tracking_params)
        format.html { redirect_to @tracking, notice: 'Tracking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trackings/1
  # DELETE /trackings/1.json
  def destroy
    @tracking.destroy
    respond_to do |format|
      format.html { redirect_to trackings_url }
      format.json { head :no_content }
    end
  end

  def next_station
    before_id = before_station
    current_station_id = Tracking.last.station_id
    p before_id
    p "xxxxxxxxxxxxxxxxxxxxxxxxxxx"

    p cur_index = (ListStation.find_by_station_id current_station_id).list_number
    p before_index = before_id != 0 ? (ListStation.find_by_station_id(before_id)).list_number : 1
    p "yyyy"
    p before_before_index = before_id != 0 ? (ListStation.find_by_station_id(before_station before_id)).list_number : 1

    result = []
    if cur_index < before_before_index
      result = ListStation.first.station_id
    else
      (ListStation.find_all_by_list_number(cur_index + 1)).each do |i|
        result.push(i.station_id)
end

    end

    render json: result
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracking
      @tracking = Tracking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tracking_params
      params.require(:tracking).permit(:lat, :long, :car_id)
    end
end
