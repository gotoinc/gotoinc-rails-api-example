class Api::V1::BaseController < ActionController::API
  respond_to :json

  rescue_from Exception do |e|
    if e.is_a?(InteractionErrors::InteractionArgumentError)
      Rails.logger.error "ERROR: #{e.errors.messages}"
      render json: { error: e.first_error}, status: :unprocessable_entity
    else
      Rails.logger.error "EXCEPTION: #{e}, PARAMS: #{params.inspect}, BACKTRACE: #{e.backtrace.join("\n")}"
      if Rails.env.production?
        render text: e.message, status: 500
      else
        render json: {error: e.message, backtrace: e.backtrace[0..20].join("\n")}, status: 500
      end
    end
  end

  def run_interaction(klass)
    # a = params.permit(*klass.filters.keys).to_h.deep_symbolize_keys
    #           .slice(*klass.filters.keys).merge(args)
    Rails.logger.info "Interaction: '#{klass}', args: #{params}"
    int = klass.run params
    status = int.valid?
    Rails.logger.debug "Interaction: '#{klass}', valid? #{status}"
    {
      true => lambda {
        if request.post? || request.put?
          if int.result.present?
            render(json: int.result)
          else
            request.put? ? head(:no_content) : head(:ok)
          end
        else
          respond_with int.result
        end
      },
      false => lambda {
        Rails.logger.debug "Errors: #{int.errors.messages}"
        if request.post?
          render json: int.errors.messages, status: :unprocessable_entity
        else
          respond_with int.errors.messages, status: :unprocessable_entity
        end
      }
    }[!!status].call
  end

  def initialize_interactions(path, method_names)
    method_names.each do |name|
      self.class.send(:define_method, name) do
        run_interaction "#{path}::#{name.capitalize}".constantize
      end
    end
  end
end
