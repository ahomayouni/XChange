module UsersHelper
    def is_current_user
        @user = User.find(params[:id])
        if @user.id == current_user.id
            return true 
        else 
            return false 
        end 
    end 
end
