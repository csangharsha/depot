require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(image_url)
    Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: image_url)
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg")

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?

    product.price = 0.01
  end

  test "image_url" do
    ok = %w[fred.gif fred.jpg FRED.JPG fred.png FRED.Jpg http://a.b.c/x/y/z/fred.gif]
    bad = %w[fred.doc fred.gif/more fred.gif.more]

    ok.each do |img_url|
      assert new_product(img_url).valid?, "#{img_url} is valid."
    end

    bad.each do |img_url|
      assert new_product(img_url).invalid?, "${img_url} is invalid."
    end
  end

  test "product is not valid without the unique title" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 9.99, image_url: "lorem.jpg")
    assert product.invalid?
    assert_equal [I18n.translate("errors.messages.taken")], product.errors[:title]
  end
end
