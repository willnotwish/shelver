# frozen_string_literal: true

class FlashNoticeComponent < ViewComponent::Base
  attr_reader :text

  def initialize(text:)
    @text = text
  end
end
