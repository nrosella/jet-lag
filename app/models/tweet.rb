class Tweet < ActiveRecord::Base
	belongs_to :user

	validates :user_id, :body, presence: true

	before_create :post_tweet

	def post_tweet
		user.twitter.update(body)
	end

end
