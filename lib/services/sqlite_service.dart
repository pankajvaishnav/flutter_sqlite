import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product_model.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'planets.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          CREATE TABLE planets(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
          Season TEXT,
          Brand TEXT,
          Mood TEXT,
          Gender TEXT,
          Theme TEXT,
          Category TEXT,
          Name TEXT,
          Color TEXT,
          Option TEXT,
          MRP REAL,
          SubCategory TEXT,
          Collection TEXT,
          Fit TEXT,
          Description TEXT,
          QRCode TEXT,
          Looks Text,
          LooksImageUrl Text,
          LooksImage Text,
          Fabric TEXT,
          EAN TEXT,
          Finish TEXT,
          AvailableSizes TEXT,
          AvailableSizesWithDeactivated TEXT,
          SizeWiseStock TEXT,
          SizeWiseStockPlant TEXT,
          OfferMonths TEXT,
          ProductClass INTEGER,
          Promoted INTEGER,
          Secondary INTEGER,
          Deactivated INTEGER,
          DefaultSize TEXT,
          Material TEXT,
          Quality TEXT,
          QRCode2 TEXT,
          DisplayName TEXT,
          DisplayOrder INTEGER,
          MinQuantity INTEGER,
          MaxQuantity INTEGER,
          QPSCode TEXT,
          DemandType TEXT,
          Image TEXT,
          ImageUrl TEXT,
          ImageUrl2 TEXT,
          ImageUrl3 TEXT,
          ImageUrl4 TEXT,
          ImageUrl5 TEXT,
          ImageUrl6 TEXT,
          ImageUrl7 TEXT,
          ImageUrl8 TEXT,
          ImageUrl9 TEXT,
          ImageUrl10 TEXT,
          ImageUrl11 TEXT,
          ImageUrl12 TEXT,
          AdShoot INTEGER,
          Technology TEXT,
          ImageAlt TEXT,
          TechnologyImage TEXT,
          TechnologyImageUrl TEXT,
          IsCore INTEGER,
          MinimumArticleQuantity INTEGER,
          Likeabilty REAL,
          BrandRank TEXT,
          GradeToRatiosApps TEXT,
          RelatedProducts TEXT
            )''',
        );
      },
    );
  }

// insert data
  Future<int> insertPlanets(List<Product> planets) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in planets) {
      result = await db.insert('planets', planet.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

// retrieve data
  Future<List<Product>> retrieveProducts() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('planets');
    return queryResult.map((e) => Product.fromMap(e)).toList();
  }

  Future<List<Product>> retrieveSpecificProducts(name) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('planets', where: "Name = ?", whereArgs: [name]);
    return queryResult.map((e) => Product.fromMap(e)).toList();
  }

// delete user
  Future<void> deleteSpecificProducts(int id) async {
    final db = await initializedDB();
    await db.delete(
      'planets',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteProducts() async {
    final db = await initializedDB();
    await db.delete(
      'planets',
      // where: "id = ?",
      // whereArgs: [id],
    );
  }
}
