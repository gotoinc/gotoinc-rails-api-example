class Api::V1::AuthController < Api::V1::BaseController
  def initialize
    initialize_interactions("Api::V1::Auth", ["login", "register"])
  end
end