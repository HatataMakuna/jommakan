import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;
  
  String? name;
  
  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime? date;

  @Transient() // Ignore this property, not stored in the database.
  int? computedProperty;
}

// You can have multiple entities in the same file (here models.dart), or you can have them spread across multiple files in your package's lib directory.

/*
Run flutter pub run build_runner build  to generate the binding code required to use ObjectBox.
ObjectBox generator will look for all @Entity annotations in your lib folder and create a single database definition lib/objectbox-model.json and supporting code in lib/objectbox.g.dart
*/