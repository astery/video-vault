class UserMailer < ApplicationMailer
  def video_from_past(video)
    @video = video
    @user  = video.user

    unless @user.nil?
      mail to: @user.email, subject: 'Video from past'
    end
  end
end
