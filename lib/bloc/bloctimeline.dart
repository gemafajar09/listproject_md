import 'package:listproject/model/timelineprojek.dart';
import 'package:listproject/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class Bloctimeline {
  final repository = Repository();
  final _gettimeline = PublishSubject<List<Timelineprojek>>();

  Observable<List<Timelineprojek>> get alltimeline => _gettimeline.stream;

  addtimeline(_idprojek, _iduser, _status, _keteranagn) {
    repository.simpantimeline(_idprojek, _iduser, _status, _keteranagn);
  }

  hapustimeline(_idTimeline) {
    repository.hapustimeline(_idTimeline);
  }

// ambil semua data
  tampil(var idUser, var idProject) async {
    List<Timelineprojek> _timeline =
        await repository.showtimeline(idUser.toString(), idProject.toString());

    _gettimeline.sink.add(_timeline);
  }

  // matikan aksi
  dispose() {
    _gettimeline.close();
  }
}

final bloctimeline = Bloctimeline();
