import 'package:listproject/repo/repository.dart';
import 'package:listproject/model/bonusmodel.dart';
import 'package:rxdart/rxdart.dart';

class Blocbonus {
  final repository = Repository();
  final _getbonus = PublishSubject<List<Bonusmodel>>();
  Observable<List<Bonusmodel>> get allbonus => _getbonus.stream;

// ambil semua data
  tampil(String id) async {
    List<Bonusmodel> _bonus = await repository.getbonus(id);

    _getbonus.sink.add(_bonus);
  }

  // matikan aksi
  dispose() {
    _getbonus.close();
  }
}

final blocbonus = Blocbonus();
