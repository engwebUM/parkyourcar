# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
u1 = User.create(first_name: 'Admin',
                 last_name: 'Test',
                 username: 'admin',
                 email: 'admin@email.com',
                 password: 'password')

u2 = User.create(first_name: 'Eduardo',
                 last_name: 'Pinto',
                 username: 'eduardinho',
                 email: 'eduardo@email.com',
                 password: 'qwertyuiop')

u3 = User.create(first_name: 'Frederico',
                 last_name: 'Carvalho',
                 username: 'fredinho',
                 email: 'fred@email.com',
                 password: '12345qwerty')

u4 = User.create(first_name: 'Nuno',
                 last_name: 'Gomes',
                 username: 'nunogomes',
                 email: 'nunogomes@email.com',
                 password: 'password')

u5 = User.create(first_name: 'Nuno',
                 last_name: 'Santos',
                 username: 'nunomsantos',
                 email: 'nunomsantos@email.com',
                 password: 'nunomsantos')

s1 = Space.create(user: u1,
                  title: 'Space One',
                  available_spaces: 1,
                  description: 'This is a not so short description about Space One. It is intended to be somewhat long for testing purposes.',
                  country: 'USA',
                  city: 'New York',
                  address: 'Allen Street',
                  post_code: '10002',
                  price_hour: 1,
                  price_week: 5,
                  price_month: 15,
                  latitude: 40.718760,
                  longitude: -73.990486,
                  date_from: '2015-01-01',
                  date_until: '2015-12-31',
                  available_weekend: true)

s2 = Space.create(user: u1,
                  title: 'Space Two',
                  available_spaces: 1,
                  description: 'A brief description about Space Two.',
                  country: 'USA',
                  city: 'New York',
                  address: 'Times Square',
                  post_code: '10036',
                  price_hour: 2,
                  price_week: 9.90,
                  price_month: 35.90,
                  latitude: 40.758883,
                  longitude: -73.985142,
                  date_from: '2015-02-01',
                  date_until: '2015-04-30',
                  available_weekend: false)

s3 = Space.create(user: u1,
                  title: 'Space Three',
                  available_spaces: 1,
                  description: 'An even briefer description.',
                  country: 'USA',
                  city: 'New York',
                  address: 'Broadway',
                  post_code: '2447',
                  price_hour: 1.5,
                  price_week: 6,
                  price_month: 19.5,
                  latitude: 40.790962,
                  longitude: -73.974711,
                  date_from: '2015-01-10',
                  date_until: '2015-10-01',
                  available_weekend: true)

s4 = Space.create(user: u3,
                  title: 'Space Four',
                  available_spaces: 1,
                  description: 'Protect yourself from those driverless cars. Park here!',
                  country: 'USA',
                  city: 'Mountain View',
                  address: '1263 California St',
                  post_code: '94041',
                  price_hour: 2,
                  price_week: 7,
                  price_month: 25,
                  latitude: 37.393046,
                  longitude: -122.085208,
                  date_from: '2015-02-02',
                  date_until: '2015-12-12',
                  available_weekend: false)

s5 = Space.create(user: u5,
                  title: 'Space Five',
                  available_spaces: 1,
                  description: 'It\'s a spot right in the middle of Central Park. Yay!',
                  country: 'USA',
                  city: 'New York',
                  address: 'Central Park',
                  post_code: '10024',
                  price_hour: 10,
                  price_week: 50,
                  price_month: 150,
                  latitude: 40.782989,
                  longitude: -73.965356,
                  date_from: '2015-03-01',
                  date_until: '2015-05-31',
                  available_weekend: true)

r1 = Review.create(user: u2,
                   space: s1,
                   evaluation: 5,
                   comment: 'Very funny!')

r2 = Review.create(user: u3,
                   space: s1,
                   evaluation: 4,
                   comment: 'Thumbs up!')

r3 = Review.create(user: u4,
                   space: s2,
                   evaluation: 1,
                   comment: 'This will be a longer review. I\'m really, really mad so I want to let you know that. The experience was awful.')

r4 = Review.create(user: u5,
                   space: s3,
                   evaluation: 3,
                   comment: 'It was ok, I guess.')

r5 = Review.create(user: u2,
                   space: s4,
                   evaluation: 2,
                   comment: 'Meh.')

b1 = Booking.create(user: u1,
                    space: s1,
                    date_from: '2015-01-02',
                    date_until: '2015-01-30',
                    state: 'sent')

b2 = Booking.create(user: u1,
                    space: s1,
                    date_from: '2015-03-03',
                    date_until: '2015-04-04',
                    state: 'sent')

b3 = Booking.create(user: u1,
                    space: s2,
                    date_from: '2015-02-15',
                    date_until: '2015-02-20',
                    state: 'pending')

b4 = Booking.create(user: u1,
                    space: s3,
                    date_from: '2015-02-03',
                    date_until: '2015-03-04',
                    state: 'pending')

b5 = Booking.create(user: u1,
                    space: s4,
                    date_from: '2015-03-01',
                    date_until: '2015-04-01',
                    state: 'pending')

b6 = Booking.create(user: u1,
                    space: s5,
                    date_from: '2015-05-01',
                    date_until: '2015-05-05',
                    state: 'accepted')

b7 = Booking.create(user: u1,
                    space: s5,
                    date_from: '2015-05-06',
                    date_until: '2015-05-07',
                    state: 'accepted')

b8 = Booking.create(user: u1,
                    space: s5,
                    date_from: '2015-05-08',
                    date_until: '2015-05-09',
                    state: 'accepted')

b9 = Booking.create(user: u1,
                    space: s5,
                    date_from: '2015-05-10',
                    date_until: '2015-05-15',
                    state: 'accepted')

b10 = Booking.create(user: u1,
                    space: s5,
                    date_from: '2015-05-16',
                    date_until: '2015-05-25',
                    state: 'accepted')

b11 = Booking.create(user: u1,
                    space: s5,
                    date_from: '2015-05-27',
                    date_until: '2015-05-29',
                    state: 'accepted')

b12 = Booking.create(user: u1,
                    space: s5,
                    date_from: '2015-06-07',
                    date_until: '2015-06-09',
                    state: 'accepted')
