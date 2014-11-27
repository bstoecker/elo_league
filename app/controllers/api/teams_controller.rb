class Api::TeamsController < ApplicationController
  before_action :set_league, only: [:index]
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET league/:league_id/teams.json
  def index
    @teams = @league.teams
    render json: @teams.to_json
  end

  # GET league/:league_id/teams/1.json
  def show
  end

  # POST league/:league_id/teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      render :show, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT league/:league_id/teams/1.json
  def update
    if @team.update(team_params)
      render :show, status: :ok, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE league/:league_id/teams/1.json
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
