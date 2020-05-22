ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper


  #ログインしていればtrue,それ以外はfalse
  def is_logged_in?
    !session[:user_id].nil?
  end

  #ログイン
  def log_in_as(user)
    session[:user_id] = user.id 
  end

end

class ActionDispatch::IntegrationTest

  def log_in_as(user, password: "password")
    post login_path, params: {session: {email: user.email,
                                        password: password}}
  end

end
