class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
  end

  def new
    Item.new
  end

  def create
    Item.cleate(iten_param)
  end

  private

  def iten_param
    params.require(:item).permit(:name, :explanation, :price, :category_id, :condition_id, :charge_id, :prefecture_id, :date_id, :explanation, :image).merge(user_id: current_user.id)
    
  end



end
