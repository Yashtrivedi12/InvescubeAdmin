import 'package:flutter/material.dart';
import 'package:invescube_admin/Model/tradingModel.dart';

class DataProvider with ChangeNotifier {
  Data _data;

  DataProvider(this._data);

  Data get data => _data;

  void updateT1Update(String newT1Update) {
    _data = Data(
      id: _data.id,
      mainType: _data.mainType,
      name: _data.name,
      showDate: _data.showDate,
      time: _data.time,
      type: _data.type,
      target: _data.target,
      target1: _data.target1,
      target2: _data.target2,
      stoploss: _data.stoploss,
      targetStatus: _data.targetStatus,
      target1Status: _data.target1Status,
      target2Status: _data.target2Status,
      t1Update: newT1Update,
      t2Update: _data.t2Update,
      t3Update: _data.t3Update,
      spUpdate: _data.spUpdate,
      updateOn: _data.updateOn,
      date: _data.date,
    );
    notifyListeners();
  }

  void updateT2Update(String newT2Update) {
    _data = Data(
      id: _data.id,
      mainType: _data.mainType,
      name: _data.name,
      showDate: _data.showDate,
      time: _data.time,
      type: _data.type,
      target: _data.target,
      target1: _data.target1,
      target2: _data.target2,
      stoploss: _data.stoploss,
      targetStatus: _data.targetStatus,
      target1Status: _data.target1Status,
      target2Status: _data.target2Status,
      t1Update: _data.t1Update,
      t2Update: newT2Update,
      t3Update: _data.t3Update,
      spUpdate: _data.spUpdate,
      updateOn: _data.updateOn,
      date: _data.date,
    );
    notifyListeners();
  }

  void updateT3Update(String newT3Update) {
    _data = Data(
      id: _data.id,
      mainType: _data.mainType,
      name: _data.name,
      showDate: _data.showDate,
      time: _data.time,
      type: _data.type,
      target: _data.target,
      target1: _data.target1,
      target2: _data.target2,
      stoploss: _data.stoploss,
      targetStatus: _data.targetStatus,
      target1Status: _data.target1Status,
      target2Status: _data.target2Status,
      t1Update: _data.t1Update,
      t2Update: _data.t2Update,
      t3Update: newT3Update,
      spUpdate: _data.spUpdate,
      updateOn: _data.updateOn,
      date: _data.date,
    );
    notifyListeners();
  }
}
