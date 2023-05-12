# frozen_string_literal: true

# Adds geometry helpers
module HasScaling
  extend ActiveSupport::Concern

  included do
    # before_action :set_scale, only: %i[show index]
    helper_method :default_scale
  end

  def default_scale
    @scale
  end

  # def set_scale
  #   params[:scale].tap do |value|
  #     @scale = value.to_f if value.to_i != 0
  #   end
  # end
end
