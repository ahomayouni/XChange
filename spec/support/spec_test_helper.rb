module SpecTestHelper   
  def login(user)
    # user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
    session[:user_id] = user.id
  end

  def current_user
    User.find(session[:user_id])
  end
end