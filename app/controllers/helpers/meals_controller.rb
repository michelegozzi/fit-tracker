class Helpers::MealsController < ApplicationController
  def index
  end

  def index
		if signed_in? 
			day = 0

			@meals = Meal.where("name LIKE :q", :q => "%#{params[:q]}%").select("DISTINCT name, calories").order("name")
			render :json => custom_json_for(@meals) # in questo modo posso vedere il json da browser

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
			list = value.map do |meal|
				{
					:name => "#{meal.name}",
					:calories => "#{meal.calories}"
				}
			end
			list.to_json
		end

end
