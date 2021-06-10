import 'package:listproject/api.dart';
import 'package:listproject/model/projekproses.dart';
import 'package:listproject/model/progresfitur.dart';
import 'package:listproject/model/projekwaiting.dart';
import 'package:listproject/model/projekfinish.dart';
import 'package:listproject/model/timelineprojek.dart';
import 'package:listproject/model/bonusmodel.dart';

class Repository {
  final api = Api();

  // ambil data projek proses
  Future<List<Projekproses>> getproses(String id) => api.projekproses(id);
  Future<List<Progresfitur>> getprosesfitur(String id) =>
      api.getfiturprogres(id);
  // simpan timeline
  Future simpantimeline(String idProject, String idUser, String status) =>
      api.timelinesimpan(idProject, idUser, status);
  // show timeline
  Future<List<Timelineprojek>> showtimeline(String idUser, String idProject) =>
      api.gettimeline(idUser, idProject);
  // ambil data projek finis
  Future<List<Projekfinish>> getfinis(String id) => api.projekfinish(id);
  // ambil data projek waiting
  Future<List<Projekwaiting>> getwaiting(String id) => api.projekwaiting(id);
  // ambil data projek bonus
  Future<List<Bonusmodel>> getbonus(String id) => api.bonusdetail(id);
}
