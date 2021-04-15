FactoryBot.define do
  factory :purchase_shipping_address do
    postal_code { '123-4567' }
    city { '東京都' }
    address { '1-1' }
    phone_number { '09012345678' }
    user_id { 1 }
    item_id { 1 }
    delivery_source_id { 1 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
