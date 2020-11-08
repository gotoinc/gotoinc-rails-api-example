class TranslationsService
  require "google/cloud/translate/v2"

  attr_reader :content, :to_language, :from_language
  
  def initialize(content, to_language, from_language=nil)
    @content = content
    @to_language = to_language
    @from_language = from_language
  end

  def call
    translated_content
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