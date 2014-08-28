# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :user_id, :start_date, :end_date, presence: true
  validate :cat_is_available
  after_initialize :set_status
  
  def cat_is_available
    unless overlapping_approved_requests.empty?
      errors[:Schedule] = "has conflicts"
    end
  end
  
  def approve!
    self.class.transaction do
      self.status = "APPROVED"
      save
      overlapping_requests.where(status: 'PENDING').each do |request|
        request.deny!
      end
    end
  end
  
  def deny!
    self.status = "DENIED"
    save
  end
  
  def set_status
    self.status ||= "PENDING"
  end
  
  def overlapping_requests
    CatRentalRequest
      .where(cat_id: self.cat_id)
      .where("(start_date < :self_end_date) AND (end_date > :self_start_date)",
        self_start_date: self.start_date, 
        self_end_date: self.end_date)
      .where.not(id: self.id)
  end
  
  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end
  
  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

end