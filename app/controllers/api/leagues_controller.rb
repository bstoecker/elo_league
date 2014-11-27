class Api::LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  # GET /leagues.json
  def index
    @leagues = League.all
    render json: @leagues.to_json
  end

  # GET /leagues/1.json
  def show
  end

  # POST /leagues.json
  def create
    @league = League.new(league_params)

    if @league.save
      render json: @league.to_json
    else
      render json: @league.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leagues/1.json
  def update
    if @league.update(league_params)
      render :show, status: :ok, location: @league
    else
      render json: @league.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    head :no_content
  end

  private

  def set_league
    @league = League.find(params[:id])
  end

  def league_params
    params.require(:league).permit(:name, :describtion)
  end
end
