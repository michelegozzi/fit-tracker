class SheetsController < ApplicationController

	def show
		if signed_in? 
			@sheet = current_user.sheets.find(params[:id])
		else
			redirect_to root_url
		end
	end


	def index

#		if signed_in? 
			#@sheets = current_user.sheets.find_all

			#@celebs = Celebrity.find_by_sql("SELECT id, first_name || ' ' || last_name AS name FROM celebrities WHERE first_name LIKE '#{@starts}%'")

		
  		#respond_to do |format|
    		#format.html
    	#	format.json { @celebs.to_json }
  		#end

  		#render :json => @celebs


#{"title":"Varsity Cheerleading practice","start":"2011-10-13","allday":false},
			
#		else
#			redirect_to root_url
#		end
#	end

		if signed_in? 

			@sheets = current_user.sheets.find_all
			
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
					:id => "#{sheet.id}",
					:title => "Day #{sheet.day}",
					:start => "#{sheet.date}",
					#:backgroundColor => sheet.goals_met = 0 ? "grey" : sheet.goals_met = 1 ? "red" : "green",
					#:backgroundColor => sheet.goals_met?.nil ? "grey" : sheet.goals_met? ? "green" : "red",
					:backgroundColor => sheet.goals_met? ? "green" : "red",
					:allDay => true,
					:user_id => "#{sheet.user_id}"

#<Sheet id: 1, calories_target: 1300, date: "2013-05-20 17:25:43",
# week_num: 1, day: 1, water_glasses: 5, sleep_hours: 9
#, notes: "Eligendi quia ratione assumenda non rem.", : true, energy_level: 7, user_id: 1, created_at: "2013-05-30 17:25:43", updated_at: "2013-05-30 17:25:43">


				}
			end
			list.to_json
		end


end
