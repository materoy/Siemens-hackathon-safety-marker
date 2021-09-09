part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(this.disasters);

  final List<Alert> disasters;

  @override
  List<Object> get props => [disasters];
}
