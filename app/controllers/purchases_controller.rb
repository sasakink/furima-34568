class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_date, only: [:index, :create]
  before_action :move_to_index

  def index
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_params)
    if @purchase_shipping_address.valid?
      pay_item
      @purchase_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping_address).permit(:postal_code, :delivery_source_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def item_date
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.selling_price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    return redirect_to root_path if current_user.id == @item.user.id || user_signed_in? && !@item.purchase.nil?
  end
end
