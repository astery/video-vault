# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def video_from_past
    UserMailer.video_from_past(Video.first)
  end
end
