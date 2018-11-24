module BorrowRequestsHelper 
    def get_pill_color_from_status(status)
        if status.camelize == "Approved" 
            return "green"
        else 
            return ""
        end 
    end 
end 