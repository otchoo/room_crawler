class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["BASIC_AUTHEN_USERNAME"], password: ENV["BASIC_AUTHEN_PASSWORD"]

  protect_from_forgery with: :exception

  include ApplicationHelper
end
