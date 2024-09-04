
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/arguments/sell_collateral_arguments.dart';
import 'package:lms/my_loan/MyLoansBloc.dart';
import 'package:lms/sell_collateral/SellCollateralBloc.dart';

class SellCollateralController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;

  SellCollateralController(this._connectionInfo, this._getLoanDetailsUseCase);


  Preferences? preferences;
  MyLoansBloc myLoansBloc = MyLoansBloc();
  SellCollateralBloc sellCollateralBloc = SellCollateralBloc();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> qtyControllers = [];
  List<FocusNode> focusNode = [];
  bool checkBoxValue = false;
  RxBool isMarginShortFall = false.obs;
  RxBool isAPIRespond = false.obs;
  RxList<ItemsEntity> myPledgedSecurityList = <ItemsEntity>[].obs;
  RxList<ItemsEntity> actualMyCartList = <ItemsEntity>[].obs;
  List<int> actualQtyList = [];
  List<bool> isAddBtnShow = [];
  Rx<LoanEntity> loanData = LoanEntity().obs;
  RxDouble vlMarginShortFall = 0.0.obs, vlDesiredValue = 0.0.obs;
  RxDouble totalValue = 0.0.obs;
  RxDouble totalCollateral = 0.0.obs;
  RxString marginShortfallName = "".obs;
  Widget appBarTitle = new Text("", style: new TextStyle(color: Colors.white));
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController _textController = TextEditingController();
  FocusNode focusNodes = FocusNode();
  double? selectedSecurityEligibility = 0;
  RxDouble actualDrawingPower = 0.0.obs;
  SellCollateralArguments sellCollateralArguments = Get.arguments;

  @override
  void OnInit() {
    appBarTitle = Text(sellCollateralArguments.loanNo, style: TextStyle(color: appTheme));
    preferences = Preferences();
    getLoanData();
    super.onInit();
  }

  Future<void> getLoanData() async {
    debugPrint("loanName ===> ${sellCollateralArguments.loanNo}");
    if (await _connectionInfo.isConnected) {
      GetLoanDetailsRequestEntity loanDetailsRequestEntity =
      GetLoanDetailsRequestEntity(
        loanName: sellCollateralArguments.loanNo,
        transactionsPerPage: 15,
        transactionsStart: 0,
      );
      DataState<LoanDetailsResponseEntity> loanDetailsResponse =
      await _getLoanDetailsUseCase.call(GetLoanDetailsParams(
          loanDetailsRequestEntity: loanDetailsRequestEntity));

      if (loanDetailsResponse is DataSuccess) {
        if (loanDetailsResponse.data!.data!.loan != null) {
          setState(() {
            isAPIRespond.value = true;
            loanData.value = loanDetailsResponse.data!.data!.loan!;
            totalCollateral.value = loanDetailsResponse.data!.data!.loan!.totalCollateralValue!;
            totalValue.value = 0.0;
            if (loanDetailsResponse.data!.data!.marginShortfall != null) {
              marginShortfallName.value = loanDetailsResponse.data!.data!.marginShortfall!.name!;
              isMarginShortFall.value = true;
              vlMarginShortFall.value = loanDetailsResponse.data!.data!.marginShortfall!.minimumCashAmount!;
              vlDesiredValue.value = loanDetailsResponse.data!.data!.marginShortfall!.advisableCashAmount!;
            } else {
              isMarginShortFall.value = false;
            }

            for (int i = 0; i < loanDetailsResponse.data!.data!.loan!.items!.length; i++) {
              if(loanDetailsResponse.data!.data!.loan!.items![i].amount != 0.0) {
                myPledgedSecurityList.add(loanDetailsResponse.data!.data!.loan!.items![i]);
                actualDrawingPower.value = actualDrawingPower.value + ((loanData.value.items![i].price! * loanData.value.items![i].pledgedQuantity!) *
                    (loanData.value.items![i].eligiblePercentage! / 100));
              }
            }
            actualMyCartList.addAll(myPledgedSecurityList);

            for (int i = 0; i < myPledgedSecurityList.length; i++) {
              qtyControllers.add(TextEditingController());
              focusNode.add(FocusNode());
              actualQtyList.add(myPledgedSecurityList[i].pledgedQuantity!.toInt());
              if(sellCollateralArguments.isComingFor == Strings.single && myPledgedSecurityList[i].isin == sellCollateralArguments.isin){
                isAddBtnShow.add(false);
                qtyControllers[i].text = myPledgedSecurityList[i].pledgedQuantity!.toInt().toString();
              } else {
                isAddBtnShow.add(true);
              }
            }
            sellCalculationHandling();
            isAPIRespond.value = true;
          });
        }  else {
          commonDialog(Strings.something_went_wrong_try, 0);
        }
      } else if (loanDetailsResponse is DataFailed) {
        if (loanDetailsResponse.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(loanDetailsResponse.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void sellCalculationHandling(){
    setState(() {
      if(!isAddBtnShow.contains(true)){
        checkBoxValue = true;
      } else {
        checkBoxValue = false;
      }
      totalValue.value = 0;
      selectedSecurityEligibility = 0;
      for(int i=0; i<actualMyCartList.length ; i++){
        if(!isAddBtnShow[i] && qtyControllers[i].text.isNotEmpty){
          totalValue.value += actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString());
          selectedSecurityEligibility = selectedSecurityEligibility! + (actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString()) * actualMyCartList[i].eligiblePercentage! / 100);
        }
      }
    });
  }

  void searchResults(String query) {
    List<Items> dummySearchList = [];
    dummySearchList.addAll(actualMyCartList);
    if (query.isNotEmpty) {
      List<Items> dummyListData = <Items>[];
      dummySearchList.forEach((item) {
        if (item.securityName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        myPledgedSecurityList.clear();
        myPledgedSecurityList.addAll(dummyListData);
      });
    } else {
      setState(() {
        myPledgedSecurityList.clear();
        myPledgedSecurityList.addAll(actualMyCartList);
      });
    }
  }

  void _handleSearchEnd() {
    setState(() {
      focusNodes.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(sellCollateralArguments.loanNo,
        style: TextStyle(color: appTheme),
      );
      _textController.clear();
      myPledgedSecurityList.clear();
      myPledgedSecurityList.addAll(actualMyCartList);
    });
  }

  void alterCheckBox(value) {
    setState(() {
      totalValue.value = 0.0;
      checkBoxValue = value;
    });
    for (var index = 0; index < myPledgedSecurityList.length; index++) {
      setState(() {
        if (value) {
          isAddBtnShow[index] = false;
          myPledgedSecurityList[index].pledgedQuantity = actualQtyList[index].toDouble();
          qtyControllers[index].text = myPledgedSecurityList[index].pledgedQuantity!.toInt().toString();
        } else {
          isAddBtnShow[index] = true;
          qtyControllers[index].text= "0";
          myPledgedSecurityList[index].pledgedQuantity = double.parse(qtyControllers[index].text);
        }
      });
    }
    sellCalculationHandling();
  }

  void requestSellCollateralOTP() async {
    String? mobile = await preferences!.getMobile();
    String email = await preferences!.getEmail();
    showDialogLoading( Strings.please_wait);
    List<SellList> sellList = [];
    for (int i = 0; i < myPledgedSecurityList.length; i++) {
      if (myPledgedSecurityList[i].pledgedQuantity != 0.0 && !isAddBtnShow[i]) {
        sellList.add(new SellList(
            isin: myPledgedSecurityList[i].isin,
            quantity: double.parse(myPledgedSecurityList[i].pledgedQuantity.toString()),
            psn : myPledgedSecurityList[i].psn));
      }
    }
    sellCollateralBloc.requestSellCollateralOTP().then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        Utility.showToastMessage(Strings.enter_otp);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = sellCollateralArguments.loanNo;
        parameter[Strings.is_for_margin_shortfall] = isMarginShortFall ? "True" : "False";
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.sell_otp_sent, parameter);

        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext bc) {
            return SellCollateralOTPScreen(sellCollateralArguments.loanNo, sellList, marginShortfallName, Strings.shares);
          },
        );
      } else if(value.errorCode == 403) {
        commonDialog(Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  void actionIconClicked() {
    setState(() {
      if (this.actionIcon.icon == Icons.search) {
        this.actionIcon = new Icon(
          Icons.close,
          color: appTheme,
          size: 25,
        );
        this.appBarTitle = new TextField(
          controller: _textController,
          focusNode: focusNodes,
          style: new TextStyle(
            color: appTheme,
          ),
          cursorColor: appTheme,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: appTheme,
                size: 25,
              ),
              hintText: Strings.search,
              focusColor: appTheme,
              border: InputBorder.none,
              hintStyle: new TextStyle(color: appTheme)),
          onChanged: (value) => searchResults(value),
        );
        focusNodes.requestFocus();
      } else {
        _handleSearchEnd();
      }
    });
  }

  addButtonClicked(int actualIndex, int index) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        setState(() {
          Get.focusScope?.unfocus();
          isAddBtnShow[actualIndex] = false;
          qtyControllers[actualIndex].text = "1";
          myPledgedSecurityList[index].pledgedQuantity = 1.0;
          sellCalculationHandling();
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

}