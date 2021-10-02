class ApplicationController < ActionController::Base
  unless Rails.env.development?
    before_action :authenticate_access!
  end

  def authenticate_access!
    return if session[:logged_in]

    raise ActiveRecord::RecordNotFound
  end
end
