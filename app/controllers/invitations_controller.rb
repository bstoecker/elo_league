class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invitation, only: [:destroy, :update]
  before_action :set_league, only: [:create, :new]

  def create
    @invitation = Invitation.new(invitations_params)
    if @invitation.save
      respond_to do |format|
        format.html { redirect_to league_url @league.id }
        format.json { render json: invitation_json }
      end
    else
      render json: @invitation.errors, status: :unprocessable_entity
    end
  end

  def new # html only
  end

  def update
    @league = @invitation.league
    @invitation.confirm
    respond_to do |format|
      format.html { redirect_to league_url @league.id }
      format.json { head :no_content }
    end
  end

  def destroy
    @invitation.destroy if @invitation
    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_json
    ActiveModel::InvitationSerializer.new(
      @invitation, root: 'invitation'
    ).to_json
  end

  def invitations_params
    respond_to do |format|
      format.html do
        user_id_from_user_email_param
      end
    end
    args = (params[:invitation] && params.require(:invitation)) || params
    args.permit(:user_id, :inviter_id, :league_id)
  end

  def user_id_from_user_email_param
    return if !params[:user] || !params[:user][:email]
    user = User.find_by(email: params[:user][:email])
    params.merge!(user_id: user.id)
  end
end
