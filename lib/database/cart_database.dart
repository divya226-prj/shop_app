import 'package:shop_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class CartFields {
  static const List<String> values = [
    id,
    title,
    slug,
    price,
    isFavorite,
    creationAt,
    description,
    content,
    image,
    quantity,
    category,
    updatedAt,
  ];
  static const List<String> valuesForFav = [
    id,
    title,
    slug,
    price,
    isFavorite,
    creationAt,
    description,
    content,
    image,
    quantity,
    category,
    updatedAt,
  ];

  static const String tableName = 'Cart';
  static const String tableNameForFav = 'Fav';

  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT';
  static const String intType = 'INTEGER';

  static const String id = 'id';
  static const String title = 'title';
  static const String slug = 'slug';
  static const String price = 'price';
  static const String isFavorite = 'isFavorite';
  static const String creationAt = 'creationAt';
  static const String description = 'description';
  static const String content = 'content';
  static const String image = 'images';
  static const String quantity = 'quantity';
  static const String category = 'category';
  static const String updatedAt = 'updatedAt';
}

class ShopAppDatabase {
  static final ShopAppDatabase instance = ShopAppDatabase._internal();
  static Database? _database;
  ShopAppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initialDatabase();
    return _database!;
  }

  Future<Database> _initialDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/cart.db';

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDatabase,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE ${CartFields.tableName} ADD COLUMN ${CartFields.isFavorite} INTEGER NOT NULL DEFAULT 0',
          );
          await db.execute(
            'ALTER TABLE ${CartFields.tableName} ADD COLUMN ${CartFields.quantity} INTEGER NOT NULL DEFAULT 0',
          );
        }
        if (oldVersion < 3) {
          await db.execute(
            'ALTER TABLE ${CartFields.tableName} ADD COLUMN ${CartFields.content} TEXT DEFAULT ""',
          );

          await db.execute(
            'ALTER TABLE ${CartFields.tableName} ADD COLUMN ${CartFields.description} TEXT DEFAULT ""',
          );
          await db.execute(
            'ALTER TABLE ${CartFields.tableName} ADD COLUMN ${CartFields.category} TEXT DEFAULT ""',
          );
          await db.execute(
            'ALTER TABLE ${CartFields.tableName} ADD COLUMN ${CartFields.updatedAt} TEXT DEFAULT ""',
          );
        }
      },
    );
  }
}

Future<void> _createDatabase(Database db, _) async {
  await db.execute('''
    CREATE TABLE ${CartFields.tableName} (
      ${CartFields.id} ${CartFields.idType},
      ${CartFields.title} ${CartFields.textType},
      ${CartFields.slug} ${CartFields.textType},
      ${CartFields.price} ${CartFields.intType},
      ${CartFields.isFavorite} ${CartFields.intType},
     
      ${CartFields.creationAt} ${CartFields.textType},
      ${CartFields.description} ${CartFields.textType},
      ${CartFields.content} ${CartFields.textType},
      ${CartFields.image} ${CartFields.textType},
      ${CartFields.quantity} ${CartFields.intType},
      ${CartFields.category} ${CartFields.textType},
      ${CartFields.updatedAt} ${CartFields.textType}
      
    )
  ''');

  await db.execute('''
    CREATE TABLE ${CartFields.tableNameForFav} (
      ${CartFields.id} ${CartFields.idType},
      ${CartFields.title} ${CartFields.textType},
      ${CartFields.slug} ${CartFields.textType},
      ${CartFields.price} ${CartFields.intType},
      ${CartFields.isFavorite} ${CartFields.intType},
      ${CartFields.creationAt} ${CartFields.textType},
      ${CartFields.description} ${CartFields.textType},
      ${CartFields.content} ${CartFields.textType},
      ${CartFields.image} ${CartFields.textType},
      ${CartFields.quantity} ${CartFields.intType},
      ${CartFields.category} ${CartFields.textType},
      ${CartFields.updatedAt} ${CartFields.textType}
      
    )
  ''');
}

Future<Product> add(Product product) async {
  final db = await ShopAppDatabase.instance.database;
  final data = product.sqltoJson();
  // data.remove('id');
  // data.remove('isFavorite');
  final id = await db.insert(
    CartFields.tableName,
    data,
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
  return product.copy(id: id);
}

Future<Product> addForFav(Product product) async {
  final db = await ShopAppDatabase.instance.database;
  final data = product.sqltoJson();

  final id = await db.insert(
    CartFields.tableNameForFav,
    data,
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
  return product.copy(id: id);
}

Future<Product> read(int id) async {
  final db = await ShopAppDatabase.instance.database;
  final maps = await db.query(
    CartFields.tableName,

    columns: CartFields.values,
    where: '${CartFields.id}=?',
    whereArgs: [id],
  );
  if (maps.isNotEmpty) {
    return Product.sqlfromJson(maps.first);
  } else {
    throw Exception('ID $id not found');
  }
}

Future<Product> readForFav(int id) async {
  final db = await ShopAppDatabase.instance.database;
  final maps = await db.query(
    CartFields.tableNameForFav,

    columns: CartFields.values,
    where: '${CartFields.id}=?',
    whereArgs: [id],
  );
  if (maps.isNotEmpty) {
    return Product.sqlfromJson(maps.first);
  } else {
    throw Exception('ID $id not found');
  }
}

Future<List<Product>> readAll() async {
  final db = await ShopAppDatabase.instance.database;
  const orderBy = '${CartFields.creationAt} DESC';
  final result = await db.query(CartFields.tableName, orderBy: orderBy);
  return result.map((json) => Product.sqlfromJson(json)).toList();
}

Future<List<Product>> readAllForFav() async {
  final db = await ShopAppDatabase.instance.database;
  const orderBy = '${CartFields.creationAt} DESC';
  final result = await db.query(CartFields.tableNameForFav, orderBy: orderBy);
  return result.map((json) => Product.sqlfromJson(json)).toList();
}

Future<int> update(Product product) async {
  final db = await ShopAppDatabase.instance.database;
  return db.update(
    CartFields.tableName,
    product.sqltoJson(),
    where: '${CartFields.id} = ?',
    whereArgs: [product.id],
  );
}

Future<int> updateProducts(Product product) async {
  final db = await ShopAppDatabase.instance.database;
  return db.update(
    CartFields.tableName,
    product.sqltoJson(),
    where: '${CartFields.id} = ?',
    whereArgs: [product.id],
  );
}

Future<int> updateForFav(Product product) async {
  final db = await ShopAppDatabase.instance.database;
  return db.update(
    CartFields.tableNameForFav,
    product.sqltoJson(),
    where: '${CartFields.id} = ?',
    whereArgs: [product.id],
  );
}

Future<int> delete(int id) async {
  final db = await ShopAppDatabase.instance.database;
  return await db.delete(
    CartFields.tableName,

    where: '${CartFields.id} = ?',
    whereArgs: [id],
  );
}

Future<int> deleteForFav(int id) async {
  final db = await ShopAppDatabase.instance.database;
  return await db.delete(
    CartFields.tableNameForFav,

    where: '${CartFields.id} = ?',
    whereArgs: [id],
  );
}

Future close() async {
  final db = await ShopAppDatabase.instance.database;
  db.close();
}

Future closeForFav() async {
  final db = await ShopAppDatabase.instance.database;
  db.close();
}
