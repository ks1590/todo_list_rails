FactoryBot.define do
  factory :label do
    name { "HTML" }
  end

  factory :second_label, class: Label do
    name { "JavaScript" }
  end

  factory :third_label, class: Label do
    name { "Ruby" }
  end
end
