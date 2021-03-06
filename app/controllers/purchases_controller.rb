class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  
  def index
    @item = Item.find(params[:item_id])
    if (@item.purchase != nil) || current_user.id == @item.user_id 
      redirect_to root_path
    end
    @purchase = UserPurchase.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    else 
      render :index
    end
  end

  private

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :area_id, :city, :address, :building, :telephone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end 
end
