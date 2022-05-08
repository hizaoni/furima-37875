class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_idex, only: [:edit, :destroy]
  before_action :find_item, only: [:show, :update, :edit]

  def index
    @items = Item.order(id: :DESC)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_param)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_param)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_param
    params.require(:item).permit(:name, :explanation, :price, :category_id, :condition_id, :charge_id, :prefecture_id, :date_id,
                                 :explanation, :image).merge(user_id: current_user.id)
  end

  def move_to_idex
    @item = Item.find(params[:id])
    redirect_to root_path if current_user.id != @item.user_id
  end

  def find_item
    @item = Item.find(params[:id])
  end
end

