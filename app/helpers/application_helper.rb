module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title)
	    base_title = "Fit Tracker"
	    if page_title.empty?
	    	base_title
	    else
	    	"#{base_title} | #{page_title}"
	    end
	end

	def include_javascript (file)
		content_for(:extrahead) { javascript_include_tag file }
	end

	def include_style (file)
		content_for(:extraheadstyle) { stylesheet_link_tag file }
	end

	def include_javascript_render (file)
		s = " <script type=\"text/javascript\">" + render(:file => file) + "</script>"
		content_for(:extrahead, raw(s))
	end

	#def gravatar_for(user, options = { size: 50 } )
	#	gravatar_id = Digest::MD5::hexdigest(user.name.downcase)
	#	size = options[:size]
	#	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	#	image_tag(gravatar_url, alt: "#{user.name}", class: "gravatar")
	#end

	# def link_to_remove_meal_fields(name, f)
	# 	f.hidden_field(:_destroy) + link_to_function(name, "remove_meal_fields(this)")
	# end

	def link_to_add_meal_fields(name, f, association, categoryId)
	 	new_object = f.object.class.reflect_on_association(association).klass.new(:category => categoryId, :calories => 0)
	 	link_to_add_fields(name, f, association, categoryId, new_object)
	# 	fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
	# 		render(association.to_s.singularize + "_fields", :f => builder)
	# 	end
	# 	link_to_function(name, "add_meal_fields(this, '#{association}', '#{escape_javascript(fields)}')")
	end

	def link_to_add_activity_fields(name, f, association, categoryId)
	 	new_object = f.object.class.reflect_on_association(association).klass.new(:category => categoryId, :duration => 0, :intensity => 0)
	 	link_to_add_fields(name, f, association, categoryId, new_object)
	# 	fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
	# 		render(association.to_s.singularize + "_fields", :f => builder)
	# 	end
	# 	link_to_function(name, "add_meal_fields(this, '#{association}', '#{escape_javascript(fields)}')")
	end

	def link_to_remove_fields(name, f, association)
		f.hidden_field(:_destroy) + link_to_function(name, "remove_#{association.to_s.singularize}_fields(this)")
	end

	def link_to_add_fields(name, f, association, categoryId, new_object)
		#new_object = f.object.class.reflect_on_association(association).klass.new(:category => categoryId, :calories => 0)
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, "add_#{association.to_s.singularize}_fields(this, '#{association}', '#{escape_javascript(fields)}')")
	end

	def sortable(column, title = nil, icon_asc = "icon-arrow-up icon-white", icon_desc = "icon-arrow-down icon-white", icon_default = "icon-list icon-white")
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		i_css_class = column == sort_column ? sort_direction == "asc" ? icon_asc : icon_desc : icon_default
		
		#link_to title, {:sort => column, :direction => direction}, {:class => css_class}
		link_to "#{title} #{content_tag :i, nil, class: i_css_class}".html_safe, {:sort => column, :direction => direction}, {:class => css_class}

	end


end
