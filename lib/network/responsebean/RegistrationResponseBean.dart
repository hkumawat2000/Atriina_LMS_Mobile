// import 'package:lms/network/ModelWrapper.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
//
// class RegistrationResponse extends ModelWrapper<Message> {
//   Message? message;
//
//   RegistrationResponse({this.message});
//
//   RegistrationResponse.fromJson(Map<String, dynamic> json) {
//     message =
//     json['message'] != null ? new Message.fromJson(json['message']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.message != null) {
//       data['message'] = this.message!.toJson();
//     }
//     return data;
//   }
// }
//
// class Message {
//   int? status;
//   String? message;
//   RegisterData? data;
//
//   Message({this.status, this.message, this.data});
//
//   Message.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     try {
//       data = json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
//     } catch (e, s) {
//       printLog(s.toString());
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class RegisterData {
//   String? token;
//   Customer? customer;
//
//   RegisterData({this.token, this.customer});
//
//   RegisterData.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     customer = json['customer'] != null
//         ? new Customer.fromJson(json['customer'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     if (this.customer != null) {
//       data['customer'] = this.customer!.toJson();
//     }
//     return data;
//   }
// }
//
// class Customer {
//   String? name;
//   String? creation;
//   String? modified;
//   String? modifiedBy;
//   String? owner;
//   int? docstatus;
//   Null parent;
//   Null parentfield;
//   Null parenttype;
//   int? idx;
//   String? firstName;
//   Null middleName;
//   String? username;
//   String? lastName;
//   String? email;
//   String? phone;
//   Null fullName;
//   Null nUserTags;
//   Null nComments;
//   Null nAssign;
//   Null nLikedBy;
//   int? age;
//   Null atrinaMobile;
//   Null bankAccount;
//   String? gender;
//   Null fatherMiddleName;
//   Null pendingInterest;
//   Null alternateEmail;
//   Null nomineeDetails;
//   Null address;
//   Null pennyDrop;
//   String? martialStatus;
//   Null choiceMobile;
//   Null loanAccountNo;
//   Null crnNo;
//   Null fatherFirstName;
//   String? ckcy;
//   Null pendingPayment;
//   String? choiceKyc;
//   Null registeredDate;
//   int? aadhaarNumber;
//   Null agentId;
//   Null emergencyContact;
//   Null panNumber;
//   Null referralCode;
//   Null cbilScore;
//   String? kra;
//   String? userStatus;
//   Null fatherLastName;
//   String? accountType;
//   Null bankAccountNo;
//   Null documents;
//   Null ifscCode;
//   Null panDocument;
//   Null aadhaarDocument;
//   Null bankName;
//   int? kycUpdate;
//   int? isEmailVerified;
//   int? pledgeSecurities;
//   int? loanOpen;
//   int? registeration;
//   int? creditCheck;
//   String? user;
//
//   Customer(
//       {this.name,
//         this.creation,
//         this.modified,
//         this.modifiedBy,
//         this.owner,
//         this.docstatus,
//         this.parent,
//         this.parentfield,
//         this.parenttype,
//         this.idx,
//         this.firstName,
//         this.middleName,
//         this.username,
//         this.lastName,
//         this.email,
//         this.phone,
//         this.fullName,
//         this.nUserTags,
//         this.nComments,
//         this.nAssign,
//         this.nLikedBy,
//         this.age,
//         this.sparkMobile,
//         this.bankAccount,
//         this.gender,
//         this.fatherMiddleName,
//         this.pendingInterest,
//         this.alternateEmail,
//         this.nomineeDetails,
//         this.address,
//         this.pennyDrop,
//         this.martialStatus,
//         this.choiceMobile,
//         this.loanAccountNo,
//         this.crnNo,
//         this.fatherFirstName,
//         this.ckcy,
//         this.pendingPayment,
//         this.choiceKyc,
//         this.registeredDate,
//         this.aadhaarNumber,
//         this.agentId,
//         this.emergencyContact,
//         this.panNumber,
//         this.referralCode,
//         this.cbilScore,
//         this.kra,
//         this.userStatus,
//         this.fatherLastName,
//         this.accountType,
//         this.bankAccountNo,
//         this.documents,
//         this.ifscCode,
//         this.panDocument,
//         this.aadhaarDocument,
//         this.bankName,
//         this.kycUpdate,
//         this.isEmailVerified,
//         this.pledgeSecurities,
//         this.loanOpen,
//         this.registeration,
//         this.creditCheck,
//         this.user});
//
//   Customer.fromJson(Map<String, dynamic> json) {
//     try {
//       name = json['name'];
//       creation = json['creation'];
//       modified = json['modified'];
//       modifiedBy = json['modified_by'];
//       owner = json['owner'];
//       docstatus = json['docstatus'];
//       parent = json['parent'];
//       parentfield = json['parentfield'];
//       parenttype = json['parenttype'];
//       idx = json['idx'];
//       firstName = json['first_name'];
//       middleName = json['middle_name'];
//       username = json['username'];
//       lastName = json['last_name'];
//       email = json['email'];
//       phone = json['phone'];
//       fullName = json['full_name'];
//       nUserTags = json['_user_tags'];
//       nComments = json['_comments'];
//       nAssign = json['_assign'];
//       nLikedBy = json['_liked_by'];
//       age = json['age'];
//       sparkMobile = json['spark_mobile'];
//       bankAccount = json['bank_account'];
//       gender = json['gender'];
//       fatherMiddleName = json['father_middle_name'];
//       pendingInterest = json['pending_interest'];
//       alternateEmail = json['alternate_email'];
//       nomineeDetails = json['nominee_details'];
//       address = json['address'];
//       pennyDrop = json['penny_drop'];
//       martialStatus = json['martial_status'];
//       choiceMobile = json['choice_mobile'];
//       loanAccountNo = json['loan_account_no'];
//       crnNo = json['crn_no'];
//       fatherFirstName = json['father_first_name'];
//       ckcy = json['ckcy'];
//       pendingPayment = json['pending_payment'];
//       choiceKyc = json['choice_kyc'];
//       registeredDate = json['registered_date'];
//       aadhaarNumber = json['aadhaar_number'];
//       agentId = json['agent_id'];
//       emergencyContact = json['emergency_contact'];
//       panNumber = json['pan_number'];
//       referralCode = json['referral_code'];
//       cbilScore = json['cbil_score'];
//       kra = json['kra'];
//       userStatus = json['user_status'];
//       fatherLastName = json['father_last_name'];
//       accountType = json['account_type'];
//       bankAccountNo = json['bank_account_no'];
//       documents = json['documents'];
//       ifscCode = json['ifsc_code'];
//       panDocument = json['pan_document'];
//       aadhaarDocument = json['aadhaar_document'];
//       bankName = json['bank_name'];
//       kycUpdate = json['kyc_update'];
//       isEmailVerified = json['is_email_verified'];
//       pledgeSecurities = json['pledge_securities'];
//       loanOpen = json['loan_open'];
//       registeration = json['registeration'];
//       creditCheck = json['credit_check'];
//       user = json['user'];
//     } catch (e, s) {
//       printLog(s.toString());
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['creation'] = this.creation;
//     data['modified'] = this.modified;
//     data['modified_by'] = this.modifiedBy;
//     data['owner'] = this.owner;
//     data['docstatus'] = this.docstatus;
//     data['parent'] = this.parent;
//     data['parentfield'] = this.parentfield;
//     data['parenttype'] = this.parenttype;
//     data['idx'] = this.idx;
//     data['first_name'] = this.firstName;
//     data['middle_name'] = this.middleName;
//     data['username'] = this.username;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['full_name'] = this.fullName;
//     data['_user_tags'] = this.nUserTags;
//     data['_comments'] = this.nComments;
//     data['_assign'] = this.nAssign;
//     data['_liked_by'] = this.nLikedBy;
//     data['age'] = this.age;
//     data['spark_mobile'] = this.sparkMobile;
//     data['bank_account'] = this.bankAccount;
//     data['gender'] = this.gender;
//     data['father_middle_name'] = this.fatherMiddleName;
//     data['pending_interest'] = this.pendingInterest;
//     data['alternate_email'] = this.alternateEmail;
//     data['nominee_details'] = this.nomineeDetails;
//     data['address'] = this.address;
//     data['penny_drop'] = this.pennyDrop;
//     data['martial_status'] = this.martialStatus;
//     data['choice_mobile'] = this.choiceMobile;
//     data['loan_account_no'] = this.loanAccountNo;
//     data['crn_no'] = this.crnNo;
//     data['father_first_name'] = this.fatherFirstName;
//     data['ckcy'] = this.ckcy;
//     data['pending_payment'] = this.pendingPayment;
//     data['choice_kyc'] = this.choiceKyc;
//     data['registered_date'] = this.registeredDate;
//     data['aadhaar_number'] = this.aadhaarNumber;
//     data['agent_id'] = this.agentId;
//     data['emergency_contact'] = this.emergencyContact;
//     data['pan_number'] = this.panNumber;
//     data['referral_code'] = this.referralCode;
//     data['cbil_score'] = this.cbilScore;
//     data['kra'] = this.kra;
//     data['user_status'] = this.userStatus;
//     data['father_last_name'] = this.fatherLastName;
//     data['account_type'] = this.accountType;
//     data['bank_account_no'] = this.bankAccountNo;
//     data['documents'] = this.documents;
//     data['ifsc_code'] = this.ifscCode;
//     data['pan_document'] = this.panDocument;
//     data['aadhaar_document'] = this.aadhaarDocument;
//     data['bank_name'] = this.bankName;
//     data['kyc_update'] = this.kycUpdate;
//     data['is_email_verified'] = this.isEmailVerified;
//     data['pledge_securities'] = this.pledgeSecurities;
//     data['loan_open'] = this.loanOpen;
//     data['registeration'] = this.registeration;
//     data['credit_check'] = this.creditCheck;
//     data['user'] = this.user;
//     return data;
//   }
// }