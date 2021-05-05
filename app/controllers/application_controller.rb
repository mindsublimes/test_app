class ApplicationController < ActionController::Base
	before_action :set_locale

	def set_locale
		I18n.locale = session[:locale] || I18n.default_locale
 	end

 	def session_language
 		session[:locale]|| I18n.default_locale
 	end
end
