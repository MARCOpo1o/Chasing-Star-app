# Generate posts for a subset of users.
users = User.order(:created_at).take(10)
10.times do
  message = Faker::Lorem.sentence(word_count: 10)
  users.each { |user| user.posts.create!(message: message, rate: Faker::Number.between(from: 1, to: 5), location_id: Faker::Number.between(from: 1, to: 10)) }
end

10.times do
  comment = Faker::Lorem.sentence(word_count: 10) 
  users.each { |user| user.comments.create!(message: comment, post_id: Faker::Number.between(from: 1, to: 100)) }   
end