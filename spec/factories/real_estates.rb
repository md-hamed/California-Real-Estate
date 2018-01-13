FactoryBot.define do
  factory :real_estate do
    street Faker::Address.street_name
    city Faker::Address.city
    zip Faker::Address.zip_code
    state Faker::Address.state
    beds { rand(1..10) }
    baths { rand(1..3) }
    sq_ft { rand(50..10000) }
    sale_date "2018-01-13 16:19:06"
    price { rand(100..1_000_000) }
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
