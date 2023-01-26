import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeitapp/model/dia.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/model/workers_work.dart';
import 'package:timeitapp/widgets/db.dart' as work;

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

          DateTime today = DateTime.now();
          String dateStr = "${today.day}-${today.month}-${today.year}";
          for (int i = 0; i < conjuntoJornadas.length; i++) {
            if (conjuntoJornadas[i].ddmmyy == dateStr) {
              aciertos = 1;
              comprobacion = 1;
            }
          }

          if (aciertos == 0) {
            final fecha = ColeccionJornadas();
            final String coleccion =
                '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/';
            work.sendWorkDay(fecha);
            aciertos = 1;
            creado = 1;
            iddocumento = fecha.id;
          }

          for (int j = 0; j < conjuntoJornadas.length; j++) {
            if (conjuntoJornadas[j].ddmmyy == dateStr) {
              if ((comprobacion == 1) || (creado == 1)) {
                final objeto = WorkersWorking();
                final String iddocumento = conjuntoJornadas[j].id;
                work.crearWorkerColeccion(objeto, iddocumento);
                int lookToUser =
                    0; 

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

                      if (!atWork) {
                        for (int h = 0; h < 1; h++) {
                          if (jornadasusuario[h].finished == false) {
                            work.finishedJornada(
                                conjuntoJornadas[j].id, jornadasusuario[h].id);
                          }

                          jornadacreada = false;
                        }
                        contador--;
                      }

                      if (atWork) {
                        if (jornadaIniciada == 1) {
                          jornadaIniciada = 0;
                          final JornadaUser = Jornada();
                          work.sendJordadaUser(
                              JornadaUser, conjuntoJornadas[j].id);
                          contador++;
                        }
                      }

                      return Text("");
                    });
              }
            }
          }
          return Text("");
        });
  }
}
