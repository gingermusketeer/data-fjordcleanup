class Cleanup < ApplicationRecord
  belongs_to :hosted_at, class_name: "Location"
  has_and_belongs_to_many :locations

  validates :occurred_at, :weight, :locations, presence: true
  validate :hosted_at_is_event

  def hosted_at_is_event
    return if hosted_at.nil? || hosted_at.kind == "event"
    errors.add(:hosted_at, "can only be an event location")
  end
end
