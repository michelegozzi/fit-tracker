# == Schema Information
#
# Table name: sheets
#
#  id              :integer          not null, primary key
#  calories_target :integer
#  date            :datetime
#  week_num        :integer
#  day             :integer
#  water_glasses   :integer
#  sleep_hours     :integer
#  notes           :string(255)
#  goals_met       :boolean
#  energy_level    :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Sheet < ActiveRecord::Base
  attr_accessible :calories_target, :date, :day, :energy_level, :goals_met, :notes, :sleep_hours, :water_glasses, :week_num

  has_many :meals, :dependent => :destroy

  belongs_to :user
end
