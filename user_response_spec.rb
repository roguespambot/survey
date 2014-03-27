require 'spec_helper'

describe UserResponse do
  it { should have_one :question_response}
end
