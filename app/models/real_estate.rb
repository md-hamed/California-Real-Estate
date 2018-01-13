class RealEstate < ApplicationRecord
  # enums
  enum building_type: [:unknown, :residential, :condo, :multi_family]

  # validations
  validates :street, :city, :zip, :state, :sq_ft, :building_type,
            :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :latitude , numericality: { greater_than_or_equal_to: -90, 
                                        less_than_or_equal_to: 90,
                                        allow_nil: true }
  validates :longitude, numericality: { greater_than_or_equal_to: -180,
                                        less_than_or_equal_to: 180,
                                        allow_nil: true }
  validates :beds, :baths, numericality: { greater_than_or_equal_to: 0,
                                           only_integer: true,
                                           allow_nil: true }
  validates :sq_ft, numericality: { greater_than_or_equal_to: 0,
                                    only_integer: true }

  # aliases
  alias_attribute :type, :building_type
end
