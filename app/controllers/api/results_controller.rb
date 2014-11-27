class Api::ResultsController < ApplicationController
  before_action :set_result, only: [:show, :update, :destroy]
  before_action :set_league, only: [:index, :create]

  # GET league/:league_id/results.json
  def index
    @results = @league.results
    render json: @results.to_json
  end

  # POST league/:league_id/results.json
  def create
    args = result_params
    Result.create_from(@league, args[:iser_ids1], args[:user_ids2],
                       args[:score1], args[:score2], args[:date])

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
      .permit(:league_id, :score1, :score2, :user_ids1, :user_ids2, :date)
  end
end
