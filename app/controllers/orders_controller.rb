class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_idex, only: :index

  def index
    @item = Item.find(params[:item_id])
  end

  private

  def move_to_idex
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
