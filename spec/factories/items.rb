FactoryBot.define do
  factory :item do
    name               { 'test' }
    description        { 'test' }
    category_id        { 1 }
    item_condition_id  { 1 }
    delivery_fee_id    { 1 }
    delivery_source_id { 1 }
    delivery_date_id   { 1 }
    selling_price      { 1000 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.image.png'), filename: 'test.image.png')
    end
  end
end
