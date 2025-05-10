import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets.dart';
class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(builder: (context,state){
      var list =NewsCubit.get(context).sportsData;
      return newsFinalItem(list,context);
    },
        listener: (context,state){});
  }
}
