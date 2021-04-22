class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :move_to_rootpath, only: [:edit, :update]
  before_action :search_product, only: [:index, :search, :show]
  before_action :set_item_column, only: [:index, :search, :show]

  def new
    @item = Item.new
  end

  def index
    @items = Item.order('created_at DESC')
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    redirect_to action: :index if @item.destroy
  end

  def search
    @results = @p.result.order('created_at DESC')
    # @items = Item.search(params[:keyword]).order("created_at DESC")
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :item_condition_id, :delivery_fee_id, :delivery_source_id,
                                 :delivery_date_id, :selling_price, :user, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    return redirect_to root_path if current_user.id != @item.user.id
  end

  def move_to_rootpath
    redirect_to root_path if (current_user.id = @item.user.id) && @item.purchase
  end

  def search_product
    @p = Item.ransack(params[:q]) # 検索オブジェクトを生成
  end

  def set_item_column
    @item_name = Item.select('name').distinct  # 重複なくnameカラムのデータを取り出す
  end
end
