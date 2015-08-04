class Post < ActiveRecord::Base
  has_attached_file :image, :styles => { :large => "400x400>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :likes
end
