require 'rails_helper'

RSpec.describe RealEstate, type: :model do
  # validation specs
  it { is_expected.to validate_presence_of :street }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :zip }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_presence_of :sq_ft }
  it { is_expected.to validate_presence_of :building_type }
  it { is_expected.to validate_presence_of :price }

  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90)
                                                         .is_less_than_or_equal_to(90) }
  it { is_expected.to validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180)
                                                          .is_less_than_or_equal_to(180) }
end
