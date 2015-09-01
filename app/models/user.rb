class User < ActiveRecord::Base
	

	def self.create_with_omniauth(auth)
		# binding.pry
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.token = auth['credentials']['token']
      user.secret = auth['credentials']['secret']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def twitter
  	@client ||= Twitter::REST::Client.new do |config|
  		config.consumer_key        = Rails.application.secrets.omniauth_provider_key
  		config.consumer_secret     = Rails.application.secrets.omniauth_provider_secret
  		config.access_token        = token
  		config.access_token_secret = secret
		end
		@client
  end

  def display_timeline
  	timeline_search_results = []
  	twitter.home_timeline(options={count: 5}).each do |tweet|
  		timeline_search_results << [tweet.user.name, tweet.text, tweet.created_at]
  	end
  	timeline_search_results
  end

  def reverse_time(hours)
  	timeline_search_results = []
  	seconds = hours * 60 * 60
    time = Time.now - seconds
    twitter.home_timeline(options={count: 5}).each do |tweet|
    	# binding.pry
      if tweet.created_at > time
        timeline_search_results << [tweet.user.name, tweet.text, tweet.created_at]
      end
    end
    timeline_search_results
  end

end


