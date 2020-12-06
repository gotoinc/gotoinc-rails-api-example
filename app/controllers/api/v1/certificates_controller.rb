class Api::V1::CertificatesController < Api::V1::AuthorizedController
  def initialize
    initialize_interactions('Api::V1::Certificates', %w[show update])
  end
end