require 'rexml/document'
include REXML

namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_admin
    make_users
    make_sheets
  end

  task populateusers: :environment do
    make_users
  end

  task populatesheets: :environment do
    make_sheets
  end

  task dropsheets: :environment do
    Sheet.destroy_all
  end

  task createadmin: :environment do
    make_admin
  end

  task normalize_time: :environment do
    normalize_time
  end

  task init_time: :environment do
    init_time
  end

  task populatefoods: :environment do
    add_foods
  end

end

def make_admin
  admin = User.create!(name: "Michele Gozzi",
    email: "michelegozzi@gmail.com",
    password: "qazxsw",
    password_confirmation: "qazxsw")
    admin.toggle!(:admin)
end

def make_users
  24.times do |n|
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
  users = User.all(limit: 2)
  

  users.each do |user|

    max = 5
    day_start = Date.today - ((max+1)*2)
    week_start = day_start.strftime("%U").to_i;

    (0..5).each do |i|
      sheet = user.sheets.new
      prng = Random.new(1234)
      sheet.calorie_target = prng.rand(10..20) * 100
      
      sheet.date = day_start + (i*2)
      sheet.week_num = sheet.date.strftime("%U").to_i - week_start + 1
    
      sheet.energy_level = prng.rand(1..9)
      sheet.goals_met = prng.rand(1..1000) % 2 == 0 ? true : false
      sheet.notes = Faker::Lorem.sentence(5)
      sheet.sleep_hours = prng.rand(5..10)
      sheet.water_glasses = prng.rand(1..8)
    
      add_meals(sheet)
      add_activities(sheet)

      sheet.save!

    end
  end
  #user.sheets.create!( calorie_target: calorie_target, date: date, energy_level: energy_level, goals_met: goals_met, notes: notes, sleep_hours: sleep_hours, water_glasses: water_glasses, week_num: week_num )
  
end

def add_meals(sheet)
  time = Time.new(2000, 1 , 1)
  sheet.meals.new(name: 'Yogurt', time: time + (8*3600 + 15*60) , calories: 100, category: 1)
  sheet.meals.new(name: 'Caffe', time: time + (8*3600 + 15*60), calories: 30, category: 1)
  sheet.meals.new(name: 'Mela', time: time + (10*3600 + 35*60), calories: 80, category: 1)
  sheet.meals.new(name: 'Pasta', time: time + (13*3600 + 5*60), calories: 200, category: 3)
  sheet.meals.new(name: 'Pesce', time: time + (19*3600 + 10*60), calories: 120, category: 5)
  sheet.meals.new(name: 'Insalata', time: time + (19*3600 + 10*60), calories: 50, category: 5)
end

def add_activities(sheet)
  time = Time.new(2000, 1 , 1)
  sheet.activities.new(name: 'Core 20', time: time + (9*3600 + 15*60) , duration: 20, intensity: 3, category: 1)
  sheet.activities.new(name: 'Bike', time: time + (16*3600 + 15*60), duration: 15, intensity: 3, category: 2)
end

def make_meals
  users = User.all(limit: 6)

    users.each do |user|
      user.sheets.each do |sheet|
        time = Time.new(2000, 1 , 1)
        sheet.meals.create!(name: 'Yogurt', time: time + (8*3600 + 15*60) , calories: 100, category: 1)
        sheet.meals.create!(name: 'Caffe', time: time + (8*3600 + 15*60), calories: 30, category: 1)
        sheet.meals.create!(name: 'Mela', time: time + (10*3600 + 35*60), calories: 80, category: 1)
        sheet.meals.create!(name: 'Pasta', time: time + (13*3600 + 5*60), calories: 200, category: 3)
        sheet.meals.create!(name: 'Pesce', time: time + (19*3600 + 10*60), calories: 120, category: 5)
        sheet.meals.create!(name: 'Insalata', time: time + (19*3600 + 10*60), calories: 50, category: 5)

      end
    end
end

def make_activities
  users = User.all(limit: 6)

    users.each do |user|
      user.sheets.each do |sheet|
        time = Time.new(2000, 1 , 1)
        sheet.activities.create!(name: 'Core 20', time: time + (9*3600 + 15*60) , duration: 20, intensity: 3, category: 1)
        sheet.activities.create!(name: 'Bike', time: time + (16*3600 + 15*60), duration: 15, intensity: 3, category: 2)
      end
    end
end

def normalize_time
  Meal.all.each do |meal|


    if !meal.time.nil?

      timeoffset = meal.time.hour*3600 + meal.time.min * 60
      meal.time = Time.new(2000, 1 , 1) + timeoffset
      meal.save
    end
  end
end

def init_time

  time = Time.local(2000, 1 , 1)
  
  Meal.all.each do |meal|
    if !meal.category.nil?

      if meal.category == 1
        meal.time = time + (8*3600 + 15*60)
        meal.save
      elsif meal.category == 3
        meal.time = time + (13*3600 + 5*60)
        meal.save
      elsif meal.category == 5
        meal.time = time + (19*3600 + 10*60)
        meal.save
      end
    end
  end

end

def add_foods
  

  xmlfile = File.new(Rails.root.join('public', 'uploads', 'Food_Display_Table.xml'))
  xmldoc = Document.new(xmlfile)


  xmldoc.elements.each("Food_Display_Table/Food_Display_Row") do |e|

#    debugger
    food = Food.new

    e.elements.each("Food_Code") { |i| food.food_code = i.text.to_f }
    e.elements.each("Display_Name") { |i| food.display_name = i.text.to_s }
    e.elements.each("Portion_Default") { |i| food.portion_default = i.text.to_f }
    e.elements.each("Portion_Amount") { |i| food.portion_amount = i.text.to_f }
    e.elements.each("Portion_Display_Name") { |i| food.portion_display_name = i.text.to_s }
    e.elements.each("Factor") { |i| food.factor = i.text.to_f }
    e.elements.each("Increment") { |i| food.increment = i.text.to_f }
    e.elements.each("Multiplier") { |i| food.multiplier = i.text.to_f }
    e.elements.each("Grains") { |i| food.grains = i.text.to_f }
    e.elements.each("Whole_Grains") { |i| food.whole_grains = i.text.to_f }
    e.elements.each("Vegetables") { |i| food.vegetables = i.text.to_f }
    e.elements.each("Orange_Vegetables") { |i| food.orange_vegetables = i.text.to_f }
    e.elements.each("Drkgreen_Vegetables") { |i| food.drkgreen_vegetables = i.text.to_f }
    e.elements.each("Starchy_vegetables") { |i| food.starchy_vegetables = i.text.to_f }
    e.elements.each("Other_Vegetables") { |i| food.other_vegetables = i.text.to_f }
    e.elements.each("Fruits") { |i| food.fruits = i.text.to_f }
    e.elements.each("Milk") { |i| food.milk = i.text.to_f }
    e.elements.each("Meats") { |i| food.meats = i.text.to_f }
    e.elements.each("Soy") { |i| food.soy = i.text.to_f }
    e.elements.each("Drybeans_Peas") { |i| food.drybeans_peas = i.text.to_f }
    e.elements.each("Oils") { |i| food.oils = i.text.to_f }
    e.elements.each("Solid_Fats") { |i| food.solid_fats = i.text.to_f }
    e.elements.each("Added_Sugars") { |i| food.added_sugars = i.text.to_f }
    e.elements.each("Alcohol") { |i| food.alcohol = i.text.to_f }
    e.elements.each("Calories") { |i| food.calories = i.text.to_f }
    e.elements.each("Saturated_Fats") { |i| food.saturated_fats = i.text.to_f }
    food.save

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