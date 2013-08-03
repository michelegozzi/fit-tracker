class Admin::FoodsController < ApplicationController
	helper_method :sort_column, :sort_direction

	before_filter :admin_user

	def index
		#@foods = Food.find(:all).order(sort_column + " " + sort_direction).paginate(page: params[:page], :per_page => 20)

		@foods = Food.select("id, display_name, calories").order(sort_column + " " + sort_direction).paginate(page: params[:page], :per_page => 20)
	end

	def search
		q = params[:q]
		@foods = Food.where("display_name LIKE :q", :q => "%#{q}%").select("id, display_name, calories").order(sort_column + " " + sort_direction).paginate(page: params[:page], :per_page => 20)
	end

	def show
		@food = Food.find(params[:id])
		#store_location
	end

	def create
		@food = Food.new(params[:food])
		if @food.save
			flash[:success] = "Food created!"
			redirect_to admin_food_path(@food)
		else
			render 'new'
		end
	end

	def edit
		@food = Food.find(params[:id])
	end

	def update
		@food = Food.find(params[:id])
		
		if @food.update_attributes(params[:food])
			flash[:success] = "Food updated"
			redirect_to @food
		else
			render 'edit', params[:food]
		end
	end

	def destroy
		#debugger
		@food = Food.find(params[:id])
		@food.destroy
		flash[:success] = "Food destroyed."
		redirect_to admin_foods_path
	end

	def new
		@food = Food.new
	end

	def upload
		uploaded_io = params[:foods_data]
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(uploaded_io.read)
		end

		debugger

		xmlfile = File.new(Rails.root.join('public', 'uploads', uploaded_io.original_filename))
		xmldoc = Document.new(xmlfile)


		xmldoc.elements.each("collection/foods") do |e|
			display_name = e.attributes["display_name"]
			calories = e.attributes["calories"]
			Food.create!(display_name: display_name, calories: calories)
		end


		redirect_to admin_foods_path
	end

	private
		def admin_user
			redirect_to(root_path) unless signed_in? and current_user.admin?
		end

		def sort_column
			Food.column_names.include?(params[:sort]) ? params[:sort] : "display_name"
		end

		def sort_direction
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
		end
end
