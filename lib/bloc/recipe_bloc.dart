import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_api_using_block/bloc/recipe_event.dart';
import 'package:book_api_using_block/bloc/recipe_state.dart';
import 'package:equatable/equatable.dart';

import '../data/model.dart';
import '../data/repository.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  FoodRepository repository;


  PizzaBloc({required this.repository}) : super(PizzaInitialState()) {
    on((event, emit) async {
      if(event is FetchPizzaEvent) {
        List<Recipes>? postDetails = await repository.getFoods();
        emit(PizzaLoadedState(recipeDetails: postDetails!));
      }
      else if(event is PizzaErrorState){
        emit(PizzaErrorState(message: "Error"));
      }
    });
  }

  PizzaState get initialState => PizzaInitialState();

}