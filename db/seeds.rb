%w[fastest slowest db app ballancer rabbitmq sidekiq cache_db].each do
  |tag_name| Tag.create(name: tag_name)
  end

10.times do |time|
  User.create(
    first_name: "First_#{time}",
    last_name: "Last_#{time}",
    balance: rand(10000)
  )
end

users = User.all
tags = Tag.all

100_000.times do |time|
  Order.create(
    name: "vm-#{time}",
    cost: rand(10000),
    status: rand(5),
    user: users.shuffle.first,
    #tags: tags.sample(rand(8))
  )
end