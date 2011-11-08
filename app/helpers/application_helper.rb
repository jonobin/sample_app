module ApplicationHelper
  # Return a title on a per-page basis.
  def title                                                 # Documentation comment
    base_title = "Ruby on Rails Tutorial Sample App"        # Method definition
    if @title.nil?                                          # Variable assignment
      base_title                                            # Boolean test for nil
    else                                                    # Implicit return
      "#{base_title} | #{@title}"                           # String interpolation
    end
  end
end
