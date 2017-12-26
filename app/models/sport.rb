class Sport < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :sport_image, SportImageUploader

  has_many 	  :uniform_builders
  has_many 	  :colors
  has_many	  :styles
  has_many    :sport_categories
  validate    :validate_minimum_sport_image_size

  def validate_minimum_sport_image_size
    image = MiniMagick::Image.open(sport_image.path)
    unless image[:width] > 160 && image[:height] > 160
      errors.add :sport_image, error: "should be 160x160px minimum!"
    end
  end
end
