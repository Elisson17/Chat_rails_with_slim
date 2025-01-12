# frozen_string_literal: true

class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :accept, :decline]

  def index
    @received_invites = current_user.received_invites.pending
    @sent_invites = current_user.sent_invites
  end

  def create
    receiver = User.find_by(invite_code: params[:invite_code])

    if receiver.nil?
      flash[:alert] = "Usuário não encontrado. Verifique o código e tente novamente."
      redirect_to invites_path and return
    end

    if Invite.exists?(sender_id: current_user.id, receiver_id: receiver.id)
      flash[:alert] = "Você já enviou um convite para este usuário."
    else
      Invite.create(sender_id: current_user.id, receiver_id: receiver.id, status: "pending")
      flash[:notice] = "Convite enviado com sucesso!"
    end

    redirect_to invites_path
  end

  def accept
    @invite = Invite.find(params[:id])
    @invite.update(status: 'accepted')

    sender_id = User.find(@invite.sender_id)
    receiver_invite = User.find(@invite.receiver_id)

    chat = ChatRoom.create(room_type: 'direct')
    chat.users << sender_id unless chat.users.include?(sender_id)
    chat.users << receiver_invite unless chat.users.include?(receiver_invite)

    redirect_to root_path
  end

  def decline
    @invite = Invite.find(params[:id])
    @invite.update(status: 'rejected')
    redirect_to user_path(current_user)
  end

  private

  def invite_params
    params.require(:invite).permit(:sender_id, :receiver_id, :status)
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end
end
