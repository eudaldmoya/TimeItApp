import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timeitapp/model/User_work.dart';
import 'package:timeitapp/model/dia.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/model/workers_work.dart';
import 'package:timeitapp/widgets/add_day.dart';
import 'package:timeitapp/widgets/db.dart' as work;
import 'package:timeitapp/widgets/void_add_day.dart';

class ContarDias extends StatelessWidget {
  int aciertos = 0;
  int comprobacion = 0;
  String iddocumento = '';
  void cacadevaca() {}
  @override
  Widget build(BuildContext context) {
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
          print("ENTRA EN EL WIDGET");
          DateTime today = DateTime.now();
          String dateStr = "${today.day}-${today.month}-${today.year}";
          for (int i = 0; i < conjuntoJornadas.length; i++) {
            print('DIA ${conjuntoJornadas[i].ddmmyy}');
            if (conjuntoJornadas[i].ddmmyy == dateStr) {
              aciertos = 1;

              //  print("tiene la misma fecha");

            }
          }

          print('VALOR DE ACIERTOS NUEVO $aciertos');

          if (aciertos == 0) {
            print('he entrado $aciertos');
            final fecha = ColeccionJornadas();
            final String coleccion =
                '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/';
            work.sendWorkDay(fecha);
            aciertos = 1;
            comprobacion = 1;
            iddocumento = fecha.id;
            print('IDDELDOCUMENTO $iddocumento');
          }

          for (int j = 0; j < conjuntoJornadas.length; j++) {
            if ((comprobacion == 1) &&
                (conjuntoJornadas[j].ddmmyy == dateStr)) {
              print(
                  'DENTRO EL ID QUE TIENE DENTRO ES ${conjuntoJornadas[j].id}');
              final objeto = WorkersWorking();
              final String iddocumento = conjuntoJornadas[j].id;
              work.crearWorkerColeccion(objeto, iddocumento);
              int lookToUser =
                  0; //SI ESTO ES 1 QUIERE DECIR QUE HAY UN DOCUMENTO CON EL USUARIO, SI ES 0 QUIERE DECIR QUE NO HAY UNO Y POR LO CUAL, SE TIENE QUE CREAR UNO

              // return Text("data");
              /////////ESTO ES PARA AÑADIR EN CADA DOCUMENTO UN DOCUMENTO CON EL ID DEL USUARIO
              print('CONJUNTO DE JORNADAS ID ${conjuntoJornadas[j].id}');
              // return Text("caca");
              final dbUser = FirebaseFirestore.instance;

              int jornadaIniciada = 1;

              if (jornadaIniciada == 1) {
                print('LA JORNADA ESTA EN ${jornadaIniciada}');
                jornadaIniciada = 0;
                final JornadaUser = Jornada();
                work.sendJordadaUser(JornadaUser, conjuntoJornadas[j].id);
              }
              //SE TIENE QUE COMPROBAR SI ES DE OTRO USUARIO O NO PARA PONER LA JORNADA
              //AHORA MISMO CREA LA JORNADA, LO TIENE QUE HACER CUANDO LO ESCANEA, Y CUANDO VUELVA A ESCANEAR, CUANDO EL ITWORK SEA FALSE, QUE HAGA LO OTRO
              //EN EL DOC ESTA LA PARTE DE LOOKTOUSER PARA COMPROBARLO
            }
          }

          return Text("data");
        });
  }
}
