part of 'names_cubit.dart';

abstract class NamesState extends Equatable {
  final List names;
  const NamesState(this.names);

  @override
  List<Object> get props => [];
}

class NamesInitial extends NamesState {
  const NamesInitial(super.names);
}
