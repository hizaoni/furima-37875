class OrderAddress

  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number

  # バリデーションを書く

  def save
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, building_name: building_name, phone_number: phone_number)


  end
end