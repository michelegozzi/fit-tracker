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

require 'spec_helper'

describe Meal do
  pending "add some examples to (or delete) #{__FILE__}"
end
