namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    make_sheets
  end
end

def make_users
  admin = User.create!(name: "Michele Gozzi",
    email: "michelegozzi@gmail.com",
    password: "qazxsw",
    password_confirmation: "qazxsw")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name: name,
      email: email,
      password: password,
      password_confirmation: password)
  end
end

def make_sheets
  users = User.all(limit: 6)

  max = 5

  week_start = 0;

  #(1..5).to_a.reverse.each do |i|
  (1..max).each do |i|
    prng = Random.new(1234)

    now = Time.new

    if week_start == 0
      week_start = now.strftime("%U").to_i - 1
    end

    calories_target = prng.rand(10..20) * 100
    date = now - ( 86400 * (max + 1 - i) * 2 )
    day = i
    energy_level = prng.rand(1..10)
    goals_met = prng.rand(1..1000) % 2 == 0 ? true : false
    notes = Faker::Lorem.sentence(5)
    sleep_hours = prng.rand(5..10)
    water_glasses = prng.rand(1..8)
    week_num = now.strftime("%U").to_i - week_start

    users.each do |user|
      user.sheets.create!( calories_target: calories_target, date: date, day: day, energy_level: energy_level, goals_met: goals_met, notes: notes, sleep_hours: sleep_hours, water_glasses: water_glasses, week_num: week_num )
    end
  end
end

# 11.17
# def make_relationships
#  users = User.all
#  user  = users.first
#   followed_users = users[2..50]
#   followers      = users[3..40]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end