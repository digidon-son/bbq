class EventMailer < ApplicationMailer
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: default_i18n_subject(event_name: @event.title)
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event
    mail to: email, subject: default_i18n_subject(commenter: comment.user_name)
  end

  def photo(photo, email)
    @photo = photo
    @email = email
    mail to: email, subject: default_i18n_subject(event_name: photo.event.title)
  end
end
