class Poll < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :activities, through: :votes
  scope :enabled_polls, (lambda {
    where('start_date <= ? and end_date >= ?', Date.today, Date.today)
  })
  validates :start_date, :end_date, :activities_from, :activities_to, presence: true
  validate :valid_date_range
end

def valid_date_range
  if start_date < Date.today
    errors.add(:start_date, 'No puede estar en el pasado')
  end
  if end_date <= start_date
    errors.add(:start_date, 'La fecha final no puede ser menor a la fecha inicial')
  end

end
