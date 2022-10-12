module NotificationsHelper

  def notification_form(notification)
	  @visiter = notification.visiter
	  @comment = nil
	  your_post = link_to 'あなたの投稿', public_post_path(notification), style:'font-weight: bold;'
	  @visiter_comment = notification.comment_id
	  case notification.action
	    when 'favorite' then
	      tag.a(notification.visiter.name, href:public_user_path(@visiter), style:'font-weight: bold;')+'が'+tag.a('あなたのコメント', style:'font-weight: bold;')+'にいいねしました'
	    when 'comment' then
	    	@comment = Comment.find_by(id: @visiter_comment)&.comment_body
	    	tag.a(@visiter.name, href:public_user_path(@visiter), style:'font-weight: bold;')+'が'+tag.a('あなたの投稿', style:'font-weight: bold;')+'にコメントしました'
	  end
	end
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
