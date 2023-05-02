require 'rails_helper'

module Geometry
  RSpec.describe CornerUnit, type: :model do
    subject { described_class.new(unit:) }

    let(:thickness) { 20 }
    let(:sheet) { FactoryBot.create(:sheet, thickness:) }
    let(:geometry) { subject } # alias

    context 'when the source (corner) unit has a height of 300, a width of 400 and a depth of 280' do
      let(:width) { 400 }
      let(:height) { 300 }
      let(:depth) { 280 }
      let(:shelf_count) { 2 }
      let(:offset_top) { 20 }
      let(:offset_bottom) { 0 }

      let(:unit) do
        FactoryBot.create(:unit, sheet:, width:, height:, depth:,
                          shelf_count:, offset_top:, offset_bottom:)
      end

      describe 'basic dimensions' do
        it 'has the correct width' do
          expect(geometry.unit_width).to eq(width)
        end

        it 'has the correct height' do
          expect(geometry.unit_height).to eq(height)
        end

        it 'is square (that is, width == depth)' do
          expect(geometry.unit_depth).to eq(width)
        end

        it 'has the correct sheet thickness' do
          expect(geometry.sheet_thickness).to eq(sheet.thickness)
        end

        it 'has the correct opening' do
          x = width - thickness - depth
          expected_opening = Math.sqrt(2.0 * x * x)
          expect(geometry.opening).to eq(expected_opening)
        end
      end

      describe 'shelves' do
        it 'has the correct shelf count' do
          expect(geometry.shelf_count).to eq(unit.shelf_count)
        end

        it 'has the correct uniform shelf spacing' do
          spacing = height - offset_top - offset_bottom - thickness
          spacing = spacing / shelf_count

          expect(geometry.uniform_shelf_spacing).to eq(spacing)
        end

        it 'equals the height calculated from the uniform shelf spacing' do
          accumulated_height = 0
          accumulated_height += offset_bottom
          accumulated_height += shelf_count * geometry.uniform_shelf_spacing
          accumulated_height += thickness
          accumulated_height += offset_top
          expect(accumulated_height).to eq(height)
        end

        it 'have the correct depth' do
          expect(geometry.shelf_depth).to eq(width - thickness)
        end

        it 'have the correct width' do
          expect(geometry.shelf_depth).to eq(width - thickness)
        end

        it 'have an opening equal to the width' do
          x = width - thickness - depth
          expected_opening = Math.sqrt(2.0 * x * x)
          expect(geometry.shelf_opening).to eq(expected_opening)
        end

        it 'have the expected usable area' do
          w = width - thickness
          area = w * w
          x = w - depth
          expect(geometry.usable_shelf_area).to eq(area - 0.5 * x * x )
        end
      end

      describe 'offsets' do
        it 'has the correct top offset' do
          expect(geometry.offset_top).to eq(unit.offset_top)
        end

        it 'has the correct bottom offset' do
          expect(geometry.offset_bottom).to eq(unit.offset_bottom)
        end
      end

      it 'has the correct sheet area' do
        w = width - thickness
        area = height * depth * 2 + (shelf_count + 1) * w * w
        expect(geometry.sheet_area).to eq(area)
      end

      describe 'panels' do
        it 'side panel has the correct dimensions' do
          expect(geometry.side_panel_dimensions).to match_array([depth, height])
        end

        it 'shelf panel has the correct dimensions' do
          w = width - thickness
          expect(geometry.shelf_panel_dimensions).to match_array([w, w])
        end

        it 'top panel has the correct dimensions' do
          w = width - thickness
          expect(geometry.shelf_panel_dimensions).to match_array([w, w])
        end

        it 'have the correct total area' do
          sides = height * depth * 2
          shelf = (width - thickness) * (width - thickness)
          top = shelf
          area = sides + shelf_count * shelf + top
          expect(geometry.panel_area).to eq(area)
        end
      end
    end
  end
end
