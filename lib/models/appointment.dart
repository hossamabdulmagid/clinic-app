class Appointment {
  bool? success;
  List<Data>? data;

  Appointment({this.success, this.data});

  Appointment.fromJson(Map<String?, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic sId;
  dynamic doctorName;
  dynamic startDate;
  dynamic endDate;
  dynamic doctorId;
  dynamic patientId;
  dynamic patientName;
  dynamic emailReminder;
  dynamic textReminder;
  dynamic followUpMessage;
  dynamic status;
  dynamic access;
  dynamic endDatex;
  dynamic createdBy;
  dynamic createdByName;
  dynamic clinicId;
  int? secretKey;
  bool? emailReminderSent;
  dynamic emailReminderToBeSentAt;
  bool? textReminderSent;
  dynamic textReminderToBeSentAt;
  int? createdAt;
  bool? hasEnded;
  dynamic updatedBy;
  dynamic updatedByName;

  Data({
    this.sId,
    this.doctorName,
    this.startDate,
    this.endDate,
    this.doctorId,
    this.patientId,
    this.patientName,
    this.emailReminder,
    this.textReminder,
    this.followUpMessage,
    this.status,
    this.access,
    this.endDatex,
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
    this.updatedBy,
    this.updatedByName,
  });

  Data.fromJson(Map<String?, dynamic> json) {
    sId = json['_id'];
    doctorName = json['doctorName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    doctorId = json['doctorId'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    emailReminder = json['emailReminder'];
    textReminder = json['textReminder'];
    followUpMessage = json['followUpMessage'];
    status = json['status'];
    access = json['access'];
    endDatex = json['EndDate'];
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
    updatedBy = json['updatedBy'];
    updatedByName = json['updatedByName'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['_id'] = this.sId;
    data['doctorName'] = this.doctorName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['doctorId'] = this.doctorId;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['emailReminder'] = this.emailReminder;
    data['textReminder'] = this.textReminder;
    data['followUpMessage'] = this.followUpMessage;
    data['status'] = this.status;
    data['access'] = this.access;
    data['EndDate'] = this.endDatex;
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
    data['updatedBy'] = this.updatedBy;
    data['updatedByName'] = this.updatedByName;
    return data;
  }
}
