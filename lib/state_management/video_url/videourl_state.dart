part of 'videourl_cubit.dart';

sealed class VideourlState extends Equatable {

  @override
  List<Object?> get props => [];
}

final class VideourlInitial extends VideourlState {
  @override
  List<Object?> get props => [];

}
final class VideourlLoading extends VideourlState {

  @override
  List<Object?> get props => [];
}

final class VideourlSuccess extends VideourlState{

  final Uint8List urls;

  VideourlSuccess({required this.urls});
  @override
  List<Object?> get props => [urls];
}

final class VideourlError extends VideourlState {
  final String message;

  VideourlError(this.message);
  @override
  List<Object?> get props => [message];
}
