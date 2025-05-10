import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/state.dart';
import 'package:news_app/widgets.dart';
class SearchScreen extends StatelessWidget {
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state) {
        var list=NewsCubit.get(context).searchData;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value ){
                      NewsCubit.get(context).getSearchData(value);
                  },
                  controller:searchController ,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return null;
                    }
                  },
                ),
              ),
              Expanded(child:newsFinalItem(list, context,isSearch:true), ),
            ],
          ),
        );
      },
    );
  }
}
