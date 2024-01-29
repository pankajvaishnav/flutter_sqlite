import 'dart:convert';

class Product {
  final String season;
  final String brand;
  final String mood;
  final String gender;
  final String theme;
  final String category;
  final String name;
  final String color;
  final String option;
  final double mrp;
  final String subCategory;
  final String collection;
  final String fit;
  final String description;
  final String qrCode;
  final String looks;
  final String looksImageUrl;
  final String looksImage;
  final String fabric;
  final dynamic ean;
  final String finish;
  final List availableSizes;
  final dynamic availableSizesWithDeactivated;
  final dynamic sizeWiseStock;
  final dynamic sizeWiseStockPlant;
  final dynamic offerMonths;
  final int productClass;
  final int promoted;
  final int secondary;
  final int deactivated;
  final String defaultSize;
  final String material;
  final String quality;
  final String qrCode2;
  final String displayName;
  final int displayOrder;
  final int minQuantity;
  final int maxQuantity;
  final String qpsCode;
  final String demandType;
  final String image;
  final String imageUrl;
  final String imageUrl2;
  final String imageUrl3;
  final String imageUrl4;
  final String imageUrl5;
  final String imageUrl6;
  final String imageUrl7;
  final String imageUrl8;
  final String imageUrl9;
  final String imageUrl10;
  final String imageUrl11;
  final String imageUrl12;
  final int adShoot;
  final String technology;
  final String imageAlt;
  final String technologyImage;
  final String technologyImageUrl;
  final int isCore;
  final int minimumArticleQuantity;
  final double likeability;
  final String brandRank;
  final dynamic gradeToRatiosApps;
  final dynamic relatedProducts;

  Product({
    required this.season,
    required this.brand,
    required this.mood,
    required this.gender,
    required this.theme,
    required this.category,
    required this.name,
    required this.color,
    required this.option,
    required this.mrp,
    required this.subCategory,
    required this.collection,
    required this.fit,
    required this.description,
    required this.qrCode,
    required this.looks,
    required this.looksImageUrl,
    required this.looksImage,
    required this.fabric,
    required this.ean,
    required this.finish,
    required this.availableSizes,
    required this.availableSizesWithDeactivated,
    required this.sizeWiseStock,
    required this.sizeWiseStockPlant,
    required this.offerMonths,
    required this.productClass,
    required this.promoted,
    required this.secondary,
    required this.deactivated,
    required this.defaultSize,
    required this.material,
    required this.quality,
    required this.qrCode2,
    required this.displayName,
    required this.displayOrder,
    required this.minQuantity,
    required this.maxQuantity,
    required this.qpsCode,
    required this.demandType,
    required this.image,
    required this.imageUrl,
    required this.imageUrl2,
    required this.imageUrl3,
    required this.imageUrl4,
    required this.imageUrl5,
    required this.imageUrl6,
    required this.imageUrl7,
    required this.imageUrl8,
    required this.imageUrl9,
    required this.imageUrl10,
    required this.imageUrl11,
    required this.imageUrl12,
    required this.adShoot,
    required this.technology,
    required this.imageAlt,
    required this.technologyImage,
    required this.technologyImageUrl,
    required this.isCore,
    required this.minimumArticleQuantity,
    required this.likeability,
    required this.brandRank,
    required this.gradeToRatiosApps,
    required this.relatedProducts,
  });

