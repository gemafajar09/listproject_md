import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listproject/model/projekproses.dart';
import 'package:listproject/model/projekwaiting.dart';
import 'package:listproject/model/projekfinish.dart';
import 'package:listproject/model/progresfitur.dart';
import 'package:listproject/model/timelineprojek.dart';
import 'package:listproject/model/bonusmodel.dart';

class Api {
  static const api = "https://projek.gemilangmitrasukses.com/api";

  Future<List<Projekproses>> projekproses(id) async {
    List<Projekproses> projeklist = [];
    final res = await http.get('$api/projek-proses/' + id);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);

      for (int i = 0; i < json.length; i++) {
        var data = Projekproses(
            idProject: json[i]['id_project'].toString(),
            judul: json[i]['judul'],
            deskripsi: json[i]['deskripsi'],
            progres: json[i]['progres'].toString(),
            tglMasuk: json[i]['tgl_masuk'],
            tglDateline: json[i]['tgl_dateline'],
            namaClient: json[i]['nama_client'],
            noHpClient: json[i]['no_hp_client'],
            harga: json[i]['harga']);
        projeklist.add(data);
      }
      return projeklist;
    } else {
      return [];
    }
  }

  Future<List<Projekwaiting>> projekwaiting(id) async {
    List<Projekwaiting> projeklist = [];
    final res = await http.get('$api/projek-waiting/' + id);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      for (int i = 0; i < json.length; i++) {
        var data = Projekwaiting(
            idProject: json[i]['id_project'].toString(),
            judul: json[i]['judul'],
            deskripsi: json[i]['deskripsi'],
            tglMasuk: json[i]['tgl_masuk'],
            tglDateline: json[i]['tgl_dateline'],
            namaClient: json[i]['nama_client'],
            noHpClient: json[i]['no_hp_client'],
            harga: json[i]['harga']);
        projeklist.add(data);
      }
      return projeklist;
    } else {
      return [];
    }
  }

  Future<List<Projekfinish>> projekfinish(id) async {
    List<Projekfinish> projeklist = [];
    final res = await http.get('$api/projek-finish/' + id);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      for (int i = 0; i < json.length; i++) {
        var data = Projekfinish(
            idProject: json[i]['id_project'].toString(),
            judul: json[i]['judul'],
            deskripsi: json[i]['deskripsi'],
            progres: json[i]['progres'].toString(),
            tglMasuk: json[i]['tgl_masuk'],
            tglDateline: json[i]['tgl_dateline'],
            namaClient: json[i]['nama_client'],
            noHpClient: json[i]['no_hp_client'],
            harga: json[i]['harga']);
        projeklist.add(data);
      }
      return projeklist;
    } else {
      return [];
    }
  }

  Future<List<Progresfitur>> getfiturprogres(id) async {
    List<Progresfitur> listprogresfitur = [];
    final res = await http.get('$api/projek-fitur/' + id);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      for (int i = 0; i < json.length; i++) {
        var data = Progresfitur(
            idFitur: json[i]['id_fitur'].toString(),
            idProject: json[i]['id_project'].toString(),
            fitur: json[i]['fitur'],
            status: json[i]['status'].toString());
        listprogresfitur.add(data);
      }
      return listprogresfitur;
    } else {
      return [];
    }
  }

  Future timelinesimpan(
      String idProject, String idUser, String status, String keterangan) async {
    final res = await http.post('$api/projek-timeline', body: {
      'id_project': idProject,
      'id_user': idUser,
      'status': status,
      'keterangan': keterangan,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var msg = data['pesan'];
    }
  }

  Future<List<Timelineprojek>> gettimeline(idUser, idProject) async {
    List<Timelineprojek> listtimeline = [];
    final res =
        await http.get('$api/projek-timeline-show/' + idUser + '/' + idProject);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      for (int i = 0; i < json.length; i++) {
        var data = Timelineprojek(
          idTimeline: json[i]['id_timeline'].toString(),
          tanggal: json[i]['tanggal'],
          status: json[i]['status'],
        );
        listtimeline.add(data);
      }
      return listtimeline;
    } else {
      return [];
    }
  }

  Future timelinehapus(String idTimeline) async {
    final res = await http.get('$api/projek-timeline-hapus/' + idTimeline);
    if (res.statusCode == 200) {
      print('id:' + idTimeline);
      var data = jsonDecode(res.body);
      print(data['pesan']);
    }
  }

  Future<List<Bonusmodel>> bonusdetail(id) async {
    List<Bonusmodel> listbonus = [];
    final res = await http.get('$api/bonus-list/' + id);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      for (int i = 0; i < json.length; i++) {
        var data = Bonusmodel(
          hargaBersih: json[i]['harga_bersih'],
          persen: json[i]['persen'],
          namaProject: json[i]['nama_project'],
          idProject: json[i]['id_project'],
          statusBayar: json[i]['status_bayar'],
        );
        listbonus.add(data);
      }
      return listbonus;
    } else {
      return [];
    }
  }

  Future kerjakanprojek(String idProject, String idUser) async {
    final res = await http.post('$api/proses-waiting', body: {
      'id_project': idProject,
      'id_user': idUser,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var msg = data['pesan'];
    }
  }

  Future selesaikanprojek(String idProject) async {
    final res = await http.post('$api/projek-finish-save', body: {
      'id_project': idProject,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var msg = data['pesan'];
    }
  }

  Future addteam(String idProject, String namateam) async {
    final res = await http.post('$api/projek-add-team', body: {
      'id_project': idProject,
      'namateam': namateam,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var msg = data['pesan'];
    }
  }
}
