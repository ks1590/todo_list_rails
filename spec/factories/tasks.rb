FactoryBot.define do
  factory :task do
    name { 'テスト1' }
    content { 'test_todo1' }
    deadline { '002020-12-30' }
    priority { '中' }
    status { '完了' }
  end

  factory :second_task, class: Task do
    name { 'テスト2' }
    content { 'test_todo2' }
    deadline { '002020-12-30'}
    priority { '中' }
    status { '未着手' }  
  end

  factory :third_task, class: Task do
    name { 'テスト3' }
    content { 'test_todo3' }
    deadline { '002020-12-30' }
    priority { '低' } 
    status { '着手中' }
  end
end