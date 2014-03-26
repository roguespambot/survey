require 'spec_helper'

describe Taker do
  it { should have_many :question_responses }
end
