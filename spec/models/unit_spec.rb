require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { subject } # alias

  describe 'validations' do
    %i[name code kind width height depth].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:sheet) }
    it { is_expected.to have_many(:composite_units) }
    it { is_expected.to have_many(:composites).through(:composite_units) }
  end

  describe 'type' do
    it { is_expected.to define_enum_for(:kind) }
    it { is_expected.to be_plain }
  end

  describe 'dimensions' do
    %i[width height depth].each do |dimension|
      it { is_expected.to validate_numericality_of(dimension).only_integer.is_greater_than(0)}
    end
  end

  describe 'shelves' do
    it { is_expected.to validate_numericality_of(:shelf_count).only_integer.is_greater_than(0)}
    
    it 'has a default shelf count of one' do
      expect(unit.shelf_count).to eq(1)
    end
  end

  describe 'offsets' do
    it { is_expected.to validate_numericality_of(:offset_top).only_integer.is_greater_than_or_equal_to(0)}
    it { is_expected.to validate_numericality_of(:offset_bottom).only_integer.is_greater_than_or_equal_to(0)}

    it 'top is zero by default' do
      expect(unit.offset_top).to eq(0)
    end

    it 'bottom is zero by default' do
      expect(unit.offset_bottom).to eq(0)
    end
  end
end
