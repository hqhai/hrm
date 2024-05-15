import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @staySignedIn.
  ///
  /// In en, this message translates to:
  /// **'Stay signed in'**
  String get staySignedIn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @login2.
  ///
  /// In en, this message translates to:
  /// **'LOG IN'**
  String get login2;

  /// No description provided for @notAMember.
  ///
  /// In en, this message translates to:
  /// **'Not a member? '**
  String get notAMember;

  /// No description provided for @alreadyAMember.
  ///
  /// In en, this message translates to:
  /// **'Already a member?  '**
  String get alreadyAMember;

  /// No description provided for @signUpNow.
  ///
  /// In en, this message translates to:
  /// **'Sign up now'**
  String get signUpNow;

  /// No description provided for @logInNow.
  ///
  /// In en, this message translates to:
  /// **'Log in now'**
  String get logInNow;

  /// No description provided for @whatIsYourEmail.
  ///
  /// In en, this message translates to:
  /// **'What’s your email?'**
  String get whatIsYourEmail;

  /// No description provided for @chooseAUsername.
  ///
  /// In en, this message translates to:
  /// **'Choose a username'**
  String get chooseAUsername;

  /// No description provided for @chooseAPassword.
  ///
  /// In en, this message translates to:
  /// **'Choose a password'**
  String get chooseAPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @weak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get weak;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @strong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get strong;

  /// No description provided for @atLeastEightCharacters.
  ///
  /// In en, this message translates to:
  /// **'At least eight characters'**
  String get atLeastEightCharacters;

  /// No description provided for @containsANumber.
  ///
  /// In en, this message translates to:
  /// **'Contains a number'**
  String get containsANumber;

  /// No description provided for @containsACapitalLetter.
  ///
  /// In en, this message translates to:
  /// **'Contains a capital letter'**
  String get containsACapitalLetter;

  /// No description provided for @containsASymbol.
  ///
  /// In en, this message translates to:
  /// **'Contains a symbol'**
  String get containsASymbol;

  /// No description provided for @createRequest.
  ///
  /// In en, this message translates to:
  /// **'Create request'**
  String get createRequest;

  /// No description provided for @recentRequest.
  ///
  /// In en, this message translates to:
  /// **'Recent request'**
  String get recentRequest;

  /// No description provided for @requestIsProcessing.
  ///
  /// In en, this message translates to:
  /// **'Request is processing'**
  String get requestIsProcessing;

  /// No description provided for @requestProcessed.
  ///
  /// In en, this message translates to:
  /// **'Request processed'**
  String get requestProcessed;

  /// No description provided for @timeKeeping.
  ///
  /// In en, this message translates to:
  /// **'Time Keeping'**
  String get timeKeeping;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @managementRequests.
  ///
  /// In en, this message translates to:
  /// **'Management Requests'**
  String get managementRequests;

  /// No description provided for @managementRoom.
  ///
  /// In en, this message translates to:
  /// **'Management Room'**
  String get managementRoom;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title :'**
  String get title;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content :'**
  String get content;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @typeRequest.
  ///
  /// In en, this message translates to:
  /// **'Type request :'**
  String get typeRequest;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority :'**
  String get priority;

  /// No description provided for @approver.
  ///
  /// In en, this message translates to:
  /// **'Approver :'**
  String get approver;

  /// No description provided for @createOvertimeRequestIsSuccess.
  ///
  /// In en, this message translates to:
  /// **'Create overtime request is success'**
  String get createOvertimeRequestIsSuccess;

  /// No description provided for @successfullyCreatedRequest.
  ///
  /// In en, this message translates to:
  /// **'Successfully created request'**
  String get successfullyCreatedRequest;

  /// No description provided for @createRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Create request failed'**
  String get createRequestFailed;

  /// No description provided for @doYouWantToCreateARequest.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create a request?'**
  String get doYouWantToCreateARequest;

  /// No description provided for @doYouWantToDeleteTheRoom.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the room?'**
  String get doYouWantToDeleteTheRoom;

  /// No description provided for @doYouWantToUpdateARequest.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update a request?'**
  String get doYouWantToUpdateARequest;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Change password success!'**
  String get changePasswordSuccess;

  /// No description provided for @doYouWantToChangeYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Do you want to change your password?'**
  String get doYouWantToChangeYourPassword;

  /// No description provided for @leaveACommentHere.
  ///
  /// In en, this message translates to:
  /// **'Leave a comment here'**
  String get leaveACommentHere;

  /// No description provided for @previouslyAvailableSchedules.
  ///
  /// In en, this message translates to:
  /// **'Previously available schedules :'**
  String get previouslyAvailableSchedules;

  /// No description provided for @thereAreCurrentlyNoMeetingsScheduled.
  ///
  /// In en, this message translates to:
  /// **'There are currently no meetings scheduled'**
  String get thereAreCurrentlyNoMeetingsScheduled;

  /// No description provided for @scheduleAMeeting.
  ///
  /// In en, this message translates to:
  /// **'Schedule a meeting :'**
  String get scheduleAMeeting;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get update;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'CREATE'**
  String get create;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'main'**
  String get main;

  /// No description provided for @seats.
  ///
  /// In en, this message translates to:
  /// **'Seats'**
  String get seats;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project :'**
  String get project;

  /// No description provided for @task.
  ///
  /// In en, this message translates to:
  /// **'Task :'**
  String get task;

  /// No description provided for @createTime.
  ///
  /// In en, this message translates to:
  /// **'Create Time :'**
  String get createTime;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @creator.
  ///
  /// In en, this message translates to:
  /// **'Creator :'**
  String get creator;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number :'**
  String get phoneNumber;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @noteRoomLeader.
  ///
  /// In en, this message translates to:
  /// **'Note Room Leader :'**
  String get noteRoomLeader;

  /// No description provided for @noteManager.
  ///
  /// In en, this message translates to:
  /// **'Note Manager :'**
  String get noteManager;

  /// No description provided for @explanation.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get explanation;

  /// No description provided for @startDay.
  ///
  /// In en, this message translates to:
  /// **'Start Day :'**
  String get startDay;

  /// No description provided for @endDay.
  ///
  /// In en, this message translates to:
  /// **'End Day :'**
  String get endDay;

  /// No description provided for @roomName.
  ///
  /// In en, this message translates to:
  /// **'Room Name'**
  String get roomName;

  /// No description provided for @numberOfSeats.
  ///
  /// In en, this message translates to:
  /// **'Number Of Seat'**
  String get numberOfSeats;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @isApproval.
  ///
  /// In en, this message translates to:
  /// **'Is Approval'**
  String get isApproval;

  /// No description provided for @isNotApproval.
  ///
  /// In en, this message translates to:
  /// **'Is not approval'**
  String get isNotApproval;

  /// No description provided for @updateSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Update successful!'**
  String get updateSuccessful;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @unsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Unsuccessful!'**
  String get unsuccessful;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @continues.
  ///
  /// In en, this message translates to:
  /// **'Continue  '**
  String get continues;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @lateTime.
  ///
  /// In en, this message translates to:
  /// **'Late time: '**
  String get lateTime;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @errorEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Error email or password'**
  String get errorEmailOrPassword;

  /// No description provided for @endTimeMustBeAfterStartTime.
  ///
  /// In en, this message translates to:
  /// **'End time must be after start time!'**
  String get endTimeMustBeAfterStartTime;

  /// No description provided for @bookingTimeMustBeAfterCurrentTime.
  ///
  /// In en, this message translates to:
  /// **'Booking time must be after current time!'**
  String get bookingTimeMustBeAfterCurrentTime;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'days ago'**
  String get daysAgo;

  /// No description provided for @setRoom.
  ///
  /// In en, this message translates to:
  /// **'Set room'**
  String get setRoom;

  /// No description provided for @projectAndTasksCannotBeLeftBlank.
  ///
  /// In en, this message translates to:
  /// **'Project and tasks cannot be left blank'**
  String get projectAndTasksCannotBeLeftBlank;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found!'**
  String get noDataFound;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @changeStatusRequestByManager.
  ///
  /// In en, this message translates to:
  /// **'Do you want to modify status requests?'**
  String get changeStatusRequestByManager;

  /// No description provided for @doYouWantToCreateDepartment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create department?'**
  String get doYouWantToCreateDepartment;

  /// No description provided for @doYouWantToCreatePosition.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create position?'**
  String get doYouWantToCreatePosition;

  /// No description provided for @doYouWantToUpdateDepartment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update department?'**
  String get doYouWantToUpdateDepartment;

  /// No description provided for @doYouWantToUpdatePosition.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update position?'**
  String get doYouWantToUpdatePosition;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @createDepartment.
  ///
  /// In en, this message translates to:
  /// **'Create department'**
  String get createDepartment;

  /// No description provided for @createPosition.
  ///
  /// In en, this message translates to:
  /// **'Create position'**
  String get createPosition;

  /// No description provided for @updateDepartment.
  ///
  /// In en, this message translates to:
  /// **'Update department'**
  String get updateDepartment;

  /// No description provided for @updatePosition.
  ///
  /// In en, this message translates to:
  /// **'Update position'**
  String get updatePosition;

  /// No description provided for @parent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get parent;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @personnel.
  ///
  /// In en, this message translates to:
  /// **'Personnel'**
  String get personnel;

  /// No description provided for @createPersonnel.
  ///
  /// In en, this message translates to:
  /// **'Create personnel'**
  String get createPersonnel;

  /// No description provided for @updatePersonnel.
  ///
  /// In en, this message translates to:
  /// **'Update personnel'**
  String get updatePersonnel;

  /// No description provided for @createCheckInSetting.
  ///
  /// In en, this message translates to:
  /// **'Create CheckIn Setting'**
  String get createCheckInSetting;

  /// No description provided for @updateCheckInSetting.
  ///
  /// In en, this message translates to:
  /// **'Update CheckIn Setting'**
  String get updateCheckInSetting;

  /// No description provided for @doYouWantToCreatePersonnel.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create personnel?'**
  String get doYouWantToCreatePersonnel;

  /// No description provided for @doYouWantToUpdatePersonnel.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update personnel?'**
  String get doYouWantToUpdatePersonnel;

  /// No description provided for @doYouWantToCreateCheckInSetting.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create work time?'**
  String get doYouWantToCreateCheckInSetting;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// No description provided for @attendanceId.
  ///
  /// In en, this message translates to:
  /// **'Attendance Id'**
  String get attendanceId;

  /// No description provided for @morningStartTime.
  ///
  /// In en, this message translates to:
  /// **'Morning Start Time'**
  String get morningStartTime;

  /// No description provided for @morningEndTime.
  ///
  /// In en, this message translates to:
  /// **'Morning End Time'**
  String get morningEndTime;

  /// No description provided for @afternoonStartTime.
  ///
  /// In en, this message translates to:
  /// **'Afternoon Start Time'**
  String get afternoonStartTime;

  /// No description provided for @afternoonEndTime.
  ///
  /// In en, this message translates to:
  /// **'Afternoon End Time'**
  String get afternoonEndTime;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @addWorkTime.
  ///
  /// In en, this message translates to:
  /// **'Add work time'**
  String get addWorkTime;

  /// No description provided for @removeWorkTime.
  ///
  /// In en, this message translates to:
  /// **'Remove work time'**
  String get removeWorkTime;

  /// No description provided for @workingTime.
  ///
  /// In en, this message translates to:
  /// **'Working time'**
  String get workingTime;

  /// No description provided for @pleaseEnterTheEmailYouWantToRetrieveYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter the email you want to retrieve your password!'**
  String get pleaseEnterTheEmailYouWantToRetrieveYourPassword;

  /// No description provided for @newPasswordHasJustBeenSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'New password has just been sent to email'**
  String get newPasswordHasJustBeenSentToEmail;

  /// No description provided for @pleaseCheckYourEmail.
  ///
  /// In en, this message translates to:
  /// **', Please check your email.'**
  String get pleaseCheckYourEmail;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'calendar'**
  String get calendar;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @dateNote.
  ///
  /// In en, this message translates to:
  /// **'Date note'**
  String get dateNote;

  /// No description provided for @enterYourRegisteredUsernameAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered username and password'**
  String get enterYourRegisteredUsernameAndPassword;

  /// No description provided for @supportContact.
  ///
  /// In en, this message translates to:
  /// **'Support Contact'**
  String get supportContact;

  /// No description provided for @requiredDataFields.
  ///
  /// In en, this message translates to:
  /// **'Required data fields'**
  String get requiredDataFields;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @doYouWantToDeleteTheNote.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the note?'**
  String get doYouWantToDeleteTheNote;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
