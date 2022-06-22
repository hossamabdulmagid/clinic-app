class Appointment {
  List<Data>? data;

  Appointment({this.data});

  Appointment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? doctorName;
  String? startDate;
  String? doctorId;
  String? patientId;
  String? patientName;
  String? emailReminder;
  String? textReminder;
  String? followUpMessage;
  String? status;
  String? access;
  String? endDate;
  String? createdBy;
  String? createdByName;
  String? clinicId;
  int? secretKey;
  dynamic emailReminderSent;
  String? emailReminderToBeSentAt;
  dynamic textReminderSent;
  String? textReminderToBeSentAt;
  int? createdAt;
  dynamic hasEnded;
  String? endDatex;
  String? updatedBy;
  String? updatedByName;

  Data(
      {this.sId,
      this.doctorName,
      this.startDate,
      this.doctorId,
      this.patientId,
      this.patientName,
      this.emailReminder,
      this.textReminder,
      this.followUpMessage,
      this.status,
      this.access,
      this.endDate,
      this.createdBy,
      this.createdByName,
      this.clinicId,
      this.secretKey,
      this.emailReminderSent,
      this.emailReminderToBeSentAt,
      this.textReminderSent,
      this.textReminderToBeSentAt,
      this.createdAt,
      this.hasEnded,
      this.endDatex,
      this.updatedBy,
      this.updatedByName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    doctorName = json['doctorName'];
    startDate = json['startDate'];
    doctorId = json['doctorId'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    emailReminder = json['emailReminder'];
    textReminder = json['textReminder'];
    followUpMessage = json['followUpMessage'];
    status = json['status'];
    access = json['access'];
    endDate = json['EndDate'];
    createdBy = json['createdBy'];
    createdByName = json['createdByName'];
    clinicId = json['clinicId'];
    secretKey = json['secretKey'];
    emailReminderSent = json['emailReminderSent'];
    emailReminderToBeSentAt = json['emailReminderToBeSentAt'];
    textReminderSent = json['textReminderSent'];
    textReminderToBeSentAt = json['textReminderToBeSentAt'];
    createdAt = json['createdAt'];
    hasEnded = json['hasEnded'];
    endDatex = json['endDatex'];
    updatedBy = json['updatedBy'];
    updatedByName = json['updatedByName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.sId;
    data['doctorName'] = this.doctorName;
    data['startDate'] = this.startDate;
    data['doctorId'] = this.doctorId;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['emailReminder'] = this.emailReminder;
    data['textReminder'] = this.textReminder;
    data['followUpMessage'] = this.followUpMessage;
    data['status'] = this.status;
    data['access'] = this.access;
    data['EndDate'] = this.endDate;
    data['createdBy'] = this.createdBy;
    data['createdByName'] = this.createdByName;
    data['clinicId'] = this.clinicId;
    data['secretKey'] = this.secretKey;
    data['emailReminderSent'] = this.emailReminderSent;
    data['emailReminderToBeSentAt'] = this.emailReminderToBeSentAt;
    data['textReminderSent'] = this.textReminderSent;
    data['textReminderToBeSentAt'] = this.textReminderToBeSentAt;
    data['createdAt'] = this.createdAt;
    data['hasEnded'] = this.hasEnded;
    data['endDate'] = this.endDatex;
    data['updatedBy'] = this.updatedBy;
    data['updatedByName'] = this.updatedByName;
    return data;
  }
}
