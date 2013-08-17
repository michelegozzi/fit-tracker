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

  # Creates script include tag elements for a javascript file in the :extrahead placeholder
	def include_javascript (file)
		content_for(:extrahead) { javascript_include_tag file }
	end

  # Creates link tag elements for a css file in the :extraheadstyle placeholder
	def include_style (file)
		content_for(:extraheadstyle) { stylesheet_link_tag file }
	end

  # Renders script include tag elements for a javascript in the :extrahead placeholder
	def include_javascript_render (file)
		s = " <script type=\"text/javascript\">" + render(:file => file) + "</script>"
		content_for(:extrahead, raw(s))
	end

  # Creates a link tag that renders the form fields elements for the nested Activity model
  #
  # Arguments:
  # * innerText, inner text of the link tag element (it's possible to pass an html_safe element)
  # * f, form_for element
  # * association, use the symbol (default = :meals)
  # * category_id, category identifier
	def link_to_add_meal_fields(inner_text, f, association = :meals, category_id)
	 	new_object = f.object.class.reflect_on_association(association).klass.new(:category => category_id, :calories => 0)
	 	link_to_add_fields(inner_text, f, association, category_id, new_object)
	end

  # Creates a link tag that renders the form fields elements for the nested Activity model
  #
  # Arguments:
  # * innerText, inner text of the link tag element (it's possible to pass an html_safe element)
  # * f, form_for element
  # * association, use the symbol (:activities)
  # * category_id, category identifier
  # * new_object, created by the class definition of an association reflection object
  #
  # Example:
  #   <%= link_to_add_activity_fields '<i class="icon-plus icon-white"></i>'.html_safe, f, :activities, category_id %>
	def link_to_add_activity_fields(inner_text, f, association = :activities, category_id)
	 	new_object = f.object.class.reflect_on_association(association).klass.new(:category => category_id, :duration => 0, :intensity => 0)
	 	link_to_add_fields(inner_text, f, association, category_id, new_object)
	end

  # Creates a link tag that removes the form field elements
  #
  # Arguments:
  # * innerText, inner text of the link tag element (it's possible to pass an html_safe element)
  # * f, form_for element
  # * association, use the symbol
	def link_to_remove_fields(inner_text, f, association)
		f.hidden_field(:_destroy) + link_to_function(inner_text, "remove_#{association.to_s.singularize}_fields(this)")
	end

  # Creates a link tag that renders the form fields elements for nested models
  #
  # Arguments:
  # * innerText, inner text of the link tag element (it's possible to pass an html_safe element)
  # * f, form_for element
  # * association, use the symbol
  # * category_id, category identifier
  # * new_object, created by the class definition of an association reflection object
	def link_to_add_fields(inner_text, f, association, category_id, new_object)
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(inner_text, "add_#{association.to_s.singularize}_fields(this, '#{association}', '#{escape_javascript(fields)}')")
	end

  # Creates a link tag that handle the sorting criteria (column name and direction).
  # It passes to the controller the <tt>:sort</tt> and <tt>:direction</tt> parameters.
  # 
  # Arguments:
  # * column, identifies the column name used in the sorting criteria
  # * title, the description used in the link tag element
  # * icon_asc, bootstrap icon css classes used for the ascending icon rappresentation (default: <tt>icon-arrow-up icon-white</tt>)
  # * icon_desc, bootstrap icon css classes used for the descending icon rappresentation (default: <tt>icon-arrow-down icon-white</tt>)
  # * icon_default, bootstrap icon css classes used for the default icon rappresentation (default: <tt>icon-list icon-white</tt>)
	def sortable(column, title = nil, icon_asc = "icon-arrow-up icon-white", icon_desc = "icon-arrow-down icon-white", icon_default = "icon-list icon-white")
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		i_css_class = column == sort_column ? sort_direction == "asc" ? icon_asc : icon_desc : icon_default
		
		link_to "#{title} #{content_tag :i, nil, class: i_css_class}".html_safe, {:sort => column, :direction => direction, :q => params[:q].nil? ? '' : params[:q]}, {:class => css_class}
	end
end
