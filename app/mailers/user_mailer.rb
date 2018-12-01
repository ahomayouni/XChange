class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activate your Account!"
  end

  def password_reset(user)
    @user = user 
    mail to: user.email, subject: "Password Reset"
  end

  def late_reminder(user)
  	@user = user 
  	mail to: user.email, subject: "Late Item Due"
  end
end
