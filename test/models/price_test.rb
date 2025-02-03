require "test_helper"

class PriceTest < ActiveSupport::TestCase
  test "deve criar um preço válido" do
    price = PriceSql.new(
      product_name: "Produto Teste",
      price: 100.50,
      country: "BR",
      shop_name: "Loja Teste"
    )

    assert price.save, "Erro ao salvar um preço válido"
  end

  test "não deve salvar preço sem product_name" do
    price = PriceSql.new(price: 100.50, country: "BR", shop_name: "Loja Teste")

    assert_not price.save, "Salvou um preço sem product_name"
  end
end
