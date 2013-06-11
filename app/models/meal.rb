# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  time       :datetime
#  calories   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  sheet_id   :integer
#

class Meal < ActiveRecord::Base
  attr_accessible :calories, :name, :time, :category

  belongs_to :sheet
end
