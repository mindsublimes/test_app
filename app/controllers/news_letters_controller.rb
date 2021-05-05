class NewsLettersController < ApplicationController
  before_action :set_locale, only: [:change_language]
  def new
    @news_letter = NewsletterSubscriber.new
  end

  def create
    if params[:email].present?
      email            = params[:email]
      preference       = [params[:preferences_1], params[:preferences_2], params[:preferences_3]]
      preferences      = "#{preference if !preference.compact.empty?}"
      @news_letter     = NewsletterSubscriber.new(email: email, preferences: preferences)
      uri              = URI("https://emailvalidation.abstractapi.com/v1/?api_key=952ff156df854486affc620543a057e2&email=#{email}")
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      request          =  Net::HTTP::Get.new(uri)
      response         = http.request(request)
      response_body    = JSON.parse(response.body)
      if response_body["quality_score"] == "0.70"
        if @news_letter.save
          UserMailer.with(email: email).welcome_email.deliver_now
          flash[:success] = "You have subscribe successfully."
          redirect_to new_news_letter_path
        else
          flash[:notice]  = "Not saved check errors"
          render 'new'
        end
      else
        flash[:notice]    = "You have Enter Incorrect Domain"
        render 'new'
      end
    else
      flash[:notice]      = "Please Fill these fileds"
      redirect_to new_news_letter_path
    end
  end

  def change_language
    session[:locale] = params[:locale]
    respond_to do
      format.js { render js: "window.location = '#{request.referrer}'"}
    end
  end
end
