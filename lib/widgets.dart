import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/web_view.dart';
Widget newsItem(list,context)=>InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(list['url'])));
  },
  child:   Padding(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('${list['urlToImage']}'),
              )
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("${list['title']}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text("${list['publishedAt']}",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15,
                  ),),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);

Widget newsFinalItem(list,context,{isSearch=false,})=>ConditionalBuilder(
condition:list.length>0,
builder: (context)=>ListView.separated(
physics: BouncingScrollPhysics(),
itemBuilder: (BuildContext context, int index) =>newsItem(list[index],context),
separatorBuilder: (BuildContext context, int index)=>Divider(
indent: 20,
endIndent: 20,
),
itemCount: list.length,),
fallback: (context)=>isSearch ? Container(): Center(child: CircularProgressIndicator(),),);