class Api::V1::Certificates::Show < AuthenticatedInteraction
  def execute

    InteractionResult.new(
      {expire_at: date}
    )
  end

  private

  def date
   _date =  %x(  openssl x509 -enddate -noout -in #{File.expand_path File.dirname(__FILE__)}/.certs/cert.pem  )
   _date.split('=')[1]
  end
end