FactoryBot.define do
  factory :task do
    name { 'テスト1' }
    content { 'test_todo1' }
    deadline { '2020-12-20' }
    status { '完了' }
    priority { '中' }
  end

  factory :second_task, class: Task do
    name { 'テスト2' }
    content { 'test_todo2' }
    deadline { '2020-12-28'}
    status { '未着手' }
    priority { '高' }  
  end

  factory :third_task, class: Task do
    name { 'テスト3' }
    content { 'test_todo3' }
    deadline { '2020-12-30' }
    status { '着手中' }
    priority { '低' }  
  end
end