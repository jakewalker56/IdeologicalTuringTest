class UsersController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
	def edit
	end

	def update
		respond_to do |format|
	      if @user.update(user_params)
	      	if !ENV["SHOW_SUBMIT_ANSWER"].present? || ENV["SHOW_SUBMIT_ANSWER"].downcase == "true"
	        	format.html { redirect_to user_my_submissions_url(current_user), notice: 'User was successfully updated.' }   	
	        else
	        	format.html { redirect_to topics_url, notice: 'User was successfully updated.' }
	        end
	      else
	        format.html { render :edit }
	        
	      end
	    end
	end

	private
	  	def set_user
	      @user = User.find(params[:id])
	    end

	    def user_params
	       params.require(:user).permit(:class_year, :gender, :age, :political_affiliation, :citizenship_status)
	    end
end
