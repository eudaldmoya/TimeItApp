import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timeitapp/model/User_work.dart';
import 'package:timeitapp/model/dia.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/model/workers_work.dart';
import 'package:timeitapp/widgets/db.dart' as work;

StreamBuilder<List<ColeccionJornadas>> GroupJornada() {
int aciertos = 0;
int pruebas = 0;


  return StreamBuilder(
    stream: work.GetColWork(),
    builder: (BuildContext context,
        AsyncSnapshot<List<ColeccionJornadas>> snapshot) {
      if (snapshot.hasError) {
        return ErrorWidget(snapshot.error.toString());
      }
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      List<ColeccionJornadas> conjuntoJornadas = snapshot.data!;

     // print("Está entrando a este WIIIIDGEEEEETTTTT");

      // for (int i=0; i < doc.length; i++ ){
      //   doc[i].datetime;

      // }

      // doc.map((dia){
      //   dia['workingDate']

      // });
     // print('EN TOTAL HAY ${conjuntoJornadas.length}');
      // return Text("hola");
      
      return  ListView.builder(
          itemCount: conjuntoJornadas.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime today = DateTime.now();
            String dateStr = "${today.day}-${today.month}-${today.year}";

           // print('FECHA DEL DOCUMENTO ${conjuntoJornadas[index].ddmmyy}');
            int comprobacion = 0;
            if (conjuntoJornadas[index].ddmmyy == dateStr) {
              aciertos= aciertos +1; 
              comprobacion++;
            //  print("tiene la misma fecha");
              final String idDoc = conjuntoJornadas[index].id;
            } else {}
         print('El documentos es ${conjuntoJornadas[index].id}');
            print('LOS ACIERTOS SON $aciertos');
            // if (aciertos == 0)  {
            //   pruebas ++;
            //   final fecha = ColeccionJornadas();
            //   final String coleccion =
            //       '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/';
            //   final String docid = conjuntoJornadas[index].id.toString();
            //   final String coleccion2 = 'trabajadores';
            // //  print("DENTRO DEL ELSE");
            //   //print('EL ID QUE TIENE DENTRO ES ${conjuntoJornadas[index].id}');
            //   work.sendWorkDay(fecha);

            //   //work.sendUser(UserDate, conjuntoJornadas[index].id);
            //   //print('DENTRO DEL ELSE NUMERO DE ACIERTOS ${aciertos}');
            //   return Text("else");

            //   //TODO CUANDO CREEMOS, TENEMOS QUE HACER UN STREAMBUILDER ENTRANDO EN LA CARPETA CON EL ID QUE HEMOS GUARDADO EN DOCID EN EL IF DONDE ACIERTOS++
            // } else {}


            print ('EL NUMERO DE VECES QUE HA ENTRADO A ACIERTOS == 0 ES $pruebas');

           /* if (comprobacion == 1) {ESTO ES LO QUE TIENES QUE QUITAR DE LOS COMENTARIOS
              print(
                  'DENTRO EL ID QUE TIENE DENTRO ES ${conjuntoJornadas[index].id}');
              final objeto = WorkersWorking();
              final String iddocumento = conjuntoJornadas[index].id;
              work.crearWorkerColeccion(objeto, iddocumento);
              int lookToUser =
                  0; //SI ESTO ES 1 QUIERE DECIR QUE HAY UN DOCUMENTO CON EL USUARIO, SI ES 0 QUIERE DECIR QUE NO HAY UNO Y POR LO CUAL, SE TIENE QUE CREAR UNO

              // return Text("data");
              /////////ESTO ES PARA AÑADIR EN CADA DOCUMENTO UN DOCUMENTO CON EL ID DEL USUARIO
              print('CONJUNTO DE JORNADAS ID ${conjuntoJornadas[index].id}');
              // return Text("caca");
              final dbUser = FirebaseFirestore.instance;
              return StreamBuilder(
                stream: work.GetJornadas(conjuntoJornadas[index].id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Jornada>> snapshot) {
                  if (snapshot.hasError) {
                    return ErrorWidget(snapshot.error.toString());
                  }
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  List<Jornada> jornadasusuario = snapshot.data!;
                  //QUIERO QUE CUANDO SE HAGA UNA JORNADA SE GASTE,
                  //LA CONDICION SERA QUE ESTE VALOR TIENE QUE SER 1, DE ESTA FORMA NO
                  //ENTRARA EN BUCLE
                  int jornadaIniciada = 1;
                  print('LA JORNADA ESTA EN ${jornadaIniciada}');
                  if (jornadaIniciada == 1) {
                    jornadaIniciada = 0;
                    final JornadaUser = Jornada();
                    work.sendJordadaUser(JornadaUser, conjuntoJornadas[index].id);
                  }

                  // if (jornadasusuario.length == 0) {
                  //     final JornadaUser = Jornada();
                  //     work.sendJordadaUser(
                  //         JornadaUser, conjuntoJornadas[index].id);
                  //   }
                  //   int jornadascompletas = 0; //ESTO SERVIRÁ PARA VER SI HA ACABADO O NO TODAS LAS JORNADAS
                  //   for (int j = 0; j < jornadasusuario.length; j++) {
                  //     //COMPROBAR SI HAN ACABADO O NO LAS JORNADAS
                  //       if(jornadasusuario[j].finished){

                  //       }
                  //   }

                  // final docs = qsnap.docs;

                  return Text("data");
                },
                // if (snapshot.hasError) {
                //   return ErrorWidget(snapshot.error.toString());
                // }
                // if (!snapshot.hasData) {
                //   return const CircularProgressIndicator();
                // }

                // final qsnap = snapshot.data!;
                // final docs = qsnap.docs;
                // for (int i = 0; i < docs.length; i++) {
                //   //////////MIRAR SI HAY ALGUN DOCUMENTO EN LA COLECCION CON EL USUARIO DE LA CUENTA
                //   ///
                //   if (docs[i].id == FirebaseAuth.instance.currentUser!.uid) {
                //     print("ESTÁ LLEGANDO A LOS ULTIMOS IF");

                //     lookToUser++;
                //   }
                // }

                // if(lookToUser==0){
                //   work.createRoom(conjuntoJornadas[index].id);
                // }

                //   return Text("data");
                // },
              );
              //                 snapshot)  {
              //     if (snapshot.hasError) {
              //       return ErrorWidget(snapshot.error.toString());
              //     }
              //     if (!snapshot.hasData) {
              //       return const CircularProgressIndicator();
              //     }

              //     final qsnap = snapshot.data!;
              //     //https://stackoverflow.com/questions/46596532/how-to-list-subcollections-in-a-cloud-firestore-document

              //     // for (int i = 0; i < docs.length; i++) {
              //     //   //////////MIRAR SI HAY ALGUN DOCUMENTO EN LA COLECCION CON EL USUARIO DE LA CUENTA
              //     //   ///
              //     //   if (docs[i].id == FirebaseAuth.instance.currentUser!.uid) {

              //     //     lookToUser++;
              //     //   }
              //     // }

              //     if(lookToUser==0){
              //       work.createRoom(conjuntoJornadas[index].id);
              //     }

              //     return Text("data");
              //   }
              // );
            } else {
              return Text("else");
            }*/////////////////////////////////////////////////////
          return Text ("hola");},
          
        
        
      );
      
    },
  );
}
