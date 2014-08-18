# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"

user1 = User.new name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: flat.id
user2 = User.new name:"kiko", email: "kiko@gmail.com", flat_id: flat.id
user3 = User.new name:"Elena", email: "elena@gmail.com", flat_id: flat.id
user4 = User.new name:"Cat", email: "cat@gmail.com", flat_id: flat.id
user5 = User.new name:"Ben", email: "tarennebenjamin@gmail.com", flat_id: flat.id

Event.create start: DateTime.now, end: DateTime.now + 1.hour, title: "first"