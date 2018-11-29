module BorrowRequestsHelper 
    def get_pill_color_from_status(status)
        if status.camelize == "Approved" 
            return "success"
        elsif status.camelize=="Requested" 
            return "info"
        elsif status.camelize=="Rejected"
            return "danger"
        elsif status.camelize=="Borrowed"
            return "primary"
        elsif status.camelize=="Returned"
            return "dark"
        end 
    end 
end 