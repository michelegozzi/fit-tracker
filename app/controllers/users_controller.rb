class UsersController < ApplicationController
	helper_method :sort_column, :sort_direction

	before_filter :signed_in_user, only: [:edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: [:index, :destroy]
	before_filter :avoided_to_signed_in_user, only: [:new, :create]

  # Returns a collection of users in a paginated form (10 elements per page)
	def index
		@users = User.paginate(page: params[:page], :per_page => 10)
	end

  # Accepts:
  # 1. users's <tt>params[:id]</tt>
  # 2. <tt>sort_column</tt>, see the helper method <tt>sort_column</tt>
  # 3. <tt>sort_direction</tt>
  # 4. params[:page]
  #
  # Returns:
  # 1. an <tt>@user</tt> instance selected by <tt>params[:id]</tt>
  # 2. a sorted collection of sheets, handled by the user, in a paginated form (7 elements per page)
	def show
		@user = User.find(params[:id])
		@sheets = @user.sheets.order(sort_column + " " + sort_direction).paginate(page: params[:page], :per_page => 7)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Fit Tracker!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	#
	# Destroy the selected user. An user can't destroy himself.
	#
	# error_1:
	#   SQLite3::SQLException: cannot start a transaction within a transaction: begin transaction
	# solution_1:
	#   @user.destroy statement throws this exeception.
	#   I fixed the problem adding an index on the table :users for the column :email (see db/migration/20130528055555_add_index_to_users_email.rb)
	#
	def destroy
		@user = User.find(params[:id])
		if current_user?(@user)
			flash[:error] = "You can't destroy yourself."
			redirect_to users_url
		else
			@user.destroy
			flash[:success] = "User destroyed."
			redirect_to users_url
		end

	end

	private
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			#redirect_to(root_path) unless current_user.admin?
      redirect_to(root_path) unless signed_in_as_admin?
		end

		def avoided_to_signed_in_user
			redirect_to(root_path) unless !signed_in?
		end

		def sort_column
			Sheet.column_names.include?(params[:sort]) ? params[:sort] : "date"
		end

		def sort_direction
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
		end


end
