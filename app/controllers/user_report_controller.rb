class UserReportController < ApplicationController
	def delete_request
		if UserReport.exists?(id: params[:id])
			@report = UserReport.find_by(id: params[:id])
			if @report
				@report.destroy
				flash[:success] = "Request will be taken care of."
			end
		end
		redirect_to(user_path(current_user,active_tab: "actionItems"))
	end
end
