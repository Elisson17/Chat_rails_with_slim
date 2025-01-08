# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_1 = User.create(name: "Elisson", email: "teste@teste.com", password: "123456")
user_2 = User.create(name: "João", email: "teste2@teste2.com", password: "Teste#1234./")
user_3 = User.create(name: "Ronaldo", email: "teste3@teste3.com", password: "123456")

chat_room_1 = ChatRoom.create(room_type: "direct")
chat_room_1.chat_room_users.create(user_id: user_1.id)
chat_room_1.chat_room_users.create(user_id: user_2.id)

chat_room_2 = ChatRoom.create(room_type: "direct")
chat_room_2.chat_room_users.create(user_id: user_1.id)
chat_room_2.chat_room_users.create(user_id: user_3.id)

chat_room_3 = ChatRoom.create(room_type: "direct")
chat_room_3.chat_room_users.create(user_id: user_2.id)
chat_room_3.chat_room_users.create(user_id: user_3.id)
