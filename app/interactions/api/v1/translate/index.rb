class Api::V1::Translate::Index < BaseInteraction
  string :from_language, default: nil
  string :to_language
  string :content

  def execute
    translate_service = TranslationsService.new(content, to_language, from_language)

    InteractionResult.new(
      { text: translate_service.call }
    )
  end
end
