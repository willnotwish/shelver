# frozen_string_literal: true

# Tailwind helper module for links
module LinkTo
  extend ActiveSupport::Concern

  def link_to(name = nil, options = nil, html_options = {}, &)
    html_class = html_options[:class] || 'text-orange-500 hover:underline'
    helpers.link_to(name, options, html_options.merge(class: html_class), &)
  end
end
