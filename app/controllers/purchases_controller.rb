class PurchasesController < ApplicationController
  def index
    @purchase = UserPurchase.new
  end

  def create
    @purchase = UserPurchase.new(purchase_params)
    @purchase.save
  end

  private

  def purchase_params
    params.require(:user_purchase).permit()
  end
end
