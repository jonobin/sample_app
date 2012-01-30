module MicropostsHelper
	def display(content)
		Rinku.auto_link(sanitize(wrap(content)))
	end

	#This was originally wrapped in a raw{} tag but I removed this because there were problems with number of arguments
	def wrap(content)
		content.split.map { |s|	wrap_long_string(s) }.join(' ')
	end

	private
		def wrap_long_string(text, max_width = 30)
			zero_width_space = "&#8203;"

			regex = /.{1,#{max_width}}/
			(text.length < max_width) ? text : 
										text.scan(regex).join(zero_width_space)
		end
end