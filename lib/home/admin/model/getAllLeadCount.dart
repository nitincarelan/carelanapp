class AllLeadCount {
  int? status;
  String? msg;
  int? leadsCountFollowup;
  int? leadsCountOpen;
  int? leadsCountAssigned;
  int? leadsCountOngoing;
  int? leadsCountComplated;
  int? leadsCountIncative;

  AllLeadCount(
      {this.status,
        this.msg,
        this.leadsCountFollowup,
        this.leadsCountOpen,
        this.leadsCountAssigned,
        this.leadsCountOngoing,
        this.leadsCountComplated,
        this.leadsCountIncative});

  AllLeadCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    leadsCountFollowup = json['leads_count_followup'];
    leadsCountOpen = json['leads_count_open'];
    leadsCountAssigned = json['leads_count_assigned'];
    leadsCountOngoing = json['leads_count_ongoing'];
    leadsCountComplated = json['leads_count_completed'];
    leadsCountIncative = json['leads_count_incative'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['leads_count_followup'] = this.leadsCountFollowup;
    data['leads_count_open'] = this.leadsCountOpen;
    data['leads_count_assigned'] = this.leadsCountAssigned;
    data['leads_count_ongoing'] = this.leadsCountOngoing;
    data['leads_count_complated'] = this.leadsCountComplated;
    data['leads_count_incative'] = this.leadsCountIncative;
    return data;
  }
}