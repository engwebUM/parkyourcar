FactoryGirl.create(:user, first_name: 'Admin', last_name: 'Test', username: 'admin',
                          email: 'admin@email.com', password: 'password')

FactoryGirl.create(:user, first_name: 'Eduardo', last_name: 'Pinto', username: 'eduardinho',
                          email: 'eduardo@email.com', password: 'qwertyuiop')

FactoryGirl.create(:user, first_name: 'Frederico', last_name: 'Carvalho', username: 'fredinho',
                          email: 'fred@email.com', password: '12345qwerty')

FactoryGirl.create(:user, first_name: 'Nuno', last_name: 'Gomes', username: 'nunogomes',
                          email: 'nunogomes@email.com', password: 'password')

FactoryGirl.create(:user, first_name: 'Nuno', last_name: 'Santos', username: 'nunomsantos',
                          email: 'nunomsantos@email.com', password: 'nunomsantos')

User.all.each do |user|
  FactoryGirl.create(:vehicle, user: user)
end

FactoryGirl.create(:space, user: User.find(1), country: 'USA', city: 'New York',
                           address: 'Allen Street', post_code: '10002',
                           price_hour: 1, price_week: 5, price_month: 15,
                           available_weekend: true)

FactoryGirl.create(:space, user: User.find(1), country: 'USA', city: 'New York',
                           address: 'Times Square', post_code: '10036',
                           price_hour: 2, price_week: 9.90, price_month: 35.90,
                           available_weekend: false)

FactoryGirl.create(:space, user: User.find(1), country: 'USA', city: 'New York',
                           address: 'Broadway', post_code: '2447', price_hour: 1.5,
                           price_week: 6, price_month: 19.5, available_weekend: true)

FactoryGirl.create(:space, user: User.find(3), description: 'Protect yourself from those driverless cars. Park here!',
                           country: 'USA', city: 'Mountain View', address: '1263 California St',
                           post_code: '94041', price_hour: 2, price_week: 7, price_month: 25,
                           available_weekend: false)

FactoryGirl.create(:space, user: User.find(5), description: 'It\'s a spot right in the middle of Central Park. Yay!',
                           country: 'USA', city: 'New York', address: 'Central Park',
                           post_code: '10024', price_hour: 10, price_week: 50, price_month: 150,
                           available_weekend: true)

User.all.each do |user|
  Space.all.each do |space|
    FactoryGirl.create(:review, user: user, space: space) unless space.user == user
  end
end

10.times do
  User.all.each do |user|
    Space.all.each do |space|
      next if space.user == user
      last_date = space.bookings.maximum(:date_until) || Time.zone.today + 2.days
      initial_date = last_date + Random.rand(3).days + Random.rand(24).hours + 1.hour
      final_date = initial_date + Random.rand(2).days + Random.rand(24).hours + 1.hour
      FactoryGirl.create(:booking, user: user, space: space, vehicle: user.vehicles.sample,
                                   date_from: initial_date, date_until: final_date)
    end
  end
end
