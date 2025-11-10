FactoryBot.define do
  factory :currency do
    sequence(:code) { |n| format("C%02d", n)[0, 3] } # temp unique placeholder
    is_default { false }

    trait :default do
      is_default { true }
    end
  end
end
