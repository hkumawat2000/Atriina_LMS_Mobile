import 'dart:async';

import 'package:choice/approved_securities/ApprovedSecuritiesRepository.dart';
import 'package:choice/network/requestbean/ApprovedSecuritiesRequestBean.dart';
import 'package:choice/network/responsebean/ApprovedSecurityResponseBean.dart';
import 'package:choice/widgets/WidgetCommon.dart';

class ApprovedSecuritiesBloc {
  final approvedSecuritiesRepository = ApprovedSecuritiesRepository();
  final _listControllerSecurityCategory = StreamController<ApprovedSecuritiesData>.broadcast();

  get listSecurityCategory => _listControllerSecurityCategory.stream;

  Future<ApprovedSecurityResponseBean> getApprovedSecurities(ApprovedSecuritiesRequestBean approvedSecuritiesRequestBean) async {
    ApprovedSecurityResponseBean wrapper = await approvedSecuritiesRepository
        .getApprovedSecurities(approvedSecuritiesRequestBean);
    if (wrapper.isSuccessFull!) {
      printLog('Approve Security ==>>  ${wrapper.data!.approvedSecuritiesList!.length}');
      _listControllerSecurityCategory.sink.add(wrapper.data!);
    } else {
      _listControllerSecurityCategory.sink.addError(wrapper.errorMessage!);
    }
    return wrapper;
  }

  dispose() {
    _listControllerSecurityCategory.close();
  }

  Future<ApprovedSecurityResponseBean> getDirectApprovedSecurityValue(ApprovedSecuritiesRequestBean approvedSecuritiesRequestBean) async{
    ApprovedSecurityResponseBean wrapper = await approvedSecuritiesRepository.getApprovedSecurities(approvedSecuritiesRequestBean);
    return wrapper;
  }
}
