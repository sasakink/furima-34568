class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_source_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は(-)ハイフンを含めて入力してください' }
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: 'は半角数字で入力してください' },
                             length: { maximum: 11, message: 'は11桁以内で入力してください' }
    validates :user_id
    validates :item_id
    validates :delivery_source_id, numericality: { other_than: 0, message: 'を入力してください' }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, delivery_source_id: delivery_source_id, city: city, address: address,
                           building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
