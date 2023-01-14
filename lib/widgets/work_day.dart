import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timeitapp/model/User_work.dart';
import 'package:timeitapp/model/dia.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/widgets/db.dart' as work;

StreamBuilder<List<ColeccionJornadas>> GroupJornada() {
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

      print("Está entrando a este WIIIIDGEEEEETTTTT");

      // for (int i=0; i < doc.length; i++ ){
      //   doc[i].datetime;

      // }

      // doc.map((dia){
      //   dia['workingDate']

      // });
      print('EN TOTAL HAY ${conjuntoJornadas.length}');
      // return Text("hola");
      int aciertos = 0;
      return ListView.builder(
        itemCount: conjuntoJornadas.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime today = DateTime.now();
          String dateStr = "${today.day}-${today.month}-${today.year}";

          print('FECHA DEL DOCUMENTO ${conjuntoJornadas[index].ddmmyy}');
          int comprobacion = 0;
          if (conjuntoJornadas[index].ddmmyy == dateStr) {
            aciertos++;
            comprobacion++;
            print("tiene la misma fecha");
            final String idDoc = conjuntoJornadas[index].id;
          } else {}

          if (aciertos == 0) {
            final fecha = ColeccionJornadas();
            print("DENTRO DEL ELSE");
            work.sendWorkDay(fecha);

            //work.sendUser(UserDate, conjuntoJornadas[index].id);
            //print('DENTRO DEL ELSE NUMERO DE ACIERTOS ${aciertos}');
            return Text("else");

            //TODO CUANDO CREEMOS, TENEMOS QUE HACER UN STREAMBUILDER ENTRANDO EN LA CARPETA CON EL ID QUE HEMOS GUARDADO EN DOCID EN EL IF DONDE ACIERTOS++
          } else {}

          if (comprobacion == 1) {
            int lookToUser =
                0; //SI ESTO ES 1 QUIERE DECIR QUE HAY UN DOCUMENTO CON EL USUARIO, SI ES 0 QUIERE DECIR QUE NO HAY UNO Y POR LO CUAL, SE TIENE QUE CREAR UNO
            
            // return Text("data");
            /////////ESTO ES PARA AÑADIR EN CADA DOCUMENTO UN DOCUMENTO CON EL ID DEL USUARIO
           print('CONJUNTO DE JORNADAS ID ${conjuntoJornadas[index].id}');
          // return Text("caca");
           final dbUser = FirebaseFirestore.instance;
            return StreamBuilder(
              stream: dbUser.doc('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${conjuntoJornadas[index].id}').snapshots(),
       builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot)  {
                if (snapshot.hasError) {
                  return ErrorWidget(snapshot.error.toString());
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final qsnap = snapshot.data!;
                //https://stackoverflow.com/questions/46596532/how-to-list-subcollections-in-a-cloud-firestore-document

                // for (int i = 0; i < docs.length; i++) {
                //   //////////MIRAR SI HAY ALGUN DOCUMENTO EN LA COLECCION CON EL USUARIO DE LA CUENTA
                //   ///
                //   if (docs[i].id == FirebaseAuth.instance.currentUser!.uid) {

                //     lookToUser++;
                //   }
                // }

                if(lookToUser==0){
                  work.createRoom(conjuntoJornadas[index].id);
                }

                return Text("data");
              }
            );
          } else {
            return Text("else");
          }
        },
      );
    },
  );
}
