class Backward

	def reverse_time(hours)
  	timeline_search_results = []
  	hours_converted = hours * 60 * 60
    time = Time.now - hours_converted
    twitter.home_timeline(:count => 10).each do |tweet|
      if tweet.created_at > time
        timeline_search_results << [tweet.user.name, tweet.text]
      end
    end
    timeline_search_results
  end

end