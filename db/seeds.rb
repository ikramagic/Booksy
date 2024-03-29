# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Article.destroy_all
User.destroy_all

5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

User.all.each do |user|
  5.times do
    article = user.articles.create!(
      title: Faker::Book.title,
      content: Faker::TvShows::Simpsons.quote,
      private: [true, false].sample
    )
    
    rand(1..5).times do 
      Comment.create!(
        body: Faker::TvShows::Simpsons.quote,
        user: User.all.sample,
        article: article
      )
    end
  end
end

puts "Created #{User.count} users, #{Article.count} articles, and #{Comment.count} comments."
