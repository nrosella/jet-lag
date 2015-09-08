class UsersController < ApplicationController

	before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

  def show
  	# binding.pry
    @user = current_user
    @timeline = @user.display_timeline

  end

  def update
    # binding.pry
  	@user = User.find(params[:id])
  	@time = params[:hour].to_i
  	@reversed_timeline = @user.reverse_time(@time)
  	@sorted = @reversed_timeline.collect.sort_by{|t| t[2]}

    respond_to do |format|
      format.html {render :_reversed_timeline}
      format.js  
    end
  	
  end


end

