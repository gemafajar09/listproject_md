class Progresfitur {
  String idFitur;
  String idProject;
  String fitur;
  String status;

  Progresfitur({this.idFitur, this.idProject, this.fitur, this.status});

  Progresfitur.fromJson(Map<String, dynamic> json) {
    idFitur = json['id_fitur'];
    idProject = json['id_project'];
    fitur = json['fitur'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_fitur'] = this.idFitur;
    data['id_project'] = this.idProject;
    data['fitur'] = this.fitur;
    data['status'] = this.status;
    return data;
  }
}
