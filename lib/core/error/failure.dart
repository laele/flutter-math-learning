import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({super.message = 'Error while accessing local storage.'});
  @override
  List<Object?> get props => [super.message];
}

class RemoteSyncFailure extends Failure {
  const RemoteSyncFailure({super.message = 'We could\'nt synchronize the data with the server.'});
  @override
  List<Object?> get props => [super.message];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'An unexpected error occurred'});
  @override
  List<Object?> get props => [super.message];
}
