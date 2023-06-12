
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/recipe_bloc.dart';
import '../bloc/recipe_event.dart';
import '../bloc/recipe_state.dart';
import '../data/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PizzaBloc pizzaBloc;

  @override
  void initState() {
    pizzaBloc = BlocProvider.of<PizzaBloc>(context);
    pizzaBloc.add(FetchPizzaEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 35,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu-JxuDBGV26p7Q2Tq-3L9By2CGBrixYvtKg&usqp=CAU'),
        ),
        title: const Text("Pizza Api", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 23),),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: const Icon(Icons.search, size: 30, color: Colors.black,)),
          const SizedBox(width: 8,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications, size: 30, color: Colors.black,)),
        ],
      ),
      body: Container(
        child: BlocBuilder<PizzaBloc, PizzaState>(builder: (context, state) {
          if (state is PizzaInitialState) {
            return _buildLoading();
          } else if (state is PizzaLoadingState) {
            return _buildLoading();
          } else if (state is PizzaLoadedState) {
            return _foodList(state.recipeDetails);
          } else if (state is PizzaErrorState) {
            return _buildError();
          } else {
            throw Exception();
          }
        }),
      ),
    );
  }
}

//Widgets...
Widget _buildLoading() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Text('Please Wait for a Minute', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
      ],
    ),
  );
}

Widget _foodList(List<Recipes> postdetails) {
  return Container(
    child: ListView.builder(
        itemCount: postdetails.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5.0,
            child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 180,
                      width: 130,
                      child: Image.network('${postdetails[index].imageUrl}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(2),
                                margin: EdgeInsets.only(top: 9),
                                child: Text("Title:- "+"${postdetails[index].title}",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                )),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text("Publisher:- "+
                                '${postdetails[index].publisher}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "Recipe Id:- "+"${postdetails[index].recipeId}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "Publisher Url:- "+"${postdetails[index].publisherUrl}",
                                style: TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                            ),
                            SizedBox(height: 8,),


                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "Source Url:- "+"${postdetails[index].sourceUrl}",
                                style: TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
          );
        }),
  );
}

Widget _buildError() {
  return Center(child: Text('No Data Available'));
}
