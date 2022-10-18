abstract class CredentialsRepository {
  Future<void> saveCredentials(
    String login,
    String password,
  );
}
