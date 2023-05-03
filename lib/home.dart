import 'package:flutter/material.dart';
import 'package:movies_tp/SQLDB.dart';
import 'package:movies_tp/UpdateMovie.dart';

import 'DeleteMovie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SQLdb sqLdb = SQLdb();

  //*********************************************
  Future<List<Map>> getAllMovies() async {
    List<Map> movies = await sqLdb.getData("SELECT * FROM 'movies' ");
    return movies;
  }
  //*********************************************
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("AddMovie");
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            /*
            ElevatedButton(
              onPressed: () async {
                int req = await sqLdb.insertData(
                    "INSERT INTO 'movies' (titre, duree) VALUES ('Fight Club', 139)");
                print("$req");
              },
              child: const Text("Ajouter"),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map> movies = await sqLdb.getData(
                    "SELECT * FROM 'movies' ");
                print("${movies}");
              },
              child: const Text("GetList"),
            ),*/
            Expanded(
                flex:11,
                child: Container(
                  child: FutureBuilder(
                      future: getAllMovies(),
                      builder: (ctx,snp) {
                        if(snp.hasData){
                          List<Map> listMovies =snp.data!;
                          return ListView.builder(
                              itemCount: listMovies.length,
                              itemBuilder: (ctx,index){
                                return Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                        Icons.movie,
                                        color: Colors.lightBlue,
                                        size: 30,
                                         ),
                                    title: Text("${listMovies[index]['titre']}",style: TextStyle(fontSize:25,color: Colors.black),),
                                    subtitle: Text("${listMovies[index]['duree']} min",style: TextStyle(fontSize:20,color: Colors.black45),),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context)=>UpdateMovie(id:listMovies[index]['id'],titre:listMovies[index]['titre'],duree:listMovies[index]['duree']))
                                              );
                                            },

                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all(Colors.green.withOpacity(0.2)),
                                            ),

                                            child: Icon(Icons.edit,color: Colors.green,)),
                                        SizedBox(width: 8),
                                        TextButton(
                                            onPressed: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (context)=>AlertDialog(
                                                      title: Text("Are you sure you want to delete ${listMovies[index]['titre']}"),
                                                      actions: [
                                                        ElevatedButton(onPressed: () async{
                                                          int req = await sqLdb.deleteData("DELETE FROM 'movies' WHERE id = ${listMovies[index]['id']}");
                                                          if(req>0){
                                                            Navigator.of(context).pop();
                                                            setState(() {

                                                            });
                                                          }
                                                        }, child: Text("Yes")),
                                                        ElevatedButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        }, child: Text("No")),
                                                      ],
                                                  ));
                                                  },

                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all(Colors.red.withOpacity(0.2)),
                                            ),

                                            child: Icon(Icons.delete,color: Colors.red,))
                                      ],
                                    ),
                                  ),
                                ) ;
                              });
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }
                      }
                  ),
                )),
            Expanded(
                flex:1,
                child: Container(

                ))
          ],
        ),
      ),
    );
  }
}
