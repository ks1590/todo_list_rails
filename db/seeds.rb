password = "123456"

User.create!(
  name: "admin_user",
  email: "test_admin@example.com",
  password: password,
  password_confirmation: password,
  admin: true
)

5.times do |n|
  name = Faker::JapaneseMedia::Doraemon.character
  email = "test#{ n + 1 }@example.com"

  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    admin: false
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

labels = ["赤", "黄", "緑", "青"]

labels.each {|label|
  Label.create!(
    name: label
  )
}

20.times do |n|
  TaskLabel.create!(task_id: rand(1..20), label_id: rand(1..4))
end