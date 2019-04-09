# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(name: "Josefina", email: "jrvalenzuela@miunades.cl", city: "santiago", country: "chile", picture: "hola", birthdate: "12-12-2018", biography: "hola", password: "123456789", password_confirmation: "123456789", terms:true)
u = User.create(name: "Martin Concha", email: "maconcha1@miunades.cl", city: "santiago", country: "chile", picture: "hola", birthdate: "03-12-1996", biography: "hola", password: "123456789", password_confirmation: "123456789", terms:true)
p = Post.create(title: "hola", description: "hola", close: false, user_id: 1)