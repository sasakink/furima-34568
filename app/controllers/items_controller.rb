class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @item = Item.new
  end

  def index
    @items = Item.all
    # @items = Item.order("created_at DESC")
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :item_condition_id, :delivery_fee_id, :delivery_source_id,
                                 :delivery_date_id, :selling_price, :user, :image).merge(user_id: current_user.id)
  end
end
