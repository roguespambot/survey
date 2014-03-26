require 'spec_helper'

describe Question do
  it { should have_one :survey }
end
