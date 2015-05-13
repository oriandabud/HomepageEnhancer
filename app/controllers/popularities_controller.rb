class PopularitiesController < ApplicationController
  before_action :set_popularity, only: [:show, :edit, :update, :destroy]

  # GET /popularities
  # GET /popularities.json
  def index
    @popularities = Popularity.all
  end

  # GET /popularities/1
  # GET /popularities/1.json
  def show
  end

  # GET /popularities/new
  def new
    @popularity = Popularity.new
  end

  # GET /popularities/1/edit
  def edit
  end

  # POST /popularities
  # POST /popularities.json
  def create
    @popularity = Popularity.new(popularity_params)

    respond_to do |format|
      if @popularity.save
        format.html { redirect_to @popularity, notice: 'Popularity was successfully created.' }
        format.json { render :show, status: :created, location: @popularity }
      else
        format.html { render :new }
        format.json { render json: @popularity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /popularities/1
  # PATCH/PUT /popularities/1.json
  def update
    respond_to do |format|
      if @popularity.update(popularity_params)
        format.html { redirect_to @popularity, notice: 'Popularity was successfully updated.' }
        format.json { render :show, status: :ok, location: @popularity }
      else
        format.html { render :edit }
        format.json { render json: @popularity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /popularities/1
  # DELETE /popularities/1.json
  def destroy
    @popularity.destroy
    respond_to do |format|
      format.html { redirect_to popularities_url, notice: 'Popularity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_popularity
      @popularity = Popularity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def popularity_params
      params.require(:popularity).permit(:entrances, :user_id, :product_id)
    end
end
