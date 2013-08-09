# == Schema Information
#
# Table name: sheets
#
#  id                      :integer          not null, primary key
#  calorie_target          :integer
#  date                    :datetime
#  week_num                :integer
#  day                     :integer
#  water_glasses           :integer
#  sleep_hours             :integer
#  notes                   :string(255)
#  goals_met               :boolean
#  energy_level            :integer
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  total_calories_consumed :integer
#

require 'spec_helper'

describe Sheet do
  pending "add some examples to (or delete) #{__FILE__}"
end
