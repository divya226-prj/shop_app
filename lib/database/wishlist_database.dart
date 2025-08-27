import 'package:shop_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class WishlistFields {
  static const List<String> values = [
    id,
    number,
    title,
    content,
    isFavorite,
    createdTime,
    slug,
    price,
  ];
  static const String tableName = 'Wishlist';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = 'id';
  static const String title = 'title';
  static const String number = 'number';
  static const String content = 'content';
  static const String isFavorite = 'is_favorite';
  static const String createdTime = 'createdTime';
  static const String slug = 'slug';
  static const String price = 'price';
}

class ShopAppDatabase {
  static final ShopAppDatabase instance = ShopAppDatabase._internal();

  static Database? _database;
  ShopAppDatabase._internal();

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
    return await openDatabase(path, version: 2, onCreate: _createDatabase);
  }
}

Future<void> _createDatabase(Database db, _) async {
  return await db.execute('''
        CREATE TABLE ${WishlistFields.tableName} (
          ${WishlistFields.id} ${WishlistFields.idType},
          ${WishlistFields.number} ${WishlistFields.intType},
          ${WishlistFields.title} ${WishlistFields.textType},
          ${WishlistFields.slug} ${WishlistFields.textType},
          ${WishlistFields.content} ${WishlistFields.textType},
          price INTEGER,
          ${WishlistFields.isFavorite} ${WishlistFields.intType},
          ${WishlistFields.createdTime} ${WishlistFields.textType},
          updatedAt TEXT
          
        )
      ''');
}

Future<Product> add(Product product) async {
  final db = await ShopAppDatabase.instance.database;
  final data = product.toJson();
  data.remove('id');
  final id = await db.insert(WishlistFields.tableName, data);

  return product.copy(id: id);
}

Future<Product> read(int id) async {
  final db = await ShopAppDatabase.instance.database;
  final maps = await db.query(
    WishlistFields.tableName,
    columns: WishlistFields.values,
    where: '${WishlistFields.id}=?',
    whereArgs: [id],
  );
  if (maps.isNotEmpty) {
    return Product.fromJson(maps.first);
  } else {
    throw Exception('ID $id not found');
  }
}

Future<List<Product>> readAll() async {
  final db = await ShopAppDatabase.instance.database;
  const orderBy = '${WishlistFields.createdTime} DESC';
  final result = await db.query(WishlistFields.tableName, orderBy: orderBy);
  return result.map((json) => Product.fromJson(json)).toList();
}

Future<int> update(Product product) async {
  final db = await ShopAppDatabase.instance.database;
  return db.update(
    WishlistFields.tableName,
    product.toJson(),
    where: '${WishlistFields.id} = ?',
    whereArgs: [product.id],
  );
}

Future<int> delete(int id) async {
  final db = await ShopAppDatabase.instance.database;
  return await db.delete(
    WishlistFields.tableName,
    where: '${WishlistFields.id} = ?',
    whereArgs: [id],
  );
}

Future close() async {
  final db = await ShopAppDatabase.instance.database;
  db.close();
}
