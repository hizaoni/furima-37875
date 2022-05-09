class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_idex, only: :index

  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def move_to_idex
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def order_params
    params.permit(:item_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end


end
