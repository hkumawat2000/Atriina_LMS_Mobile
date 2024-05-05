import 'package:choice/network/requestbean/MyCartRequestBean.dart';
import 'package:choice/network/requestbean/SecuritiesRequest.dart';
import 'package:choice/network/responsebean/ApprovedListResponseBean.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/ESignResponse.dart';
import 'package:choice/network/responsebean/MyCartResponseBean.dart';
import 'package:choice/network/responsebean/ProcessCartResponse.dart';
import 'package:choice/network/responsebean/SecuritiesResponseBean.dart';
import 'package:choice/shares/LoanApplicationDao.dart';

class LoanApplicationRepository {
  final loanApplicationDao = LoanApplicationDao();

  Future<ProcessCartResponse> createLoanApplication(cartName, otp, fileId, pledgorBoid) => loanApplicationDao.createLoanApplication(cartName, otp, fileId, pledgorBoid);

  Future<ProcessCartResponse> mfCreateLoanApplication(cartName,otp) => loanApplicationDao.mfCreateLoanApplication(cartName,otp);

  Future<CommonResponse> createLoanRenewalApplication(loanRenewalName,otp) => loanApplicationDao.createLoanRenewalApplication(loanRenewalName,otp);

  Future<ApprovedListResponseBean> getUserSecurities(SecuritiesRequest securitiesRequest)=> loanApplicationDao.getUserSecurities(securitiesRequest);

  Future<SecuritiesResponseBean> getSecurities(SecuritiesRequest securitiesRequest)=> loanApplicationDao.getSecurities(securitiesRequest);

  Future<MyCartResponseBean> myCart(MyCartRequestBean requestBean) => loanApplicationDao.myCart(requestBean);

  Future<CommonResponse> pledgeOTP(instrumentType) => loanApplicationDao.pledgeOTP(instrumentType);

  Future<CommonResponse> loanRenewalOTP(loanRenewalOTP) => loanApplicationDao.loanRenewalOTP(loanRenewalOTP);

  Future<ESignResponse> esignVerification(loanName) => loanApplicationDao.esignVerification(loanName);

  Future<CommonResponse> createTopUp(loanName,fileId) => loanApplicationDao.createTopUp(loanName,fileId);

  Future<CommonResponse> esignSuccess(loanName,fileId) => loanApplicationDao.esignSuccess(loanName,fileId);
}