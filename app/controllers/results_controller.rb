class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league, only: [:index, :create]
  before_action :set_result, only: [:show, :update, :destroy]

  # GET league/:league_id/results.json
  def index
    @results = @league.results
    respond_to do |format|
      format.html
      format.json do
        render json: @results.to_json
      end
    end
  end

  # POST league/:league_id/results.json
  def create
    @result = Result.create_from(result_params)
    respond_to do |format|
      format.html
      format.json do
        render json: ActiveModel::ResultSerializer.new(
          @result, root: 'result'
        ).to_json
      end
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
    result_args = params.require(:result)
    [:score1, :score2, :user_ids1, :user_ids2, :date].reduce({}) do |a, e|
      a.merge(e => result_args[e])
    end.merge(league: @league)
  end

  def set_result
    @result.find_by(id: params[:id])
  end
end
