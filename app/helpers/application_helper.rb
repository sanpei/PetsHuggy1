module ApplicationHelper
	def controller?(controller)
		return controller.include?(params[:controller])
	end	

	def action?(action)
		return action.include?(params[:action])
	end
end
