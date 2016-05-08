require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'test' do
    it 'should return 1 if given 1' do
      output = User.new
      result = output.test
      expect(result).to eq(1)
    end
  end 
end
