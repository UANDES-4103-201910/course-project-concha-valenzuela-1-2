class Geo < ApplicationRecord
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: ->(obj){ obj.address.present? }

  private

  def address_changed?
    address.present? && address_changed?
  end
end
