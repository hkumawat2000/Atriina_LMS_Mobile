import 'package:choice/network/requestbean/ValidateBankRequestBean.dart';
import 'package:choice/network/responsebean/ChoiceBankResponseBean.dart';
import 'package:choice/network/responsebean/FundAccValidationResponseBean.dart';
import 'package:choice/nsdl/BankDetailRepository.dart';
import 'package:choice/nsdl/BankMasterResponse.dart';


class BankDetailBloc{
  final bankDetailRepository = BankDetailRepository();

  Future<BankMasterResponse> getBankDetails(ifsc) async{
    BankMasterResponse wrapper = await bankDetailRepository.getBankDetails(ifsc);
    return wrapper;
  }

  Future<FundAccValidationResponseBean> validateBank(ValidateBankRequestBean validateBankRequestBean) async{
    FundAccValidationResponseBean wrapper = await bankDetailRepository.validateBank(validateBankRequestBean);
    return wrapper;
  }

  // Future<CreateContactResponse> createContactAPI() async{
  //   CreateContactResponse wrapper = await bankDetailRepository.createContactAPI();
  //   return wrapper;
  // }

  // Future<CreateFundAccountResponseBean> createFundAccountAPI(CreateFundAccountRequestBean createFundAccountRequestBean) async{
  //   CreateFundAccountResponseBean wrapper = await bankDetailRepository.createFundAccountAPI(createFundAccountRequestBean);
  //   return wrapper;
  // }

  // Future<FundAccValidationResponseBean> fundAccValidationAPI(FundAccValidationRequestBean fundAccValidationRequestBean) async{
  //   FundAccValidationResponseBean wrapper = await bankDetailRepository.fundAccValidationAPI(fundAccValidationRequestBean);
  //   return wrapper;
  // }

  // Future<FundAccValidationResponseBean> fundAccValidationByIdAPI(favID, chequeByteImageString) async{
  //   FundAccValidationResponseBean wrapper = await bankDetailRepository.fundAccValidationByIdAPI(favID, chequeByteImageString);
  //   return wrapper;
  // }

  Future<ChoiceBankResponseBean> getChoiceBankKYC() async{
    ChoiceBankResponseBean wrapper = await bankDetailRepository.getChoiceBankKYC();
    return wrapper;
  }

}