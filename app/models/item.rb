class Item < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :delivery_fee
  belongs_to :delivery_source
  belongs_to :delivery_date

  validates :category_id, :item_condition_id, :delivery_fee_id, :delivery_source_id, :delivery_date_id,
            numericality: { other_than: 0 }
  with_options presence: true do
    validates :name
    validates :description
    validates :category_id
    validates :item_condition_id
    validates :delivery_fee_id
    validates :delivery_source_id
    validates :delivery_date_id
    validates :selling_price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'は半角数字、¥300~¥9,999,999で入力してください。' }
  end
end
