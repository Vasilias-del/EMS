import 'package:flutter/material.dart';

Widget createGridItem(int position)
{
  var color=Colors.white;
  var icondata=Icons.add;

  switch(position)
  {

    case 0:
      color=Colors.cyan;
      icondata=Icons.map;
      break;
    case 1:
      color=Colors.deepPurple;

      icondata=Icons.add_location;
      break;
    case 2:
      color=Colors.orange[300];
      icondata=Icons.library_books;
      break;
    case 3:
      color=Colors.pinkAccent;
      icondata=Icons.access_time;
      break;
    case 4:
      color=Colors.teal[900];
      icondata=Icons.add_shopping_cart;
      break;
    case 5:
      color=Colors.green[600];
      icondata=Icons.list;
      break;
  }


  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right: 10,bottom: 5,top: 5),
      child: Card(
        elevation: 10,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
                color: Colors.white
            ),

        ),
        child: InkWell(
          onTap: () {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("Selected Item $position"))
            );
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icondata,size:40,
                color: Colors.white,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Add",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  });
}
