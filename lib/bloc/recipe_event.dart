import 'package:equatable/equatable.dart';

abstract class PizzaEvent extends Equatable {
  const PizzaEvent();
}
class FetchPizzaEvent extends PizzaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
