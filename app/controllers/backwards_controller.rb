class BackwardsController < ApplicationController

	def new
	  @time = params[:hour].to_i
  	# @timeline = @user.time_travel(@time)
  end

  def show
  	binding.pry
  	@user = User.find(params[:id])
  	@time = params[:hour].to_i
  	@reversed_timeline = @user.reverse_time
  end

end