require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'test' do
    it 'should return 1 if given 1' do
      output = User.new
      result = output.test('1')
      expect(result).to eq('1')
    end
  end 

  describe 'test' do
    it 'should return https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball 
    if given https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball' do
      output = User.new
      result = output.test('https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball')
      expect(result).to eq('https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball')
    end
  end 
end
