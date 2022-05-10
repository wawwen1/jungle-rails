require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save a valid product' do
      @category = Category.new(name: 'cats')
      @product = Product.new(name: 'meow', price: 100, quantity: 100, category: @category)
      expect(@product).to be_valid
    end

    it 'should be invalid without name' do
      @category = Category.new(name: 'cats')
      @product = Product.new(name: nil, price: 100, quantity: 100, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should be invalid without price' do
      @category = Category.new(name: 'cats')
      @product = Product.new(name: 'meow', price_cents: nil, quantity: 100, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should be invalid without quantity' do
      @category = Category.new(name: 'cats')
      @product = Product.new(name: 'meow', price: 100, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should be invalid without category' do
      @category = Category.new(name: 'cats')
      @product = Product.new(name: 'meow', price: 100, quantity: 100, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end

end
