class RealEstate < ApplicationRecord
  include Filterable

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

  # pagination
  paginates_per 10

  # scopes
  scope :type, -> (type) { building_types.keys.include?(type.downcase) ? where(type: type.downcase) : RealEstate.none }
  # define range scopes dynamically for price and sq_ft
  # this defines: min_price and min_sq_ft
  # and           max_price and max_sq_ft
  [:price, :sq_ft].each do |range_searchable|
    scope "min_#{range_searchable}", -> (min_value) do
      where("#{range_searchable} >= ?", min_value)
    end

    scope "max_#{range_searchable}", -> (max_value) do
      where("#{range_searchable} <= ?", max_value)
    end
  end
end
