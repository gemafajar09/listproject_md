import 'package:listproject/model/projekwaiting.dart';
import 'package:listproject/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class Blocwaiting {
  final repository = Repository();
  final _getwaiting = PublishSubject<List<Projekwaiting>>();
  Observable<List<Projekwaiting>> get allwaiting => _getwaiting.stream;

// ambil semua data
  tampil(String id) async {
    List<Projekwaiting> _proses = await repository.getwaiting(id);

    _getwaiting.sink.add(_proses);
  }

  // matikan aksi
  dispose() {
    _getwaiting.close();
  }
}

final blocwaiting = Blocwaiting();
