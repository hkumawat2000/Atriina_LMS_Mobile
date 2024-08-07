import 'dart:async';

import 'package:lms/complete_kyc/CompleteKYCRepository.dart';
import 'package:lms/network/requestbean/ConsentDetailRequestBean.dart';
import 'package:lms/network/requestbean/UserKYCRequest.dart';
import 'package:lms/network/responsebean/CkycDownloadResponse.dart';
import 'package:lms/network/responsebean/CkycSearchResponse.dart';
import 'package:lms/network/responsebean/ConsentDetailResponseBean.dart';
import 'package:lms/network/responsebean/PinCodeResponseBean.dart';
import 'package:lms/network/responsebean/UserCompleteKYCResponseBean.dart';
import 'package:lms/network/responsebean/UserKYCResponse.dart';

class CompleteKYCBloc{
  CompleteKYCBloc();
  final completeKYCRepository = CompleteKYCRepository();
  final _userKYcDataController = StreamController<UserKYCData>.broadcast();

  Future<UserCompleteKYCResponseBean> saveUserKYC(UserKYCRequest userKYCRequest) async {
    UserCompleteKYCResponseBean wrapper = await completeKYCRepository.saveUserKYC(userKYCRequest);
    return wrapper;
  }

  Future<UserKYCResponseBean> editUserKYC(String userName, String userAddress, String userId) async {
    UserKYCResponseBean wrapper = await completeKYCRepository.editUserKYC(userName,userAddress,userId);
    return wrapper;
  }

  // Future<UserKYCResponseBean> getAtrinaKYC() async {
  //   UserKYCResponseBean wrapper = await completeKYCRepository.getAtrinaKYC();
  // }

  Future<CkycSearchResponse> getCKYC(panCard, acceptTerms) async{
    CkycSearchResponse wrapper = await completeKYCRepository.getCKYC(panCard, acceptTerms);
    return wrapper;
  }

  Future<CkycDownloadResponse> getDownloadApi(panCard, dob, ckycNo) async{
    CkycDownloadResponse wrapper = await completeKYCRepository.getDownloadApi(panCard, dob, ckycNo);
    return wrapper;
  }

  // Future<ConsentDetailResponse> getConsentInfo(ckycName, acceptTerms, addressList) async{
  //   ConsentDetailResponse wrapper = await completeKYCRepository.getConsentInfo(ckycName, acceptTerms, addressList);
  //   return wrapper;
  // }

  Future<PinCodeResponseBean> getPinCodeDetails(String pinCode) async {
    PinCodeResponseBean wrapper = await completeKYCRepository.getPinCodeDetails(pinCode);
    return wrapper;
  }

  Future<ConsentDetailResponseBean> consentDetails(ConsentDetailRequestBean consentDetailRequestBean) async {
    ConsentDetailResponseBean wrapper = await completeKYCRepository.consentDetails(consentDetailRequestBean);
    return wrapper;
  }
}