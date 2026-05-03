class EmailSender
  def self.send_email(to:, subject:, html:)
    Resend::Emails.send({
      from: ENV["MAIL_FROM"] ,
      to: to,
      subject: subject,
      html: html
    })
  end
end
