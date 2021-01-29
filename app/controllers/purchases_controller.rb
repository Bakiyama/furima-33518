class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  
  def index
    @item = Item.find(params[:item_id])
    @purchase = UserPurchase.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      @purchase.save
      redirect_to root_path
    else 
      render :index
    end
  end

  private

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :area_id, :city, :address, :building, :telephone).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
