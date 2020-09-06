class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def index
    @items = Item.order(id: :desc).page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "商品を投稿しました。"
      redirect_to items_path
    else
      flash.now[:danger] = "商品の投稿に失敗しました。"
      render :new
    end  
  end

  def destroy
    @item.destroy
    flash[:success] = "商品を削除しました。"
    redirect_back(fallback_location: items_path)
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    
    if @item.update(item_params)
      flash[:success] = "商品は正常に更新されました。"
      redirect_to @item
    else
      flash.now[:danger] = "商品は更新されませんでした。"
      render :edit
    end  
  end  
  
  private
  
  def item_params
    params.require(:item).permit(:content, :image)
  end  
  
  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to items_path
    end
  end  
end
