import 'dart:convert';

class Product {
  int? id;
  String? title;
  String? slug;
  int? price;

  String? description;
  Category? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  bool? isFavorite;
  int? quantity;

  Product({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
    this.isFavorite,

    this.quantity,
  });

  Product copy({
    int? id,
    String? title,
    String? slug,
    int? price,
    String? description,
    Category? category,
    List<String>? images,
    String? creationAt,
    String? updatedAt,
    bool? isFavorite,
    int? quantity,
  }) => Product(
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    description: description ?? this.description,
    category: category ?? this.category,
    images: images ?? this.images,
    creationAt: creationAt ?? this.creationAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isFavorite: isFavorite ?? this.isFavorite,
    quantity: quantity ?? this.quantity,
  );

  Product.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      title = json['title'];
      slug = json['slug'];
      price = json['price'];
      description = json['description'];
      category = json['category'] != null
          ? Category.fromJson(json['category'])
          : null;
      images = json['images'] != null ? List<String>.from(json['images']) : [];
      creationAt = json['creationAt'];
      updatedAt = json['updatedAt'];
      quantity = json['quantity'] ?? 0;

      isFavorite = json['isFavorite'] == 1 || json['isFavorite'] == true;
    } catch (e) {
      print('Error parsing Product.fromJson: $e');
    }
  }

  Product.sqlfromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      title = json['title'];
      slug = json['slug'];
      price = json['price'];
      description = json['description'];
      category = json['category'] != null
          ? Category.fromJson(jsonDecode(json['category']))
          : null;
      images = json['images'] != null
          ? List<String>.from(jsonDecode(json['images']))
          : [];
      creationAt = json['creationAt'];
      updatedAt = json['updatedAt'];
      quantity = json['quantity'] ?? 0;

      isFavorite = json['isFavorite'] == 1 || json['isFavorite'] == true;
    } catch (e) {
      print('Error parsing Product.sqlfromJson: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['price'] = price;
    data['description'] = description;

    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (images != null) {
      data['images'] = images;
    }
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    data['isFavorite'] = isFavorite == true ? 1 : 0;
    data['quantity'] = quantity;

    return data;
  }

  Map<String, dynamic> sqltoJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['price'] = price;
    data['description'] = description;
    if (category != null) {
      data['category'] = jsonEncode(category!.toJson());
    }
    if (images != null) {
      data['images'] = jsonEncode(images);
    }
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    data['isFavorite'] = isFavorite == true ? 1 : 0;
    data['quantity'] = quantity;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'price': price,
      'description': description,
      'category_id': category?.id,
      'category_name': category?.name,
      'images': images != null ? images!.join(',') : null,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
      'isFavorite': isFavorite == true ? 1 : 0,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      slug: map['slug'],
      price: map['price'],
      description: map['description'],
      category: (map['category_id'] != null || map['category_name'] != null)
          ? Category(id: map['category_id'], name: map['category_name'])
          : null,
      images: map['images'] != null ? map['images'].split(',') : [],
      creationAt: map['creationAt'],
      updatedAt: map['updatedAt'],
      isFavorite: map['isFavorite'] == 1,
      quantity: map['quantity'] ?? 1,
    );
  }
}

// class Category {
//   int? id;
//   String? name;
//   String? slug;
//   String? image;
//   String? creationAt;
//   String? updatedAt;

//   Category({
//     this.id,
//     this.name,
//     this.slug,
//     this.image,
//     this.creationAt,
//     this.updatedAt,
//   });

//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     image = json['image'];
//     creationAt = json['creationAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['name'] = name;
//     data['slug'] = slug;
//     data['image'] = image;
//     data['creationAt'] = creationAt;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }
// }
class Category {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  bool isChecked;

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
    this.isChecked = false,
  });

  Category.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      slug = json['slug'],
      image = json['image'],
      creationAt = json['creationAt'],
      updatedAt = json['updatedAt'],
      isChecked = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;

    return data;
  }

  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    String? creationAt,
    String? updatedAt,
    bool? isChecked,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
