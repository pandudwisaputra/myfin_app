import 'dart:convert';
import 'dart:ffi';

import 'package:Myfin/transaksipage/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../currency.dart';
import '../helper/conecttion.dart';
import '../helper/exception_handler.dart';
import '../refresh_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DalamProses extends StatefulWidget {
  const DalamProses({Key? key}) : super(key: key);

  @override
  State<DalamProses> createState() => _DalamProsesState();
}

class _DalamProsesState extends State<DalamProses> {
  @override
  Widget build(BuildContext context) {
    List<Data> displayList = List.of(listDalamProses);
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: displayList.length,
      itemBuilder: (_, index) {
        return Container(
          height: 95,
          margin: const EdgeInsets.only(left: 19, right: 19, bottom: 25),
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Pengajuan Kredit",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "ID : ${displayList[index].idTransaksi}",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9,
                      color: Color(0xff757575)),
                ),
                const Spacer(),
                Text(
                  displayList[index].tanggal,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 9),
                )
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayList[index].nominal,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    displayList[index].status,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffEAAD53)),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
