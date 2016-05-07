require 'rspec'
require 'rails_helper'
require 'spec_helper'

class Test 
  def test
    1
  end
end

Rspec.describe Test :type => :model do
  describe '#test' do
    it 'should return 1 if given 1' do
      output = Test.new
      result = output.test
      expect(result).to eq(1)
    end
  end 
end

