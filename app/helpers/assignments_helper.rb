module AssignmentsHelper
	def nested_assignments(assignments)
	  assignments.map do |assignment, sub_assignments|
	    render(assignment) + content_tag(:div, nested_assignments(sub_assignments), :class => "nested_assignments")
	  end.join.html_safe
	end
end
