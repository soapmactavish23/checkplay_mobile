import 'dart:io';

abstract interface class CategoryProvider {
  Future<void> findAll();
  Future<void> save();
  Future<void> remove(String id);
  Future<void> uploadImage(File file);
  void search(String value);
  Future<void> findById();
}
