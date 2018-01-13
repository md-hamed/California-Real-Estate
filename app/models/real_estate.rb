class RealEstate < ApplicationRecord
  enum building_type: [:unkown, :residential, :condo, :multi_family]
end