  Product.fromMap(Map<String, dynamic> json)
      : season = json["Season"],
        brand = json["Brand"],
        mood = json["Mood"],
        gender = json["Gender"],
        theme = json["Theme"],
        category = json["Category"],
        name = json["Name"],
        color = json["Color"],
        option = json['Option'],
        mrp = json['MRP'],
        subCategory = json['SubCategory'],
        collection = json['Collection'],
        fit = json['Fit'],
        description = json['Description'],
        qrCode = json['QRCode'],
        looks = json['Looks'] ?? '',
        looksImageUrl = json['LooksImageUrl'] ?? '',
        looksImage = json['LooksImage'],
        fabric = json['Fabric'],
        ean = jsonDecode(json['EAN']),
        finish = json['Finish'],
        availableSizes = jsonDecode(json['AvailableSizes']),
        availableSizesWithDeactivated =
            jsonDecode(json['AvailableSizesWithDeactivated']),
        sizeWiseStock = jsonDecode(json['SizeWiseStock']),
        sizeWiseStockPlant = jsonDecode(json['SizeWiseStockPlant']),
        offerMonths = jsonDecode(json['OfferMonths']),
        productClass = json['ProductClass'],
        promoted = json['Promoted'],
        secondary = json['Secondary'],
        deactivated = json['Deactivated'],
        defaultSize = json['DefaultSize'] ?? '',
        material = json['Material'],
        quality = json['Quality'],
        qrCode2 = json['QRCode2'],
        displayName = json['DisplayName'],
        displayOrder = json['DisplayOrder'],
        minQuantity = json['MinQuantity'],
        maxQuantity = json['MaxQuantity'],
        qpsCode = json['QPSCode'],
        demandType = json['DemandType'] ?? '',
        image = json['Image'],
        imageUrl = json['ImageUrl'],
        imageUrl2 = json['ImageUrl2'],
        imageUrl3 = json['ImageUrl3'],
        imageUrl4 = json['ImageUrl4'],
        imageUrl5 = json['ImageUrl5'],
        imageUrl6 = json['ImageUrl6'] ?? '',
        imageUrl7 = json['ImageUrl7'] ?? '',
        imageUrl8 = json['ImageUrl8'] ?? '',
        imageUrl9 = json['ImageUrl9'] ?? '',
        imageUrl10 = json['ImageUrl10'] ?? '',
        imageUrl11 = json['ImageUrl11'] ?? '',
        imageUrl12 = json['ImageUrl12'] ?? '',
        adShoot = json['AdShoot'],
        technology = json['Technology'],
        imageAlt = json['ImageAlt'],
        technologyImage = json['TechnologyImage'] ?? '',
        technologyImageUrl = json['TechnologyImageUrl'] ?? '',
        isCore = json['IsCore'],
        minimumArticleQuantity = json['MinimumArticleQuantity'],
        likeability = json['Likeabilty'],
        brandRank = json['BrandRank'],
        gradeToRatiosApps = jsonDecode(json['GradeToRatiosApps']),
        relatedProducts = jsonDecode(json['RelatedProducts']);

  Map<String, Object> toMap() {
    return {
      'Season': season,
      'Brand': brand,
      'Mood': mood,
      'Gender': gender,
      'Theme': theme,
      'Category': category,
      'Name': name,
      'Color': color,
      'Option': option,
      'MRP': mrp,
      'SubCategory': subCategory,
      'Collection': collection,
      'Fit': fit,
      'Description': description,
      'QRCode': qrCode,
      'Looks': looks,
      'LooksImage': looksImage,
      'LooksImageUrl': looksImageUrl,
      'Fabric': fabric,
      'EAN': ean,
      'Finish': finish,
      'AvailableSizes': jsonEncode(availableSizes),
      'AvailableSizesWithDeactivated':
          jsonEncode(availableSizesWithDeactivated),
      'SizeWiseStock': (sizeWiseStock),
      'SizeWiseStockPlant': (sizeWiseStockPlant),
      'OfferMonths': jsonEncode(offerMonths),
      'ProductClass': productClass,
      'Promoted': promoted,
      'Secondary': secondary,
      'Deactivated': deactivated,
      'DefaultSize': defaultSize,
      'Material': material,
      'Quality': quality,
      'QRCode2': qrCode2,
      'DisplayName': displayName,
      'DisplayOrder': displayOrder,
      'MinQuantity': minQuantity,
      'MaxQuantity': maxQuantity,
      'QPSCode': qpsCode,
      'DemandType': demandType,
      'Image': image,
      'ImageUrl': imageUrl,
      'ImageUrl2': imageUrl2,
      'ImageUrl3': imageUrl3,
      'ImageUrl4': imageUrl4,
      'ImageUrl5': imageUrl5,
      'ImageUrl6': imageUrl6,
      'ImageUrl7': imageUrl7,
      'ImageUrl8': imageUrl8,
      'ImageUrl9': imageUrl9,
      'ImageUrl10': imageUrl10,
      'ImageUrl11': imageUrl11,
      'ImageUrl12': imageUrl12,
      'AdShoot': adShoot,
      'Technology': technology,
      'ImageAlt': imageAlt,
      'TechnologyImage': technologyImage,
      'TechnologyImageUrl': technologyImageUrl,
      'IsCore': isCore,
      'MinimumArticleQuantity': minimumArticleQuantity,
      'Likeabilty': likeability,
      'BrandRank': brandRank,
      'GradeToRatiosApps': jsonEncode(gradeToRatiosApps),
      'RelatedProducts': jsonEncode(relatedProducts),
    };
  }
}
