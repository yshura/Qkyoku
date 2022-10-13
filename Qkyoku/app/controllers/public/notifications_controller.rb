class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(2)
    @notifications.where(checked: false).each do |notification|
  		notification.update(checked: true)
    end
  end
  
  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
  	redirect_to public_notifications_path
  end
end
