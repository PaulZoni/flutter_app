
class Product {

  String product_name;
  String coin_price;
  String price;
  String link;
  String image_link;
  String product_id;
  String store_name;
  String store_icon;

  Product({
    this.product_name,
    this.coin_price,
    this.price,
    this.link,
    this.image_link,
    this.product_id,
    this.store_name,
    this.store_icon
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_name: json["product_name"] as String,
      coin_price: json["coin_price"] as String,
      price: json["price"] as String,
      link: json["link"] as String,
      image_link: json["image_link"] as String,
      product_id: json["product_id"] as String,
      store_name: json["store_name"] as String,
      store_icon: json["store_icon"] as String
    );
  }
}