class ApplicationController < ActionController::Base
  before_action :authenticate_access!

  def authenticate_access!
    return if Rails.env.development?
    return if session[:logged_in]

    raise ActiveRecord::RecordNotFound
  end
end
