class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;
}

class Product {
  int id;
  String title;
  String imageUrl;
  int price;
  int discount;
  int previousPrice;

  Product.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      imageUrl = json['image'],
      price = json['price'],
      discount = json['discount'],
      previousPrice = json['previous_price'] ?? json['pric'];
}
