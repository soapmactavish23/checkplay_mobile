mixin UserProvider {
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> save();
  Future<void> delete();
  Future<void> findById(String code);
  Future<void> register();
  Future<void> editProfile();
  Future<void> search();
}
