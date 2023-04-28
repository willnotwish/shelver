# frozen_string_literal: true

class PageTitleComponent < ViewComponent::Base
  attr_reader :page_title, :subtitle

  def initialize(page_title:, subtitle: nil)
    @page_title = page_title
    @subtitle = subtitle
  end

  def subtitle?
    subtitle.present?
  end
end
