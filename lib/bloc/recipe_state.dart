import 'package:equatable/equatable.dart';

import '../data/model.dart';

abstract class PizzaState extends Equatable {}

class PizzaInitialState extends PizzaState {
  @override
  List<Object> get props => [];
}

class PizzaLoadingState extends PizzaState {
  @override
  List<Object> get props => [];
}

class PizzaLoadedState extends PizzaState {
  @override
  List<Recipes> recipeDetails;
  PizzaLoadedState({
    required this.recipeDetails,
  });

  List<Object> get props => throw UnimplementedError();
}

class PizzaErrorState extends PizzaState {
  String message;
  PizzaErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}