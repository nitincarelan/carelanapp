class AppUrl {
  static const String liveBaseURL = "https://www.carelan.in/api";
//Authentication
  static const String baseURL = liveBaseURL;
  static const String sendOtp = baseURL + "/send-otp";
  static const String viewOtp = baseURL + "/view-otp";
  static const String verify = baseURL + "/verify-otp";
  static const String getUserType = baseURL + "/get-user-type";
  static const String userRegister = baseURL + "/user-registration";
  //admin
  static const String getalluserprofile = baseURL + '/get-all-user-profile';
  static const String approve_user_profile = baseURL + '/approve-user-profile';
  static const String reject_user_profile = baseURL + '/reject-user-profile';
  //doctor
  static const String getLead = baseURL + '/get-lead';
  static const String add_patient = baseURL + '/add-lead';
  static const String leadCount = baseURL + '/leads-count';
  static const String userProfile = baseURL + '/get-user-profile';
  static const String getCompletedPayment = baseURL + '/get-completed-lead-details-doctorwise';
  //Drawer
  static const String updateAccount = baseURL + '/update-user-profile';
  static const String updateProfilePic = baseURL + '/user-profile-image-update';
  static const String getAllLeads = baseURL + '/get-leads';
  static const String getAllCity = baseURL + '/get-all-city';
  //new lead
  static const String getFollowUpLeadSergeonList = baseURL + '/get-latest-lead-count-details-doctorwise-followup';
  static const String getCareBuddyList = baseURL + '/get-all-field-worker';
  static const String updateLeadDetails = baseURL + '/update-lead-more-details';
  //open lead
  static const String assignLeadToFieldWorker = baseURL+ '/assign-leads-field-worker';
  static const String getOpenLeadSergeonList = baseURL + '/get-latest-lead-count-details-doctorwise-open';
  static const String getSigleLeadDetails = baseURL + '/get-single-lead-details';
  //Case Assigned list
  static const String caseAssignedList = baseURL + '/get-latest-lead-count-details-doctorwise-assigned';
  static const String get_patient_status = baseURL + '/get-patient-current-status';
  static const String leadCompleted = baseURL + '/complate-lead';
  //caseDone
  static const String completedLeadDetails = baseURL + '/get-completed-lead-details';
  //add hospital
  static const String getAllHospitalCityList = baseURL + '/get-all-hospital-citywise';
  static const String addHospital = baseURL + '/add-hospital';
  //Carebudy
  static const String getAssignedList = baseURL + '/get-field-worker-assigned-leads';
  static const String updatePatientRoomNo = baseURL + '/update-patient-room-no-by-lead-id';
  static const String updateOtShiftingTime = baseURL + '/update-ot-shifting-time-by-lead-id';
  static const String updateShiftToRoomTime = baseURL + '/update-shift-to-room-timing-by-lead-id';
  static const String updtaeDischargeTime = baseURL + '/update-discharge-by-lead-id';
  static const String UpdateDischargeDate = baseURL + '/update-discharge-date-by-lead-id';
  static const String updateBillAmount = baseURL + '/update-bill-amount-by-lead-id';
  static const String updateBillDoc = baseURL + '/update-bill-doc-by-lead-id';
  static const String caseDoneLeadforCB = baseURL + '/get-completed-lead-details-of-field-worker';
  //accountant
  static const String updateAccountDetail = baseURL + '/update-lead-details-by-accountant';
}