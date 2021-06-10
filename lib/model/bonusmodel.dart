class Bonusmodel {
  String hargaBersih;
  String persen;
  String namaProject;
  String idProject;
  String statusBayar;

  Bonusmodel(
      {this.hargaBersih,
      this.persen,
      this.namaProject,
      this.idProject,
      this.statusBayar});

  Bonusmodel.fromJson(Map<String, dynamic> json) {
    hargaBersih = json['harga_bersih'];
    persen = json['persen'];
    namaProject = json['nama_project'];
    idProject = json['id_project'];
    statusBayar = json['status_bayar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['harga_bersih'] = this.hargaBersih;
    data['persen'] = this.persen;
    data['nama_project'] = this.namaProject;
    data['id_project'] = this.idProject;
    data['status_bayar'] = this.statusBayar;
    return data;
  }
}
