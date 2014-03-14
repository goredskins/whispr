namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_groups
    make_memberships
    make_posts
    make_comments
  end
end

def make_users()
  anon = User.create!( name: "anonymous",
                       email:    "anon@whispr.com",
                       password: "anonpass",
                       feed_last_view: Time.now,
                       password_confirmation: "anonpass")

  matt = User.create!(name: "matt",
                       email: "mattferrell2@gmail.com",
                       password: "password",
                       feed_last_view: Time.now,
                       password_confirmation: "password")
  william = User.create!(name: "william",
                         email: "william@whispr.com",
                         password: "password",
                         avatar: File.new("public/images/sample/william.jpg"),
                         password_confirmation: "password")
  eva = User.create!(name: "eva",
                         email: "eva@whispr.com",
                         password: "password",
                         avatar: File.new("public/images/sample/eva.jpg"),
                         password_confirmation: "password")
  jackie = User.create!(name: "jackie",
                         email: "jackie@whispr.com",
                         password: "password",
                         avatar: File.new("public/images/sample/jackie.jpg"),
                         password_confirmation: "password")
  sarah = User.create!(name: "sarah",
                         email: "sarah@whispr.com",
                         password: "password",
                         avatar: File.new("public/images/sample/sarah.jpg"),
                         password_confirmation: "password")
end

def make_groups
  Group.create!(name: "WE <3 NATHAN",
                description: "a page for the cutest black guy and the girls who love him")
end

def make_posts
  post1 = Post.create!(content: "He could stay at my house any night ;)", 
                      group_id: 1, 
                      user_id: User.find_by(name: "sarah").id,
                      media: "https://twitter.com/goredskins47/statuses/364571043081355264",
                      media_type: 0)

  post2 = Post.create!(content: "awwwwwwww",
                      group_id: 1,
                      user_id: User.find_by(name: "eva").id,
                      media: "<div id=\"fb-root\"></div> <script>(function(d, s, id) { var js, fjs = d.getElementsByTagName(s)[0]; if (d.getElementById(id)) return; js = d.createElement(s); js.id = id; js.src = \"//connect.facebook.net/en_US/all.js#xfbml=1\"; fjs.parentNode.insertBefore(js, fjs); }(document, 'script', 'facebook-jssdk'));</script> <div class=\"fb-post\" data-href=\"https://www.facebook.com/photo.php?fbid=10201108215056925&amp;set=a.2803518656528.147315.1515458785&amp;type=1\" data-width=\"466\"><div class=\"fb-xfbml-parse-ignore\"><a href=\"https://www.facebook.com/photo.php?fbid=10201108215056925&amp;set=a.2803518656528.147315.1515458785&amp;type=1\">Post</a> by <a href=\"https://www.facebook.com/nathanthillairajah\">Nathan Thillairajah</a>.</div></div>",
                      media_type: 2)

  post3 = Post.create!(content: "look at him go!",
                      group_id: 1,
                      user_id: User.find_by(name: "william").id,
                      media: "http://instagram.com/p/Lq9h6aE1AF/",
                      media_type: 1)

  post4 = Post.create!(content: "best day ever!",
                      group_id: 1,
                      user_id: User.find_by(name: "william").id,
                      image: File.new("public/images/sample/lawl.jpg"),
                      media_type: 3)
  post5 = Post.create!(content: "it's so hard to delay my texts when he's all I ever think about",
                      group_id: 1,
                      user_id: User.find_by(name: "jackie").id,
                      media_type: -1)
end

def make_comments
  Comment.create!(user_id: User.find_by(name: "eva").id, 
                  post_id: 1, 
                  content: "I wish he would have taken me to rock the bells :(",
                  secondary_content: [])

  Comment.create!(user_id: User.find_by(name: "sarah").id, 
                  post_id: 1, 
                  content: "Maybe he'll take you to that AER concert!",
                  secondary_content: [])

  Comment.create!(user_id: User.find_by(name: "eva").id, 
                  post_id: 1, 
                  content: "I wish :(",
                  secondary_content: ["that'd be so awesome", "maybe his coolest, best-advice-giving-est friend will convince him to invite me"])

 Comment.create!(user_id: User.find_by(name: "sarah").id, 
                  post_id: 1, 
                  content: "you're right, that would be a very good idea that Nathan should listen to.",
                  secondary_content: [])

  Comment.create!(user_id: User.find_by(name: "jackie").id, 
                  post_id: 2, 
                  content: "what a great family guy",
                  secondary_content: [])

  Comment.create!(user_id: User.find_by(name: "william").id, 
                  post_id: 2, 
                  content: "so adorable!",
                  secondary_content: [])

  Comment.create!(user_id: User.find_by(name: "sarah").id, 
                  post_id: 2, 
                  content: "aww",
                  secondary_content: [])


 Comment.create!(user_id: User.find_by(name: "jackie").id, 
                  post_id: 3, 
                  content: "omg william",
                  secondary_content: [])

 Comment.create!(user_id: User.find_by(name: "william").id, 
                  post_id: 3, 
                  content: "hahahaah",
                  secondary_content: [])

 Comment.create!(user_id: User.find_by(name: "eva").id, 
                  post_id: 3, 
                  content: "sploosh",
                  secondary_content: [])

 Comment.create!(user_id: User.find_by(name: "jackie").id, 
                  post_id: 4, 
                  content: "looks like fun",
                  secondary_content: [])

 Comment.create!(user_id: User.find_by(name: "william").id, 
                  post_id: 4, 
                  content: "it was!",
                  secondary_content: ["so much fun!"])

 Comment.create!(user_id: User.find_by(name: "william").id, 
                  post_id: 5, 
                  content: "I know the feeling",
                  secondary_content: [])
 Comment.create!(user_id: User.find_by(name: "eva").id, 
                  post_id: 5, 
                  content: ":(",
                  secondary_content: [])

end

def make_memberships
  users = User.all
  groups = Group.all
  group = groups.first
  users.each{ |user| user.follow!(group)}

end
