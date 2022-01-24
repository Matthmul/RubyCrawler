require_relative "../allegro"

describe Allegro do
  before :all do
    @product = Allegro.new "http://www.amazon.com/gp/product/0465050654"
  end

  it "should raise an exception if URL is not valid" do
    expect{ Allegro.new("error") }.to raise_error(ArgumentError)
  end

  describe "#title" do
    it "returns titles" do
      expect(@product.title).to eq "The Design of Everyday Things: Revised and Expanded Edition"
    end
  end

  it "returns prices" do
    expect(@product.price.to_s).to eq "{\"Kindle\"=>\"$9.99\", \"Paperback\"=>\"$11.37\"}"
  end
end