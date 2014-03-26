require 'spec_helper'

describe UserResponse do
  it { should have_one :question }
  it { should have_one :response_selection }
end
