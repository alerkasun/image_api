require 'spec_helper'
require 'rails_helper'

describe Gallery do
  before { @gallery = FactoryGirl.build(:gallery) }
  subject { @gallery }
end
