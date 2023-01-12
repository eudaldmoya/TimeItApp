import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      return ListView.builder(
        itemCount: conjuntoJornadas.length,
        itemBuilder: (BuildContext context, int index) {
          if (1 == 1) {
            return Container(child: Text("hola"));
          }
          else{
            return Container(child: Text("else"),);
          }
        },
      );
    },
  );
}
