# Clear previous data
require "open-uri"

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

club_images = [
  {
    name: "CE-Europa",
    header_img_url: "https://www.ceeuropa.cat/images/ElClub/nou-sardenya.jpg",
    logo_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Club_Esportiu_Europa.svg/1200px-Club_Esportiu_Europa.svg.png"
  },
  {
    name: "FC-Barcelona",
    header_img_url: "https://a1.elespanol.com/cronicaglobal/2024/08/20/culemania/palco/879672197_13361005_1706x960.jpg",
    logo_url: "https://upload.wikimedia.org/wikipedia/de/a/aa/Fc_barcelona.svg"
  },
  {
    name: "CF-Badalona",
    header_img_url: "https://static.ostadium.com/galleries/estadio-municipal-de-badalona-illus.jpg",
    logo_url: "https://admin.europeanleague.football/_default_upload_bucket/3978/image-thumb__3978___auto_db149ca27ea780f9a1c401b107c0c12a/onddi-proyectos-badalona-stadium-02.583428ca.webp"
  },
  {
    name: "Girona-FC",
    header_img_url: "https://statics-maker.llt-services.com/gir/images/2021/01/28/original/96e5e74b-8074-4ba6-b12d-b3c530d5ce77-1225220138.jpeg",
    logo_url: "https://upload.wikimedia.org/wikipedia/en/thumb/f/f7/Girona_FC_Logo.svg/1200px-Girona_FC_Logo.svg.png"
  },
  {
    name: "RCD-Espanyol",
    header_img_url: "https://www.rcdespanyol.com/assets/images/sections/club/tour/como_llegar_RCDESTADIUM.jpg",
    logo_url: "https://e7.pngegg.com/pngimages/549/858/png-clipart-rcd-espanyol-la-liga-rcde-stadium-football-atletico-madrid-espanyol-barcelona-escudo-i-text-logo-thumbnail.png"
  }
]

clubs = []
users.each_with_index do |user, i|
  club_data = club_images[i]
  club = Club.create(
    name: "Club#{i + 1}",
    description: "Welcome to Club#{i + 1}!",
    user: user
  )
  if club.persisted?
    header_img_file = URI.open(club_data[:header_img_url])
    club.header_img.attach(io: header_img_file, filename: "header_#{club_data[:name]}.jpg", content_type: "image/jpg")

    logo_file = URI.open(club_data[:logo_url])
    club.logo.attach(io: logo_file, filename: "logo_#{club_data[:name]}.jpg", content_type: "image/jpg")

    clubs << club
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
end
