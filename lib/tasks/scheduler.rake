desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  User.all.each do |user|
  	user.send_reminders
  end
end