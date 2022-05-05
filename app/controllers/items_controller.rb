class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
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

  private

  def item_param
    params.require(:item).permit(:name, :explanation, :price, :category_id, :condition_id, :charge_id, :prefecture_id, :date_id, :explanation, :image).merge(user_id: current_user.id)
    
  end



end
