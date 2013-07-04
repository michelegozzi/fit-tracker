require 'rexml/document'
include REXML

class Admin::GlobalMealsController < ApplicationController
	def index
	end

	def show
	end

	def upload
		uploaded_io = params[:meals_data]
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(uploaded_io.read)
		end

		debugger

		xmlfile = File.new(Rails.root.join('public', 'uploads', uploaded_io.original_filename))
		xmldoc = Document.new(xmlfile)

		
		xmldoc.elements.each("collection/meal") do |e|
			name = e.attributes["name"]
			calories = e.attributes["calories"]

			time = Time.new(2000, 1 , 1)

			Meal.create!(name: name, time: time, calories: calories, category: 0)
		end


		redirect_to admin_global_meals_path
	end
end
