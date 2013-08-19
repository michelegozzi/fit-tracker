class SheetsController < ApplicationController
	require 'json'

	before_filter :signed_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
	#before_filter :fix_meals_params, :only => [:create, :update]

	def show
		@sheet = current_user.sheets.find(params[:id])
		store_location
	end

	def new
    date = params[:date].to_date

    if date.nil?
      date = Time.new
    end

		@sheet = current_user.sheets.new
		@sheet.date = date
	end

	def create

		@sheet = current_user.sheets.new(params[:sheet])
		if @sheet.save
			#parsed_json = JSON(your_json_string)
			flash[:success] = "Sheet created!"
			redirect_to @sheet
		else
			render 'new'
		end
	end

	def edit
		@sheet = Sheet.find(params[:id])
	end

	def update
		@sheet = Sheet.find(params[:id])
		
		if @sheet.update_attributes(params[:sheet])
			flash[:success] = "Sheet updated"
			redirect_to @sheet
		else
			render 'edit', params[:sheet]
		end
	end

	def destroy
		debugger
		@sheet = current_user.sheets.find(params[:id])
		@sheet.destroy
		flash[:success] = "Sheet destroyed."
		redirect_to current_user
	end


	def index
		if signed_in? 
			day = 0

			@sheets = current_user.sheets.find(:all, :order => "date").each { |s| s.day = day = day+1 }
			render :json => custom_json_for(@sheets) # in questo modo posso vedere il json da browser

			return
			# in questo modo non posso vedere il json da browser
			# respond_to do |format|
			# 	format.html
			# 	format.json do
			# 		render :json => custom_json_for(@sheets)
			# 	end
			# end
		else
			render :nothing => true, :status => 404
		end
	end		

	private
		def custom_json_for(value)
			list = value.map do |sheet|
				{
					:id => sheet.id,
					:title => "Day #{sheet.day}",
					:start => "#{sheet.date.strftime("%Y-%m-%d")}",
					:backgroundColor => sheet.goals_met? ? "green" : "red",
					:allDay => true,
					:user_id => "#{sheet.user_id}"
				}
			end
			list.to_json
		end

		#def fix_meals_params
			#o = params[:sheet][:meals]
			#debugger
		#end
end