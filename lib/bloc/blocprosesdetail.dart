import 'package:listproject/repo/repository.dart';
import 'package:listproject/model/progresfitur.dart';
import 'package:rxdart/rxdart.dart';

class Blocprosesdetail {
  final repository = Repository();
  final _getfitur = PublishSubject<List<Progresfitur>>();
  Observable<List<Progresfitur>> get allfitur => _getfitur.stream;

// ambil semua data
  tampil(String id) async {
    List<Progresfitur> _fitur = await repository.getprosesfitur(id);

    _getfitur.sink.add(_fitur);
  }

  // matikan aksi
  dispose() {
    _getfitur.close();
  }
}

final blocfinis = Blocprosesdetail();
