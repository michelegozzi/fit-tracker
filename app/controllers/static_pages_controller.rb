class StaticPagesController < ApplicationController
	helper_method :sort_column, :sort_direction

	def about
	end

	def home

		if signed_in?
			@user = current_user
			@sheets = @user.sheets.order(sort_column + " " + sort_direction).paginate(page: params[:page], :per_page => 4)
		end
	end

	private

		def sort_column
			Sheet.column_names.include?(params[:sort]) ? params[:sort] : "date"
		end

		def sort_direction
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
		end
end
