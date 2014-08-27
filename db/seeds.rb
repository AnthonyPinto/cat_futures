# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 100.times do |i|
#   c = Cat.create!(
#     name: Faker::Name.name,
#     age: 3,
#     birth_date: Faker::Business.credit_card_expiry_date,
#     color: Faker::Commerce.color,
#     sex: ['M', 'F'].sample,
#     description: Faker::Hacker.say_something_smart
#   )
# end


CatRentalRequest.create!(
  cat_id: 1,
  start_date: Time.now,
  end_date: 7.days.from_now,
  status: "DENIED"
  )
  #Overlaps with request above
CatRentalRequest.create!(
  cat_id: 1,
  start_date: 7.days.ago,
  end_date: 2.days.from_now,
  status: "DENIED"
  )
  
# CatRentalRequest.create!(
#   cat_id: 1,
#   start_date: 7.days.ago
#   end_date: 2.days.from_now
#   status: "DENIED"
  # )
  
CatRentalRequest.create!(
  cat_id: 1,
  start_date: 1.month.ago,
  end_date: 3.weeks.ago,
  status: "DENIED"
  )
