import 'package:flutter/material.dart';
import 'package:movies_tp/SQLDB.dart';
import 'package:movies_tp/home.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {

  TextEditingController titre = TextEditingController();
  TextEditingController duree = TextEditingController();
  SQLdb sqLdb = SQLdb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: titre,
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent),
              decoration: InputDecoration(
                labelText: "titre",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: duree,
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent),
              decoration: InputDecoration(
                labelText: "duree",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async{
                  int req = await sqLdb.insertData("INSERT INTO 'movies' (titre,duree) VALUES ('${titre.text}','${int.parse(duree.text)}')");
                  if(req>0){
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context)=>Home()),
                      (route) => false);
                  }
                },
                child: Container(
                    child: Icon( Icons.add,size: 30,),
                    width:double.infinity,
                    
                )
            )
          ],
        ),
      ),
    );
  }
}










