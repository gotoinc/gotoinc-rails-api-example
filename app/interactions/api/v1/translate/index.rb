class Api::V1::Translate::Index < BaseInteraction
  require "google/cloud/translate/v2"

  string :from_language, default: nil
  string :to_language
  string :content

  def execute
    InteractionResult.new(
      { text: translated_content }
    )
  end

  private

  def translated_content
    details = {to: to_language}
    details[:from] = from_language if from_language.present?

    translation = translator.translate(content, details)
    translation.text
  end

  def translator
    @_translator = Google::Cloud::Translate::V2.new(
      key: ENV['GOOGLE_CLOUD_TRANSLATIONS_API_KEY']
    )
  end
end
