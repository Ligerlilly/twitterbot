class User < ActiveRecord::Base
   has_many :tweets

   def self.find_by_tweets(tweets)
     @users = []
     tweets.each do |tweet|
       user = User.find(tweet.user_id)
       @users.push(user)
     end
     @users
   end

end
