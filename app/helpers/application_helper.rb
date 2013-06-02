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
end
