class ApplicationController < ActionController::Base
  before_action :store_history

  private

  def store_history
    return unless request.get?
    return if request.xhr?

    session[:history] ||= []
    session[:history].delete_at(0) if session[:history].size >= 10
    session[:history] << request.url unless session[:history].include? request.url
  end
end
