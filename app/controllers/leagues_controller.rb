class LeaguesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  # GET /leagues.json
  def index
    @leagues = League.all
    respond_to do |format|
      format.html
      format.json do
        render json: ActiveModel::ArraySerializer.new(
          @leagues, root: 'leagues', each_serializer: LeagueSerializer
        ).to_json
      end
    end
  end

  # GET /leagues/1.json
  def show
    respond_to do |format|
      format.html
      format.json do
        render json: LeagueSerializer.new(@league, root: 'league').to_json
      end
    end
  end

  # POST /leagues.json
  def create
    if new_league.save
      respond_to do |format|
        format.html { redirect_to action: 'index', status: 303 }
        format.json do
          render json: LeagueSerializer.new(@league, root: 'league').to_json
        end
      end
    else
      render json: @league.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leagues/1.json
  def update
    if @league.update(league_params)
      render json: LeagueSerializer.new(@league, root: 'league').to_json
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

  def new_league
    @league = League.new(league_params)
    @league.users = [current_user]
    @league
  end

  def set_league
    @league = League.find(params[:id])
  end

  def league_params
    params.require(:league).permit(:name, :describtion, :league_team_size)
  end
end
