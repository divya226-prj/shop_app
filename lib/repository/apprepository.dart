import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/model/product_model.dart';

class Apprepository {
  Future<List<Product>> fetchproducts() async {
    List<Product> products = [
      Product(
        name: "Black winter",
        id: 1,
        price: 499,
        description: "Autumn And Winter Casual cotton-padded jacket...",
        image: AppImage.blackwinter,
      ),
      Product(
        name: "Mens Starry",
        id: 2,
        price: 399,
        description: "Mens Starry Sky Printed Shirt 100% Cotton Fabric",
        image: AppImage.mensstarry,
      ),
      Product(
        name: "Black Dress",
        id: 3,
        price: 2000,
        description: "Solid Black Dress for Women, Sexy Chain Shorts Ladi...",
        image: AppImage.blackdress,
      ),
      Product(
        name: "Denim Dress",
        id: 4,
        price: 999,
        description: "Blue cotton denim dress Look 2 Printed cotton dr...",
        image: AppImage.denimdress,
      ),
    ];

    return products;
  }
}
