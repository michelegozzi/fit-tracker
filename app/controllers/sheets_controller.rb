class SheetsController < ApplicationController
	require 'json'

	before_filter :signed_in_user, only: [:show, :new, :create, :edit, :update, :destroy]

	before_filter :fix_meals_params, :only => [:create, :update]

	def show
		@sheet = current_user.sheets.find(params[:id])
		store_location
		#@meals = @sheet.meals.order("time ASC").paginate(page: params[:page], :per_page => 3)
	end

	def new
		@sheet = current_user.sheets.new
		@sheet.date = Time.new #.strftime("%d-%m-%Y")

		#@breakfast_meals = []
		#@lunch_meals = []
		#@dinner_meals = []
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
		#if current_user?(@user)
		#	flash[:error] = "You can't destroy yourself."
		#	redirect_to users_url
		#else
			@sheet.destroy
			flash[:success] = "Sheet destroyed."
			redirect_to current_user
		#end

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
					#:backgroundColor => sheet.goals_met = 0 ? "grey" : sheet.goals_met = 1 ? "red" : "green",
					#:backgroundColor => sheet.goals_met?.nil ? "grey" : sheet.goals_met? ? "green" : "red",
					:backgroundColor => sheet.goals_met? ? "green" : "red",
					:allDay => true,
					:user_id => "#{sheet.user_id}"
				}
			end
			list.to_json
		end

		def fix_meals_params

			o = params[:sheet][:meals]
			#debugger
			logger.debug o
		end
end