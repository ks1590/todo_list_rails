I18n.config.available_locales = :en

5.times do |n|
  name = Faker::JapaneseMedia::Doraemon.character
  email = "test#{ n + 1 }@example.com"
  password = "123456"

  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

status = ["未着手","着手中","完了"]
start_date = Date.parse("2021/02/01")
end_date = Date.parse("2021/02/28")

20.times do |n|
  get_date = Random.rand(start_date .. end_date)
  title = Faker::Movies::HarryPotter.book
  description = Faker::Movies::HarryPotter.quote
  status = ["未着手","着手中","完了"]

  Task.create!(name: title,
              content: description,
              deadline: get_date,
              status: status.sample,
              priority: rand(0..2),
              user_id: rand(1..5))
end