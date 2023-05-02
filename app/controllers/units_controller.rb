# frozen_string_literal: true

# RESTful Unit actions
class UnitsController < ApplicationController
  before_action :set_unit, only: %i[show edit update destroy]

  def index
    @units = Unit.all
  end

  def show
    @kind = params[:kind] if params[:kind].present? # kind is an optional override
  end

  # If a source is given, it is used as a base (or "template")
  def new
    @unit = Unit.new(unit_params)
  end

  # GET /units/1/edit
  def edit; end

  # POST /units or /units.json
  def create
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to unit_url(@unit), notice: 'Unit successfully created.' }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1 or /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to unit_url(@unit), notice: 'Unit successfully updated.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1 or /units/1.json
  def destroy
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to units_url, notice: 'Unit successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_unit
    @unit = Unit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def unit_params
    raw_params = params.fetch(:unit) do
      if params[:source_id].present?
        duplicate_unit_attributes(Unit.find(params[:source_id]).attributes)
      else
        {}
      end
    end

    raw_params.permit(:sheet_id, :name, :code, :kind, :width, :height, :offset_top, :offset_bottom, :depth, :shelf_count)
  end

  def duplicate_unit_attributes(attrs)
    attrs.except('id', 'created_at', 'updated_at').tap do |attrs|
      attrs['name'] = "#{attrs['name']} (duplicate)"
      attrs['code'] = "#{attrs['code']} (duplicate)"
    end
  end
end
