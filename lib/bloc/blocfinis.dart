import 'package:listproject/repo/repository.dart';
import 'package:listproject/model/projekfinish.dart';
import 'package:rxdart/rxdart.dart';

class Blocfinis {
  final repository = Repository();
  final _getfinis = PublishSubject<List<Projekfinish>>();
  Observable<List<Projekfinish>> get allfinis => _getfinis.stream;

// ambil semua data
  tampil(String id) async {
    List<Projekfinish> _proses = await repository.getfinis(id);

    _getfinis.sink.add(_proses);
  }

  // matikan aksi
  dispose() {
    _getfinis.close();
  }
}

final blocfinis = Blocfinis();
