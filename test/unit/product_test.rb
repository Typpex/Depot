require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

   test "product attributes must not be empty" do
     product = Product.new
     assert product.invalid?
     assert product.errors[:title].any?
     assert product.errors[:image_url].any?
     assert product.errors[:price].any?
     assert product.errors[:description].any?
   end

  def new_product(image_url)
    p = Product.new(
        title: 'test',
        description: 'blablabla lorem ipsum',
        price: '1',
        image_url: image_url
    )
    p
  end

  test "image_url must finish with JPG / PGN or GIF" do
    ok = %w{test.jpg test.png test.gif lol.jpg lol.png oki_geriov1.GIF OK.PNG}
    nok = %w{test.ko test.ok test.giff lol.jpeg lol oki_geriov_1.dommage}
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
      end
      nok.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
      end
  end

  test "Product mus have unique title" do
    p = Product.new(
        title: products(:ruby).title,
        description: 'test',
        image_url: 'blabla.jpg',
        price: 50.01
    )

    assert !p.save
    assert p.errors[:title].any?
  end
  

end
