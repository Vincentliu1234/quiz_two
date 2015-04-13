# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  Question.create(title: Faker::Company.bs,
                  body:  Faker::Lorem.paragraph)
end


["Potatos", "News", "Space", "Life", 
      "Food" ].each do |c|
  Category.create(name: c)
end