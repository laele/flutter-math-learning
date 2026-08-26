class LocalStorageException implements Exception {
  final String message;

  const LocalStorageException({this.message = 'Local storage operation failed'});
}

class RemoteSyncException implements Exception {
  final String message;

  const RemoteSyncException({this.message = 'Remote storage operation failed'});
}

class AdLoadException implements Exception {
  final String message;
  AdLoadException({required this.message});
}
