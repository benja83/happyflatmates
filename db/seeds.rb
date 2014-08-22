# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"

user1 = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: flat.id
user2 = User.create name:"kiko", email: "kiko@gmail.com", flat_id: flat.id
user3 = User.create name:"Elena", email: "elena@gmail.com", flat_id: flat.id
user4 = User.create name:"Cat", email: "cat@gmail.com", flat_id: flat.id
user5 = User.create name:"Ben", email: "tarennebenjamin@gmail.com", flat_id: flat.id

Event.create start: DateTime.now, end: DateTime.now + 1.hour, title: "first", flat_id: flat.id

purchase = Purchase.create name: 'oil', flat_id: flat.id
purchase1 = Purchase.create name: 'water', flat_id: flat.id