class Api::UsersController < ApplicationController
  before_action :set_league, only: [:index, :create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET league/:league_id/users.json
  def index
    @users = @league.users
    render json: ActiveModel::ArraySerializer.new(
      @users, root: 'users', each_serializer: UserSerializer
    ).to_json
  end

  # GET league/:league_id/users/1.json
  def show
  end

  # POST league/:league_id/users.json
  def create
    @user = User.new(user_params.merge(league: @league))

    if @user.save
      render json: UserSerializer.new(@user, root: 'user').to_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT league/:league_id/users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE league/:league_id/users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname)
  end
end
