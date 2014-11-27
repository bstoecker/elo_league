class Api::ResultsController < ApplicationController
  before_action :set_result, only: [:show, :update, :destroy]
  before_action :set_league, only: [:index]

  # GET league/:league_id/results.json
  def index
    @results = @league.results
    render json: @results.to_json
  end

  # POST league/:league_id/results.json
  def create
    @result = Result.new(result_params)

    if @result.save
      render :show, status: :created, location: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT league/:league_id/results/1.json
  def update
    if @result.update(result_params)
      render :show, status: :ok, location: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  # DELETE league/:league_id/results/1.json
  def destroy
    @result.destroy
    head :no_content
  end

  private

  def result_params
    params.require(:result)
      .permit(:league_id, :score1, :score2, :team_id1, :team_id2, :date)
  end
end
