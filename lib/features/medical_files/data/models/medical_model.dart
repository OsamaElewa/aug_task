class MedicalModel {
  String? message;
  List<MedicalFiles>? medicalFiles;

  MedicalModel({this.message, this.medicalFiles});

  MedicalModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['medical_files'] != null) {
      medicalFiles = <MedicalFiles>[];
      json['medical_files'].forEach((v) {
        medicalFiles!.add(new MedicalFiles.fromJson(v));
      });
    }
  }
}

class MedicalFiles {
  int? userId;
  List<Vaccinations>? vaccinations;
  String? updatedAt;
  String? createdAt;
  int? id;

  MedicalFiles(
      {this.userId,
        this.vaccinations,
        this.updatedAt,
        this.createdAt,
        this.id});

  MedicalFiles.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['vaccinations'] != null) {
      vaccinations = <Vaccinations>[];
      json['vaccinations'].forEach((v) {
        vaccinations!.add(new Vaccinations.fromJson(v));
      });
    }
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}

class Vaccinations {
  String? img;
  String? date;

  Vaccinations({this.img, this.date});

  Vaccinations.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    date = json['date'];
  }
}