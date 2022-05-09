class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number,
                :token

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :municipality
    validates :house_number
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, numericality: { only_integer: true, message: '"電話番号は半角数字で、ハイフン（-)は除いてください"' },
                             length: { minimum: 10, maximum: 11 }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality,
                   house_number: house_number, building_name: building_name, phone_number: phone_number)
  end
end
