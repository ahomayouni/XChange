module UsersHelper
    def is_current_user
        @user = User.find(params[:id])
        if @user.id == current_user.id
            return true
        else
            return false
        end
    end

    def get_rounded_user_rating(user_id)
       @user = User.find(user_id)
       if @user.person.rating.nil?
           return 0
       else
           return @user.person.rating.round
       end
   end 
end
