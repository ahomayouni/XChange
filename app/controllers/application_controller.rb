class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	# Automagically link with Sessions Controller and provide variety of functionality
	include SessionsHelper 
	include ListingsHelper
end
