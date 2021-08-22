# メインのサンプルユーザーを１人作成する
User.create!(name: "Example User",
             email: "example@example.com",
             password: "password",
             password_confirmation: "password",
             introduction: "Example Userです。よろしくお願いします。")

# 追加のユーザーをまとめて生成する
4.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  introduction = Faker::Lorem.sentence(word_count: 5)
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               introduction: introduction)
end

# 部屋をまとめて生成する
users = User.all
5.times do |n|
  name = "部屋#{n + 1}"
  introduction = Faker::Lorem.sentence(word_count: 5)
  price = (n + 1) * 5000
  address = Gimei.address.kanji
  users.each { |user| user.rooms.create!(name: name,
                                         introduction: introduction,
                                         price: price,
                                         address: address) }
end

# メインのサンプルルームを５部屋作成する
user = User.first
user.rooms.create!(name: "別荘　スキー場近く",
                   introduction: "スキー場まで徒歩5分！ レンタル品割引サービス付き",
                   price: 6000,
                   address: "北海道札幌市")
user.rooms.create!(name: "星の見える部屋",
                   introduction: "満点の星空！お楽しみください",
                   price: 10000,
                   address: "大阪府大阪市")
user.rooms.create!(name: "自然に囲まれたお部屋",
                   introduction: "夕食付き！京野菜をお楽しみください。",
                   price: 7000,
                   address: "京都府宇治市")
user.rooms.create!(name: "海が部屋から見える部屋",
                   introduction: "海がすぐ近く！",
                   price: 11000,
                   address: "沖縄県那覇市")
user.rooms.create!(name: "夜景が綺麗なタワーマンション",
                   introduction: "都心の夜景が一望できます",
                   price: 20000,
                   address: "東京都港区")


# 予約をまとめて生成する
5.times do |n|
  room_id = n + 1
  room = Room.find(room_id)
  start_date = Date.today + n + 1
  end_date = Date.today + 2 * (n + 1)
  person_num = n + 1
  total_price = (end_date - start_date).to_i * room.price * person_num
  users.each { |user| user.reservations.create!(room_id: room_id,
                                                start_date: start_date,
                                                end_date: end_date,
                                                person_num: person_num,
                                                total_price: total_price) }
end
