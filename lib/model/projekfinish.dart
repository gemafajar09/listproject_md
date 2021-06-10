class Projekfinish {
  String idProject;
  String judul;
  String deskripsi;
  String progres;
  String tglMasuk;
  String tglDateline;
  String namaClient;
  String noHpClient;
  String harga;

  Projekfinish(
      {this.idProject,
      this.judul,
      this.deskripsi,
      this.progres,
      this.tglMasuk,
      this.tglDateline,
      this.namaClient,
      this.noHpClient,
      this.harga});

  Projekfinish.fromJson(Map<String, dynamic> json) {
    idProject = json['id_project'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    progres = json['progres'];
    tglMasuk = json['tgl_masuk'];
    tglDateline = json['tgl_dateline'];
    namaClient = json['nama_client'];
    noHpClient = json['no_hp_client'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_project'] = this.idProject;
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['progres'] = this.progres;
    data['tgl_masuk'] = this.tglMasuk;
    data['tgl_dateline'] = this.tglDateline;
    data['nama_client'] = this.namaClient;
    data['no_hp_client'] = this.noHpClient;
    data['harga'] = this.harga;
    return data;
  }
}
