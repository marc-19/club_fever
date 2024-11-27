# Clear previous data
User.destroy_all
Club.destroy_all
Quiniela.destroy_all

# Seed data
users = []
5.times do |i|
  user = User.create(
    email: "user#{i + 1}@example.com",
    password: 'password123',
    first_name: "User#{i + 1}",
    last_name: "Last#{i + 1}",
    phone_number: "123456789#{i}"
  )
  users << user if user.persisted?
end

if users.size == 5
  puts "5 users created successfully!"
else
  puts "Error creating users."
end

clubs = []
users.each_with_index do |user, i|
  club = Club.create(
    name: "Club#{i + 1}",
    description: "Welcome to Club#{i + 1}!",
    logo: "CEElogo.jpg",
    picture: "CEEimage.jpg",
    user: user
  )
  clubs << club if club.persisted?
end

if clubs.size == 5
  puts "5 clubs created successfully!"
else
  puts "Error creating clubs."
end

clubs.each_with_index do |club, i|
  quiniela = club.quinielas.create(
    title: "Quiniela for #{club.name}",
    start_date: Date.today + i.days,
    end_date: Date.today + (i + 7).days,
    reward: "#{(i + 1) * 100} Euros",
    local_teams: ["Team A#{i}", "Team B#{i}", "Team C#{i}", "Team D#{i}"],
    visitor_teams: ["Team X#{i}", "Team Y#{i}", "Team Z#{i}", "Team W#{i}"]
  )
  if quiniela.persisted?
    puts "Quiniela for #{club.name} created successfully!"
  else
    puts "Error creating quiniela for #{club.name}: #{quiniela.errors.full_messages.join(", ")}"
  end
end
