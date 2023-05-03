import 'package:flutter/material.dart';

import 'SQLDB.dart';
import 'home.dart';

class UpdateMovie extends StatefulWidget {

  final id;
  final titre;
  final duree;
  const UpdateMovie({Key? key,this.id,this.titre,this.duree}) : super(key: key);

  @override
  State<UpdateMovie> createState() => _UpdateMovieState();
}

class _UpdateMovieState extends State<UpdateMovie> {

  TextEditingController titre = TextEditingController();
  TextEditingController duree = TextEditingController();
  SQLdb sqLdb = SQLdb();

  @override
  void initState() {
    titre.text = widget.titre.toString();
    duree.text = widget.duree.toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update movie"),),
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
                  int req = await sqLdb.updateData('''
                    UPDATE "movies" SET
                    titre = "${titre.text}",
                    duree = ${int.parse(duree.text)}
                    WHERE id = "${widget.id}"
                      ''');
                  if(req>0){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context)=>Home()),
                            (route) => false);
                  }
                },
                child: Container(
                  child: Icon( Icons.update,size: 30,),
                  width:double.infinity,
                )
            )
          ],
        ),
      ),
    );
  }
}