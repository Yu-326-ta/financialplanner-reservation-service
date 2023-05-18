class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :planner

  validates :day, presence: true
  validates :time, presence: true
  validates :start_time, presence: true, uniqueness: true

  validate :date_before_start
  validate :date_current_today
  validate :date_three_month_end

  scope :post_reservations, -> { where(day: Date.current...Date.current.since(3.months)).order(day: :desc) }

  def date_before_start
    errors.add(:day, 'は過去の日付は選択できません。予約画面から正しい日付を選択してください。') if day < Date.current
  end

  def date_current_today
    errors.add(:day, 'は当日は選択できません。予約画面から正しい日付を選択してください。') if day < (Date.current + 1)
  end

  def date_three_month_end
    errors.add(:day, 'は3ヶ月以降の日付は選択できません。予約画面から正しい日付を選択してください。') if (Date.current >> 3) < day
  end

  def self.check_reservation_day(day)
    if day < Date.current
      '過去の日付は選択できません。正しい日付を選択してください。'
    elsif day < (Date.current + 1)
      '当日は選択できません。正しい日付を選択してください。'
    elsif (Date.current >> 3) < day
      '3ヶ月以降の日付は選択できません。正しい日付を選択してください。'
    end
  end  
end
