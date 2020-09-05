class ChatsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @item = Item.find(params[:id])
    @chat = @item.chats.build
    @chats = @item.chats.order(id: :desc)
  end

  def create
    @item = Item.find(params[:id])
    @chats = @item.chats.order(id: :desc)
    @chat = @item.chats.build(chat_params)
    @chat.user_id = current_user.id
    if @chat.save
      flash[:success] = "メッセージを送信しました。"
      redirect_to chats_path 
    else
      flash.now[:danger] = "メッセージの送信に失敗しました。"
      render :index
    end  
  end

  def destroy
    @chat.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_back(fallback_location: chats_path)
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:content)
  end  
  
  def correct_user
    @chat = current_user.chats.find_by(id: params[:id])
    unless @chat
      redirect_to chats_path
    end
  end  
end
