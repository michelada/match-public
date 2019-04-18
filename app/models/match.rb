# == Schema Information
#
# Table name: matches
#
#  id         :bigint(8)        not null, primary key
#  match_type :integer
#  version    :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ApplicationRecord
  enum match_type: %i[Content Project]

  has_many :activities, dependent: :delete_all
  has_many :projects, dependent: :delete_all

  has_many :teams, dependent: :delete_all

  validates :match_type, :start_date, :end_date, presence: true
  validate :dates_match?, :no_overlaps?

  def dates_match?
    errors.add(:end_date, I18n.t('errors.end_date_invalid')) if start_date > end_date
  end

  def no_overlaps?
    dates = Match.all.select(:id, :start_date, :end_date)
    dates.each do |d|
      next unless (start_date..end_date).overlaps?(d.start_date..d.end_date) && d.id != id

      errors.add(:start_date, format(I18n.t('errors.overlapped_dates'), match_id: d.id, start_date: d.start_date, end_date: d.end_date))
    end
  end
end
