class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_league, only: [:index]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET league/:league_id/users.json
  def index
    @users = @league.users
    respond_to do |format|
      format.html
      format.json do
        render json: ActiveModel::ArraySerializer.new(
          @users, root: 'users', each_serializer: UserSerializer
        ).to_json
      end
    end
  end

  def index_all
    @users = User.all
    respond_to do |format|
      format.html
      format.json do
        render json: ActiveModel::ArraySerializer.new(
          @users, root: 'users', each_serializer: UserSerializer
        ).to_json
      end
    end
  end

  # GET league/:league_id/users/1.json
  def show
    respond_to do |format|
      format.html
      format.json do
        render json: UserSerializer.new(@user, root: 'user').to_json
      end
    end
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
      render json: UserSerializer.new(@user, root: 'user').to_json
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
