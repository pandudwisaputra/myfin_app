// To parse this JSON data, do
//
//     final transaksiModel = transaksiModelFromJson(jsonString);

import 'dart:convert';

TransaksiModel transaksiModelFromJson(String str) =>
    TransaksiModel.fromJson(json.decode(str));

String transaksiModelToJson(TransaksiModel data) => json.encode(data.toJson());

class TransaksiModel {
  TransaksiModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory TransaksiModel.fromJson(Map<String, dynamic> json) => TransaksiModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.idTransaksi,
    required this.tanggal,
    required this.nominal,
    required this.nominalDiterima,
    required this.status,
    required this.catatan,
  });

  int idTransaksi;
  String tanggal;
  String nominal;
  String nominalDiterima;
  String status;
  String catatan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idTransaksi: json["id_transaksi"],
        tanggal: json["tanggal"],
        nominal: json["nominal"],
        nominalDiterima: json["nominal_diterima"],
        status: json["status"],
        catatan: json["catatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi,
        "tanggal": tanggal,
        "nominal": nominal,
        "nominal_diterima": nominalDiterima,
        "status": status,
        "catatan": catatan,
      };
}

List<Data> listDalamProses = [
  Data(
      idTransaksi: 01,
      tanggal: '27 Oktober 2022',
      nominal: '5000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
  Data(
      idTransaksi: 02,
      tanggal: '27 Oktober 2022',
      nominal: '4000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
  Data(
      idTransaksi: 03,
      tanggal: '27 Oktober 2022',
      nominal: '3000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
  Data(
      idTransaksi: 04,
      tanggal: '27 Oktober 2022',
      nominal: '2000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
  Data(
      idTransaksi: 05,
      tanggal: '27 Oktober 2022',
      nominal: '1000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
  Data(
      idTransaksi: 06,
      tanggal: '27 Oktober 2022',
      nominal: '1000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
  Data(
      idTransaksi: 07,
      tanggal: '27 Oktober 2022',
      nominal: '1000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
  Data(
      idTransaksi: 08,
      tanggal: '27 Oktober 2022',
      nominal: '1000000',
      nominalDiterima: '5000000',
      status: 'pending',
      catatan: '-'),
];
