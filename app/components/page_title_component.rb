# frozen_string_literal: true

class PageTitleComponent < ViewComponent::Base
  attr_reader :page_title

  def initialize(page_title:)
    @page_title = page_title
  end
end
