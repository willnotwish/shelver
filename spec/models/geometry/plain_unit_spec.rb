require 'rails_helper'

module Geometry
  RSpec.describe PlainUnit, type: :model do
    subject { described_class.new(unit:) }

    let(:geometry) { subject } # alias

    context 'when the source (plain) unit has a height of 2m and a width of 50cm' do
      let(:width) { 500 }
      let(:height) { 2000 }
      let(:depth) { 280 }
      let(:shelf_count) { 4 }
      let(:offset_top) { 20 }
      let(:offset_bottom) { 80 }
      let(:thickness) { 20 }
      let(:sheet) { FactoryBot.create(:sheet, thickness:) }
  
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

        it 'has the correct depth' do
          expect(geometry.unit_depth).to eq(depth)
        end

        it 'has the correct sheet thickness' do
          expect(geometry.sheet_thickness).to eq(sheet.thickness)
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

        it 'have the same depth as the unit' do
          expect(geometry.shelf_depth).to eq(depth)
        end

        it 'have a width that is two thicknesses less than the unit width' do
          expect(geometry.shelf_width).to eq(width - 2 * thickness)
        end

        it 'have an opening equal to the width' do
          expect(geometry.shelf_opening).to eq(width - 2 * thickness)
        end

        it 'have the expected usable area' do
          area = depth * (width - 2 * thickness)
          expect(geometry.usable_shelf_area).to eq(area)
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

      describe 'panels' do
        it 'side panel has the correct dimensions' do
          expect(geometry.side_panel_dimensions).to match_array([depth, height])
        end

        it 'shelf panel has the correct dimensions' do
          expect(geometry.shelf_panel_dimensions).to match_array([width - 2 * thickness, depth])
        end

        it 'top panel has the correct dimensions' do
          expect(geometry.shelf_panel_dimensions).to match_array([width - 2 * thickness, depth])
        end

        it 'have the correct total area' do
          sides = height * depth * 2
          shelf = depth * (width - (2 * thickness))
          top = shelf
          area = sides + shelf_count * shelf + top
          expect(geometry.panel_area).to eq(area)
        end
      end
    end
  end
end
