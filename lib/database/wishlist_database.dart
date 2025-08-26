import 'package:shop_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class WishlistFields {
  static const String tableName = 'Wishlist';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String title = 'title';
  static const String number = 'number';
  static const String content = 'content';
  static const String isFavourite = 'is_favorite';
  static const String createdTime = 'createdTime';
}

class WishlistDatabase {
  static final WishlistDatabase instance = WishlistDatabase._internal();

  static Database? _database;
  WishlistDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialdatabse();
    return _database!;
  }

  Future<Database> _initialdatabse() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/wishlist.db';
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }
}

Future<void> _createDatabase(Database db, _) async {
  return await db.execute('''
        CREATE TABLE ${WishlistFields.tableName} (
          ${WishlistFields.id} ${WishlistFields.idType},
          ${WishlistFields.number} ${WishlistFields.intType},
          ${WishlistFields.title} ${WishlistFields.textType},
          ${WishlistFields.content} ${WishlistFields.textType},
          ${WishlistFields.isFavourite} ${WishlistFields.intType},
          ${WishlistFields.createdTime} ${WishlistFields.textType},
        )
      ''');
}

// Future<Product> create(Product product) async {
//   final db = await instance.database;
//   final id = await db.insert(WishlistFields.tableName, product.toJson());
//   return product.copy(id: id);
// }
