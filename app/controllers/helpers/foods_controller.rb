class Helpers::FoodsController < ApplicationController
	def index
		if signed_in? 
			day = 0

			@foods = Food.where("display_name LIKE :q", :q => "%#{params[:q]}%").select("display_name, portion_display_name, calories").order("display_name")
			render :json => custom_json_for(@foods) # in questo modo posso vedere il json da browser

			return
			# in questo modo non posso vedere il json da browser
			# respond_to do |format|
			# 	format.html
			# 	format.json do
			# 		render :json => custom_json_for(@meals)
			# 	end
			# end
		else
			render :nothing => true, :status => 404
		end
	end		

	private
		def custom_json_for(value)
			list = value.map do |food|
				{
					:name => "#{food.display_name}, #{food.portion_display_name.strip}",
					:calories => "#{food.calories.to_i}"
				}
			end
			list.to_json
		end
end
