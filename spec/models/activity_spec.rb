# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  time       :datetime
#  duration   :integer
#  intensity  :integer
#  sheet_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#

require 'spec_helper'

describe Activity do
  pending "add some examples to (or delete) #{__FILE__}"
end
