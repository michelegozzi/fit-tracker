class Admin::GlobalMealsController < ApplicationController
	def index
	end

	def show
	end

	def upload
		uploaded_io = params[:meals_data]
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
			file.write(uploaded_io.read)
		end
	end
end
