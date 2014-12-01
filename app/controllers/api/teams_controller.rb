class Api::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league, only: [:index]
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET league/:league_id/teams.json
  def index
    @teams = @league.teams
    render json: ActiveModel::ArraySerializer.new(
      @teams, root: 'teams', each_serializer: TeamSerializer
    ).to_json
  end

  # GET league/:league_id/teams/1.json
  def show
    TeamSerializer.new(@team, root: 'team').to_json
  end

  # POST league/:league_id/teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      render json: TeamSerializer.new(@team, root: 'team').to_json
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT league/:league_id/teams/1.json
  def update
    if @team.update(team_params)
      render json: TeamSerializer.new(@team, root: 'team').to_json
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
