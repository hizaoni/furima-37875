class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :prefecture
  belongs_to :schedule

  validates :name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true, numericality: { in: 300..9999999 }, format: { with: /\A[0-9]+\z/ }


  validates :category_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" } 
  validates :charge_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :date_id, numericality: { other_than: 1, message: "can't be blank" }
end
