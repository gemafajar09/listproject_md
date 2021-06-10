class Timelineprojek {
  String idTimeline;
  String tanggal;
  String status;

  Timelineprojek({this.idTimeline, this.tanggal, this.status});

  Timelineprojek.fromJson(Map<String, dynamic> json) {
    idTimeline = json['id_timeline'];
    tanggal = json['tanggal'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_timeline'] = this.idTimeline;
    data['tanggal'] = this.tanggal;
    data['status'] = this.status;
    return data;
  }
}
