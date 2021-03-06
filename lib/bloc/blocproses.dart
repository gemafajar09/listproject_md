import 'package:listproject/model/projekproses.dart';
import 'package:listproject/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class Blocproses {
  final repository = Repository();
  final _getproses = PublishSubject<List<Projekproses>>();
  Observable<List<Projekproses>> get allproses => _getproses.stream;

  // ambil semua data
  tampil(String id) async {
    List<Projekproses> _proses = await repository.getproses(id);

    _getproses.sink.add(_proses);
  }

  // selesaikan projek
  selesaikan(String idProject) {
    repository.selesaikanprojek(idProject);
  }

  // tambah team projek
  tambahteams(String idProject, String namateam) {
    repository.tambahteam(idProject, namateam);
  }

  // matikan aksi
  dispose() {
    _getproses.close();
  }
}

final blocproses = Blocproses();
