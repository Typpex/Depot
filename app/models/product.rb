class Product < ActiveRecord::Base
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  attr_accessible :description, :image_url, :price, :title
  validates :description, :image_url, :price, :title, :presence => true
  #validates :price, :numericality => {greater_than_or_equal_to: 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format =>
      {
          with: %r{\.(jpg|png|gif)$}i,
          message: 'must be a URL for GIF, PNG or JPG'
      }

  private

   def ensure_not_referenced_by_any_line_item
     if line_items.empty?
       true
     else
       errors.add(:base, "Line item present !")
       false
     end
   end
end