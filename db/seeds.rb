5.times do
  name = Faker::Book.unique.genre
  description = Faker::Lorem.sentence(word_count: 5)
  Category.create!(name:name,
                  description: description
  )
end

5.times do
  name = Faker::Book.unique.publisher
  address = Faker::Address.full_address
  phone = 1234567890
  description = Faker::Lorem.sentence(word_count: 5)
  Publisher.create!(name: name,
                    address: address,
                    phone: phone,
                    description: description
  )
end

5.times do
  name = Faker::Book.author
  description = Faker::Lorem.sentence(word_count: 10)
  Author.create!(name: name,
                  description: description
  )
end

50.times do
  name = Faker::Book.unique.title
  description = Faker::Lorem.sentence(word_count: 50)
  price = Faker::Commerce.price(range: 1..100.0, as_string: true)
  publish_year = Faker::Date.between(from: '2000-01-01', to: '2022-01-01')
  book_details = (1..5).map do |i|
    {edition: "Episode #{i}",
     quantity: Faker::Number.between(from: 50, to: 100)}
  end
  Book.create!(name: name,
               description: description,
               price: price,
               publish_year: publish_year,
               publisher_id: Publisher.all.pluck(:id).sample,
               category_id: Category.all.pluck(:id).sample,
               book_authors_attributes: [author_id: Author.all.pluck(:id).sample],
               book_details_attributes: book_details,
               created_at: (rand*30).days.ago
  )
end

10.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               role: 0,
               confirmed_at: Time.now)
end

User.create!(name: "abc",
             email: "admin@gmail.com",
             password: "password",
             password_confirmation: "password",
             role: 1,
             confirmed_at: Time.now)

20.times do |n|
  start_at = Faker::Time.between(from: 2.days.ago, to: Time.now)
  end_at = Faker::Time.forward(days: 100, period: :morning)
  code = "code-#{n+1}"
  percent = Faker::Number.between(from: 1, to: 10)
  quantity = Faker::Number.between(from: 100, to: 500)
  Discount.create!(start_at: start_at,
                   end_at: end_at,
                   code: code,
                   percent: percent,
                   quantity: quantity)
end

50.times do
  Address.create!(receiver: Faker::Name.name,
                  address: Faker::Address.street_address,
                  phone: 982423412,
                  user_id: User.all.pluck(:id).sample)
end

discount_ids = []
(1..20).map do |i|
  discount_ids << i
end

200.times do
  user_id = User.all.pluck(:id).sample
  Order.create!(user_id: user_id,
                discount_id: discount_ids.sample,
                status: Faker::Number.between(from: 0, to: 2),
                address_id: User.find(user_id.to_s).addresses.ids.sample,
                created_at: (rand*30).days.ago)
end

600.times do
  book_detail_id = BookDetail.all.pluck(:id).sample
  OrderDetail.create!(order_id: Order.all.pluck(:id).sample,
                      book_detail_id: book_detail_id,
                      quantity: Faker::Number.between(from: 1, to: 5),
                      price: BookDetail.find(book_detail_id).book.price)
end
