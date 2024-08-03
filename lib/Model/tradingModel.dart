
class InvestmentModel {
  List<Data>? data;

  InvestmentModel({this.data});

  InvestmentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? mainType;
  String? name;
  String? showDate;
  String? time;
  String? type;
  String? target;
  String? target1;
  String? target2;
  String? stoploss;
  String? targetStatus;
  String? target1Status;
  String? target2Status;
  String? stoplessStatus;
  String? des;
  String? des1;
  String? callStatus;
  String? exitStatus;
  String? ifDelete;
  String? t1Update;
  String? t2Update;
  String? t3Update;
  String? spUpdate;
  String? entry;
  String? updateOn;
  String? cmp;
  String? date;

  Data(
      {this.id,
      this.mainType,
      this.name,
      this.showDate,
      this.time,
      this.type,
      this.target,
      this.target1,
      this.target2,
      this.stoploss,
      this.targetStatus,
      this.target1Status,
      this.target2Status,
      this.stoplessStatus,
      this.des,
      this.des1,
      this.callStatus,
      this.exitStatus,
      this.ifDelete,
      this.t1Update,
      this.t2Update,
      this.t3Update,
      this.spUpdate,
      this.entry,
      this.updateOn,
      this.cmp,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainType = json['main_type'];
    name = json['name'];
    showDate = json['show_date'];
    time = json['time'];
    type = json['type'];
    target = json['target'];
    target1 = json['target1'];
    target2 = json['target2'];
    stoploss = json['stoploss'];
    targetStatus = json['target_status'];
    target1Status = json['target1_status'];
    target2Status = json['target2_status'];
    stoplessStatus = json['stopless_status'];
    des = json['des'];
    des1 = json['des1'];
    callStatus = json['call_status'];
    exitStatus = json['exit_status'];
    ifDelete = json['if_delete'];
    t1Update = json['t1_update'];
    t2Update = json['t2_update'];
    t3Update = json['t3_update'];
    spUpdate = json['sp_update'];
    entry = json['entry'];
    updateOn = json['update_on'];
    cmp = json['cmp'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['main_type'] = mainType;
    data['name'] = name;
    data['show_date'] = showDate;
    data['time'] = time;
    data['type'] = type;
    data['target'] = target;
    data['target1'] = target1;
    data['target2'] = target2;
    data['stoploss'] = stoploss;
    data['target_status'] = targetStatus;
    data['target1_status'] = target1Status;
    data['target2_status'] = target2Status;
    data['stopless_status'] = stoplessStatus;
    data['des'] = des;
    data['des1'] = des1;
    data['call_status'] = callStatus;
    data['exit_status'] = exitStatus;
    data['if_delete'] = ifDelete;
    data['t1_update'] = t1Update;
    data['t2_update'] = t2Update;
    data['t3_update'] = t3Update;
    data['sp_update'] = spUpdate;
    data['entry'] = entry;
    data['update_on'] = updateOn;
    data['cmp'] = cmp;
    data['date'] = date;
    return data;
  }
}
