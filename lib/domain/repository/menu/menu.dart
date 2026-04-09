import 'package:dartz/dartz.dart';

abstract class MenuRepository {
  Future<Either> getMenuCategories();
  
  Future<Either> getMenuItems();
}