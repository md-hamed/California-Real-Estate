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
                                                         .is_less_than_or_equal_to(90)
                                                         .allow_nil }
  it { is_expected.to validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180)
                                                          .is_less_than_or_equal_to(180)
                                                          .allow_nil }
  it { is_expected.to validate_numericality_of(:beds).is_greater_than_or_equal_to(0)
                                                      .allow_nil
                                                      .only_integer }
  it { is_expected.to validate_numericality_of(:baths).is_greater_than_or_equal_to(0)
                                                      .allow_nil
                                                      .only_integer }
  it { is_expected.to validate_numericality_of(:sq_ft).is_greater_than_or_equal_to(0)
                                                      .only_integer }

  describe '.type' do
    before(:each) do
      @residential_real_estate = create(:real_estate, type: :residential)
      @condo_real_estate = create(:real_estate, type: :condo)
      @unknown_real_estate = create(:real_estate, type: :unknown)
    end

    context 'when type passed is valid' do
      it 'returns real estates with the provided type' do
        expect(RealEstate.type('residential')).to eq [@residential_real_estate]
      end
    end

    context 'when type passed is not valid' do
      it 'does not return any real estate' do
        expect(RealEstate.type('foobar')).to eq []
      end
    end
  end

  describe '.min_price' do
    before(:each) do
      @cheap_real_estates = create_list(:real_estate, 2, price: rand(10..1000))
      @expensive_real_estates = create_list(:real_estate, 2, price: rand(10_000..1_000_000))
    end

    it 'returns real estates with min price provided' do
      expect(RealEstate.min_price(10_000)).to eq @expensive_real_estates
    end
  end

  describe '.max_price' do
    before(:each) do
      @cheap_real_estates = create_list(:real_estate, 2, price: rand(10..1000))
      @expensive_real_estates = create_list(:real_estate, 2, price: rand(10_000..1_000_000))
    end

    it 'returns real estates with min price provided' do
      expect(RealEstate.max_price(1000)).to eq @cheap_real_estates
    end
  end

  describe '.min_sq_ft' do
    before(:each) do
      @wide_real_estates = create_list(:real_estate, 2, sq_ft: rand(5000..10_1000))
      @narrow_real_estates = create_list(:real_estate, 2, sq_ft: rand(10..1000))
    end

    it 'returns real estates with min sq_ft provided' do
      expect(RealEstate.min_sq_ft(5000)).to eq @wide_real_estates
    end
  end

  describe '.max_sq_ft' do
    before(:each) do
      @wide_real_estates = create_list(:real_estate, 2, sq_ft: rand(5000..10_1000))
      @narrow_real_estates = create_list(:real_estate, 2, sq_ft: rand(10..1000))
    end
    
    it 'returns real estates with min sq_ft provided' do
      expect(RealEstate.max_sq_ft(1000)).to eq @narrow_real_estates
    end
  end
end
