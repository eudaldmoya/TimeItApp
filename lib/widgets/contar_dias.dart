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
  final bool atWork;
  ContarDias({
    Key? key,
    required this.atWork,
  });
  int jornadaIniciada = 1;
  int aciertos = 0;
  bool jornadacreada = false;
  int jornadaAcabada = 1;
  int comprobacion = 0;
  int contador = 0;
  int creado = 0;

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
              comprobacion = 1;

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
            creado = 1;
            iddocumento = fecha.id;
            print('IDDELDOCUMENTO $iddocumento');
          }

          for (int j = 0; j < conjuntoJornadas.length; j++) {
            if (conjuntoJornadas[j].ddmmyy == dateStr) {
              if ((comprobacion == 1) || (creado == 1)) {
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

                return StreamBuilder(
                    stream: work.GetJornadas(conjuntoJornadas[j].id),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Jornada>> snapshot) {
                      if (snapshot.hasError) {
                        print("ERROR ${conjuntoJornadas[j].id}");
                        return ErrorWidget(snapshot.error.toString());
                      }
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      List<Jornada> jornadasusuario = snapshot.data!;
                      //QUIERO QUE CUANDO SE HAGA UNA JORNADA SE GASTE,
                      //LA CONDICION SERA QUE ESTE VALOR TIENE QUE SER 1, DE ESTA FORMA NO
                      //ENTRARA EN BUCLE

                      // if (jornadaIniciada == 1) {
                      //   for (int k = 0; k < jornadasusuario.length; j++) {
                      //     if (!jornadasusuario[k].finished) {
                      //       work.finishedJornada(
                      //           conjuntoJornadas[j].id, jornadasusuario[k].id);

                      //           jornadacerrada = true;
                      //     }

                      //   }

                      //   if(jornadacerrada =)

                      print(
                          'ESTA TRABAJANDO NUMERO DE JORNADAS $atWork ${jornadasusuario.length}');
                      if (!atWork) {
                        for (int h = 0; h < 1; h++) {
                          if (jornadasusuario[h].finished == false) {
                            print(
                                "ESTA TRABAJDNO MENTIRA ${jornadasusuario[h].id}");
                            work.finishedJornada(
                                conjuntoJornadas[j].id, jornadasusuario[h].id);
                          }

                          jornadacreada = false;
                        }
                        contador--;
                      }


                      print('ESTADO DEL TRABAJO $atWork');
                      if(atWork){
                      if (jornadaIniciada == 1) {
                        print(
                            'ESTA TRABAJANDO $atWork y la jornada $jornadaIniciada');
                        print('LA JORNADA ESTA EN ${jornadaIniciada}');
                        jornadaIniciada = 0;
                        final JornadaUser = Jornada();
                        work.sendJordadaUser(
                            JornadaUser, conjuntoJornadas[j].id);
                            contador++;
                      }
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

                      return Text("");

                      //SE TIENE QUE COMPROBAR SI ES DE OTRO USUARIO O NO PARA PONER LA JORNADA
                      //EN EL DOC ESTA LA PARTE DE LOOKTOUSER PARA COMPROBARLO
                      //AHORA MISMO CREA LA JORNADA, LO TIENE QUE HACER CUANDO LO ESCANEA, Y CUANDO VUELVA A ESCANEAR, CUANDO EL ITWORK SEA FALSE, QUE HAGA LO OTRO
                    });
              }
            }
          }
          return Text("");
        });
  }
}
