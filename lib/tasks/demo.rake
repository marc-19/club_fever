namespace :demo do
  task setup: :environment do
    user = User.create!(
      email: "user_#{SecureRandom.hex(3)}@example.com",
      password: "password",
      first_name: "Lee",
      last_name: "Wagon",
      is_admin: false
    )

    quiniela_69 = Quiniela.find(69)
    quiniela_70 = Quiniela.find(70)


    Prediction.create!(
      user: user,
      quiniela: quiniela_69,
      result: ["X", "2", "X", "1", "2", "2", "1"] # Deliberately incorrect
    )


    Prediction.create!(
      user: user,
      quiniela: quiniela_70,
      result: quiniela_70.result # Matches the quiniela result
    )


    quiniela_70.predictions.each do |prediction|
      if prediction.result == quiniela_70.result
        Win.create!(quiniela: quiniela_70, user: prediction.user)
      end
    end


    puts "Created user #{user.email}."
    puts "User is the winner of Quiniela #{quiniela_70.id} and not of Quiniela #{quiniela_69.id}."
  end
end
