# frozen_string_literal: true

# RESTful Composite actions
class CompositesController < ApplicationController
  include HasScaling

  def index
    scaling_factor_from_session
    @scale = @scaling_factor.value
    @composites = Composite.all
  end

  def show
    scaling_factor_from_session
    @scale = @scaling_factor.value
    @composite = Composite.find params[:id]
    @units = @composite.horizontal_units
  end

  def new; end

  def edit; end

  def destroy; end

  def edit_scaling_factor
    scaling_factor_from_session
    @scale = @scaling_factor.value
    @composite = Composite.find(params[:composite_id]) if params[:composite_id].present?
  end

  def update_scaling_factor
    @scaling_factor = ScalingFactor.new scaling_factor_params
    @scaling_factor.save_in_session(session)
    @scale = @scaling_factor.value

    # Figure out the context
    if params[:composite_id].present?
      @composite = Composite.find params[:composite_id]
      @units = @composite.horizontal_units
    else
      @composites = Composite.all
    end

    respond_to do |format|
      format.html do
        path = params[:redirect_to].present? ? params[:redirect_to] : root_path
        redirect_to path
      end
      format.turbo_stream
    end
  end

  private

  def scaling_factor_from_session
    return @scaling_factor if @scaling_factor

    @scaling_factor = ScalingFactor.from_session(session)
  end

  def scaling_factor_params
    params.fetch(:scaling_factor, {}).permit(:value)
  end
end
