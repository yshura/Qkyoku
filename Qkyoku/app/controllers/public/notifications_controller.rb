class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
  		notification.update_attribute(checked: true)
    end
  end
  
  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
  	redirect_to users_notifications_path
  end
end
