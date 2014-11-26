class Api::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1.json
  def show
  end

  # POST /teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      render :show, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1.json
  def update
    if @team.update(team_params)
      render :show, status: :ok, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1.json
  def destroy
    @team.destroy
    head :no_content
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :league_id)
  end
end
