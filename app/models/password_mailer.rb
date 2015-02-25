class PasswordMailer < ActionMailer::Base
  
  def forgot_password(password)
    setup_email(password.user)
    @subject    += 'You have requested to change your password'
   # @body[:url]  = "http://www.notaryfly.com/change_password/#{password.reset_code}"
    @body[:url]  = "http://localhost:3000/change_password/#{password.reset_code}"
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset.'
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "noreply@notaryfly.com"
      @subject     = "NotaryFly "
      @sent_on     = Time.now
      @body[:user] = user
    end
end