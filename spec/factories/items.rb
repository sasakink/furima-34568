FactoryBot.define do
  factory :item do
    name               { 'test' }
    description        { 'test' }
    category_id        { '1' }
    item_condition_id  { '1' }
    delivery_fee_id    { '1' }
    delivery_source_id { '1' }
    delivery_date_id   { '1' }
    selling_price      { '1000' }
  end
end
