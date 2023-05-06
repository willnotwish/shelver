# frozen_string_literal: true

# Adds geometry helpers
module HasScaling
  extend ActiveSupport::Concern

  included do
    before_action :set_scale, only: %i[show index]
    helper_method :default_scale
  end

  NO_SCALING = 1

  def default_scale
    @scale || NO_SCALING
  end

  def set_scale
    @scale = params[:scale].to_f if params[:scale].present?
  end
end
