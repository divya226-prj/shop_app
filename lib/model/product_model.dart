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
  );

  Product.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int;
      title = json['title'];
      slug = json['slug'];

      price = json['price'] as int;
      description = json['description'];
      category = json['category'] != null
          ? new Category.fromJson(json['category'])
          : null;
      images = json['images'].cast<String>();
      creationAt = json['creationAt'];
      updatedAt = json['updatedAt'];
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['description'] = this.description;
    'category';
    category != null ? jsonEncode(category!.toJson()) : null;
    'images';
    images != null ? jsonEncode(images) : null;
    data['creationAt'] = this.creationAt;
    data['updatedAt'] = this.updatedAt;
    'isFavorite';
    isFavorite == true ? 1 : 0;
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
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      slug: map['slug'],
      price: map['price'],
      description: map['description'],
      category: Category(id: map['category_id'], name: map['category_name']),
      images: map['images'] != null ? map['images'].split(',') : [],
      creationAt: map['creationAt'],
      updatedAt: map['updatedAt'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  static where(bool Function(dynamic Product) param0) {}
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['creationAt'] = this.creationAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
