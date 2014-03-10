namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_groups
    make_memberships
    make_posts
  end
end

def make_users
  anon = User.create!( name: "anonymous",
                       email:    "anon@whispr.com",
                       password: "anonpass",
                       feed_last_view: Time.now,
                       password_confirmation: "anonpass")

  matt = User.create!(name: "matt",
                       email:    "mattferrell2@gmail.com",
                       password: "password",
                       feed_last_view: Time.now,
                       password_confirmation: "password")

  admin = User.create!(name: "admin",
                       email:    "admin@whispr.com",
                       password: "password",
                       feed_last_view: Time.now,
                       password_confirmation: "password")

  10.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    name = first_name + " " + last_name
    username = first_name.downcase[0,1] + last_name.downcase
    email = "example-#{n+1}@whispr.com"
    password  = "password"
    User.create!(name:     username,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_groups
  10.times do |n|
    name = Faker::Company.name
    content = Faker::Company.catch_phrase
    Group.create!(name: name,
                  )
  end
end

def make_posts
  users = User.all(limit: 6)
  10.times do
    title = Faker::Lorem.sentence(1)
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.posts.create!(title: title, content: content, group_id: user.groups.find(1).id ) }
  end
end

def make_memberships
  users = User.all
  groups = Group.all
  group = groups.first

  users.each{ |user| user.follow!(group)}

  #user  = users.first
  #followed_users = users[2..50]
  #followers      = users[3..40]
  #followed_users.each { |followed| user.follow!(followed) }
  #followers.each      { |follower| follower.follow!(user) }
end
