class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invitation, only: [:destroy, :confirm]
  before_action :set_league, only: [:create]

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

  def confirm
    @league_id = @invitation.league_id
    @invitation.confirm
    respond_to do |format|
      format.html { redirect_to league_url @league.id }
      format.json { head :no_content }
    end
  end

  def destroy
    @invitation.destroy if @invitation
    head :no_content
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
    args = params.require(:invitation)
    args.permit(:user_id, :inviter_id)
  end
end
