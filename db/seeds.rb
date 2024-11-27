
User.destroy_all
Club.destroy_all
Quiniela.destroy_all

user1 = User.create(
  email: 'user1@example.com',
  password: 'password123',
  first_name: 'John',
  last_name: 'Doe',
  phone_number: '1234567890'
)

user2 = User.create(
  email: 'user2@example.com',
  password: 'password123',
  first_name: 'Jane',
  last_name: 'Doe',
  phone_number: '0987654321'
)

if user1.persisted? && user2.persisted?
  puts "Users created successfully!"
else
  puts "Failed to create one or more users."
  puts user1.errors.full_messages unless user1.persisted?
  puts user2.errors.full_messages unless user2.persisted?
end

club1 = Club.create(
  name: 'CE Europa',
  description: 'Welcome to CE Europa!',
  logo: 'CEElogo.jpg',
  picture: 'CEEimage.jpg',
  user: user1
)

club2 = Club.create(
  name: 'RCD Espanyol',
  description: 'Welcome to RCD Espanyol de Barcelona!',
  logo: 'RCDlogo.jpg',
  picture: 'RCDimage.jpg',
  user: user2
)

if club1.persisted? && club2.persisted?
  puts "Clubs created successfully!"
else
  puts "Failed to create one or more clubs."
  puts club1.errors.full_messages unless club1.persisted?
  puts club2.errors.full_messages unless club2.persisted?
end

quiniela1 = club1.quinielas.create(
  title: 'Quiniela 1',
  start_date: Date.tomorrow,
  reward: '1000 Euros',
  result: nil
)

quiniela2 = club2.quinielas.create(
  title: 'Quiniela for CE Europa',
  start_date: Date.today + 5.days,
  reward: '500 Euros',
  result: nil
)


if quiniela1.persisted? && quiniela2.persisted?
  puts "Quinielas created successfully!"
else
  puts "Failed to create one or more quinielas."
  puts quiniela1.errors.full_messages unless quiniela1.persisted?
  puts quiniela2.errors.full_messages unless quiniela2.persisted?
end
