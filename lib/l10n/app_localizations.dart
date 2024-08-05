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
  /// **'Title'**
  String get title;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @typeRequest.
  ///
  /// In en, this message translates to:
  /// **'Type request'**
  String get typeRequest;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @approver.
  ///
  /// In en, this message translates to:
  /// **'Approver'**
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
  /// **'Previously available schedules'**
  String get previouslyAvailableSchedules;

  /// No description provided for @thereAreCurrentlyNoMeetingsScheduled.
  ///
  /// In en, this message translates to:
  /// **'There are currently no meetings scheduled'**
  String get thereAreCurrentlyNoMeetingsScheduled;

  /// No description provided for @scheduleAMeeting.
  ///
  /// In en, this message translates to:
  /// **'Schedule a meeting'**
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
  /// **'Project'**
  String get project;

  /// No description provided for @task.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get task;

  /// No description provided for @createTime.
  ///
  /// In en, this message translates to:
  /// **'Create Time'**
  String get createTime;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @creator.
  ///
  /// In en, this message translates to:
  /// **'Creator'**
  String get creator;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
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
  /// **'Note Room Leader'**
  String get noteRoomLeader;

  /// No description provided for @noteManager.
  ///
  /// In en, this message translates to:
  /// **'Note Manager'**
  String get noteManager;

  /// No description provided for @explanation.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get explanation;

  /// No description provided for @startDay.
  ///
  /// In en, this message translates to:
  /// **'Start Day'**
  String get startDay;

  /// No description provided for @endDay.
  ///
  /// In en, this message translates to:
  /// **'End Day'**
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
  /// **'Late time'**
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

  /// No description provided for @theContentAndTitleCannotBeLeftBlank.
  ///
  /// In en, this message translates to:
  /// **'Content and title cannot be blank'**
  String get theContentAndTitleCannotBeLeftBlank;

  /// No description provided for @theNoteDateCannotBeBeforeThePresentTime.
  ///
  /// In en, this message translates to:
  /// **'The note date cannot be before the present time'**
  String get theNoteDateCannotBeBeforeThePresentTime;

  /// No description provided for @youMadeANoteOnTheDate.
  ///
  /// In en, this message translates to:
  /// **'You made a note on the date'**
  String get youMadeANoteOnTheDate;

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

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @doYouWantToDeleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete your account?'**
  String get doYouWantToDeleteYourAccount;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @userInformation.
  ///
  /// In en, this message translates to:
  /// **'User information'**
  String get userInformation;

  /// No description provided for @employeeCode.
  ///
  /// In en, this message translates to:
  /// **'Employee code'**
  String get employeeCode;

  /// No description provided for @personalEmail.
  ///
  /// In en, this message translates to:
  /// **'Personal email'**
  String get personalEmail;

  /// No description provided for @companyEmail.
  ///
  /// In en, this message translates to:
  /// **'Company Email'**
  String get companyEmail;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @branch.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get branch;

  /// No description provided for @editPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'Edit personal information'**
  String get editPersonalInformation;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @currentPasswordIsIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect!'**
  String get currentPasswordIsIncorrect;

  /// No description provided for @province.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get province;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @ward.
  ///
  /// In en, this message translates to:
  /// **'Ward'**
  String get ward;

  /// No description provided for @doYouWantToUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update profile?'**
  String get doYouWantToUpdateProfile;

  /// No description provided for @checkInOut.
  ///
  /// In en, this message translates to:
  /// **'Check-in/out'**
  String get checkInOut;

  /// No description provided for @viewAttendanceHistory.
  ///
  /// In en, this message translates to:
  /// **'View attendance history'**
  String get viewAttendanceHistory;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @administrativeTime.
  ///
  /// In en, this message translates to:
  /// **'Administrative time'**
  String get administrativeTime;

  /// No description provided for @formOfTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'Form of timekeeping'**
  String get formOfTimekeeping;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check out'**
  String get checkOut;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @timeWorking.
  ///
  /// In en, this message translates to:
  /// **'Time working'**
  String get timeWorking;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @dialogWrongPasswordA.
  ///
  /// In en, this message translates to:
  /// **'You have entered incorrect login information 5 times. Your account has been temporarily locked. Please check your email '**
  String get dialogWrongPasswordA;

  /// No description provided for @dialogWrongPasswordB.
  ///
  /// In en, this message translates to:
  /// **' to reset your password'**
  String get dialogWrongPasswordB;

  /// No description provided for @newPasswordOtherConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'New password other confirm password!'**
  String get newPasswordOtherConfirmPassword;

  /// No description provided for @notRegisteredForBiometrics.
  ///
  /// In en, this message translates to:
  /// **'You have not registered for biometrics yet, please register, please log in with username and password first!'**
  String get notRegisteredForBiometrics;

  /// No description provided for @pleaseEnterYourUsernameAndPasswordHere.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Username and password here'**
  String get pleaseEnterYourUsernameAndPasswordHere;

  /// No description provided for @youWantToSaveTheAboveAccountForBiometrics.
  ///
  /// In en, this message translates to:
  /// **'You want to save the above account for biometrics'**
  String get youWantToSaveTheAboveAccountForBiometrics;

  /// No description provided for @yourBiometricAccountIsIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Your biometric account is incorrect'**
  String get yourBiometricAccountIsIncorrect;

  /// No description provided for @youPressYourFingerHere.
  ///
  /// In en, this message translates to:
  /// **'You press your finger here'**
  String get youPressYourFingerHere;

  /// No description provided for @touchTheIconToTimeClock.
  ///
  /// In en, this message translates to:
  /// **'Touch The Icon To Time Clock'**
  String get touchTheIconToTimeClock;

  /// No description provided for @timekeepingImmediately.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping immediately'**
  String get timekeepingImmediately;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @locationServicesAreDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled.'**
  String get locationServicesAreDisabled;

  /// No description provided for @locationPermissionsAreDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are denied'**
  String get locationPermissionsAreDenied;

  /// No description provided for @locationPermissionsArePermanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are permanently denied, we cannot request permissions.'**
  String get locationPermissionsArePermanentlyDenied;

  /// No description provided for @validateToolLocation.
  ///
  /// In en, this message translates to:
  /// **'Validate tool location'**
  String get validateToolLocation;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @singleWordList.
  ///
  /// In en, this message translates to:
  /// **'Requisition list'**
  String get singleWordList;

  /// No description provided for @createANewSingleWord.
  ///
  /// In en, this message translates to:
  /// **'Create a new requisition'**
  String get createANewSingleWord;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @modification.
  ///
  /// In en, this message translates to:
  /// **'Modification request'**
  String get modification;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @expiredEdit.
  ///
  /// In en, this message translates to:
  /// **'Expired edit'**
  String get expiredEdit;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Application for leave'**
  String get leave;

  /// No description provided for @overtime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get overtime;

  /// No description provided for @vehicleDispatch.
  ///
  /// In en, this message translates to:
  /// **'Application for vehicle dispatch'**
  String get vehicleDispatch;

  /// No description provided for @postalDelivery.
  ///
  /// In en, this message translates to:
  /// **'Application for postal delivery'**
  String get postalDelivery;

  /// No description provided for @releaseOfWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Application for release of warehouse'**
  String get releaseOfWarehouse;

  /// No description provided for @stationeryOrder.
  ///
  /// In en, this message translates to:
  /// **'Stationery order form'**
  String get stationeryOrder;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'application for business trip'**
  String get business;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @primarySchool.
  ///
  /// In en, this message translates to:
  /// **'Primary school'**
  String get primarySchool;

  /// No description provided for @secondarySchool.
  ///
  /// In en, this message translates to:
  /// **'Secondary school'**
  String get secondarySchool;

  /// No description provided for @highSchool.
  ///
  /// In en, this message translates to:
  /// **'High school'**
  String get highSchool;

  /// No description provided for @vocationalSchool.
  ///
  /// In en, this message translates to:
  /// **'Vocational school'**
  String get vocationalSchool;

  /// No description provided for @college.
  ///
  /// In en, this message translates to:
  /// **'College'**
  String get college;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @masterDegree.
  ///
  /// In en, this message translates to:
  /// **'Master degree'**
  String get masterDegree;

  /// No description provided for @doctorate.
  ///
  /// In en, this message translates to:
  /// **'Doctorate'**
  String get doctorate;

  /// No description provided for @working.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get working;

  /// No description provided for @resignation.
  ///
  /// In en, this message translates to:
  /// **'Resignation'**
  String get resignation;

  /// No description provided for @aboutToStart.
  ///
  /// In en, this message translates to:
  /// **'AboutToStart'**
  String get aboutToStart;

  /// No description provided for @longTermUnpaidLeave.
  ///
  /// In en, this message translates to:
  /// **'LongTermUnpaidLeave'**
  String get longTermUnpaidLeave;

  /// No description provided for @yourRequisition.
  ///
  /// In en, this message translates to:
  /// **'Your requisition'**
  String get yourRequisition;

  /// No description provided for @requisitionYouApproval.
  ///
  /// In en, this message translates to:
  /// **'Requisition you approval'**
  String get requisitionYouApproval;

  /// No description provided for @requisitionYouFollow.
  ///
  /// In en, this message translates to:
  /// **'Requisition you follow'**
  String get requisitionYouFollow;

  /// No description provided for @applicationCode.
  ///
  /// In en, this message translates to:
  /// **'Application code'**
  String get applicationCode;

  /// No description provided for @senderInformation.
  ///
  /// In en, this message translates to:
  /// **'Sender information'**
  String get senderInformation;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @generalInformation.
  ///
  /// In en, this message translates to:
  /// **'General information'**
  String get generalInformation;

  /// No description provided for @contentOfApplication.
  ///
  /// In en, this message translates to:
  /// **'Content of application'**
  String get contentOfApplication;

  /// No description provided for @follower.
  ///
  /// In en, this message translates to:
  /// **'Follower'**
  String get follower;

  /// No description provided for @totalDays.
  ///
  /// In en, this message translates to:
  /// **'Total days'**
  String get totalDays;

  /// No description provided for @accompanyingPerson.
  ///
  /// In en, this message translates to:
  /// **'Accompanying person'**
  String get accompanyingPerson;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @workingContent.
  ///
  /// In en, this message translates to:
  /// **'Working content'**
  String get workingContent;

  /// No description provided for @attach.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get attach;

  /// No description provided for @workApplicationForm.
  ///
  /// In en, this message translates to:
  /// **'Work application form'**
  String get workApplicationForm;

  /// No description provided for @drivingTime.
  ///
  /// In en, this message translates to:
  /// **'Driving time'**
  String get drivingTime;

  /// No description provided for @drive.
  ///
  /// In en, this message translates to:
  /// **'Drive'**
  String get drive;

  /// No description provided for @carCaller.
  ///
  /// In en, this message translates to:
  /// **'Car caller'**
  String get carCaller;

  /// No description provided for @walker.
  ///
  /// In en, this message translates to:
  /// **'Walker'**
  String get walker;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @reasonForDriving.
  ///
  /// In en, this message translates to:
  /// **'Reason for driving'**
  String get reasonForDriving;

  /// No description provided for @shippingPurpose.
  ///
  /// In en, this message translates to:
  /// **'Shipping purpose'**
  String get shippingPurpose;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @reasonForExplanation.
  ///
  /// In en, this message translates to:
  /// **'Reason for explanation'**
  String get reasonForExplanation;

  /// No description provided for @detailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Detailed description'**
  String get detailedDescription;

  /// No description provided for @totalMinute.
  ///
  /// In en, this message translates to:
  /// **'Total minute'**
  String get totalMinute;

  /// No description provided for @leaveEarly.
  ///
  /// In en, this message translates to:
  /// **'Get off work early'**
  String get leaveEarly;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late timekeeping'**
  String get late;

  /// No description provided for @leaveCorrection.
  ///
  /// In en, this message translates to:
  /// **'Requisition of leave correction'**
  String get leaveCorrection;

  /// No description provided for @editTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'Edit timekeeping'**
  String get editTimekeeping;

  /// No description provided for @replaceDay.
  ///
  /// In en, this message translates to:
  /// **'replace day'**
  String get replaceDay;

  /// No description provided for @attachedFiles.
  ///
  /// In en, this message translates to:
  /// **'Attached files'**
  String get attachedFiles;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @timeHasBeenRequestedInAdvance.
  ///
  /// In en, this message translates to:
  /// **'Time has been requested in advance'**
  String get timeHasBeenRequestedInAdvance;

  /// No description provided for @workDay.
  ///
  /// In en, this message translates to:
  /// **'Work date'**
  String get workDay;

  /// No description provided for @annualLeave.
  ///
  /// In en, this message translates to:
  /// **'Annual leave'**
  String get annualLeave;

  /// No description provided for @sickLeave.
  ///
  /// In en, this message translates to:
  /// **'Sick leave'**
  String get sickLeave;

  /// No description provided for @intervalOnLeave.
  ///
  /// In en, this message translates to:
  /// **'Interval on leave'**
  String get intervalOnLeave;

  /// No description provided for @substitute.
  ///
  /// In en, this message translates to:
  /// **'The person handling the work takes over during the break'**
  String get substitute;

  /// No description provided for @pdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get pdf;

  /// No description provided for @detailedReason.
  ///
  /// In en, this message translates to:
  /// **'Detailed reason'**
  String get detailedReason;

  /// No description provided for @otherPaidLeave.
  ///
  /// In en, this message translates to:
  /// **'Other paid leave'**
  String get otherPaidLeave;

  /// No description provided for @leaveWithoutPay.
  ///
  /// In en, this message translates to:
  /// **'Leave without pay'**
  String get leaveWithoutPay;

  /// No description provided for @permissionBiometric.
  ///
  /// In en, this message translates to:
  /// **'You have not granted biometric authentication permission to the app, please grant permission!'**
  String get permissionBiometric;

  /// No description provided for @transferType.
  ///
  /// In en, this message translates to:
  /// **'Transfer Type'**
  String get transferType;

  /// No description provided for @often.
  ///
  /// In en, this message translates to:
  /// **'Often'**
  String get often;

  /// No description provided for @superSpeed.
  ///
  /// In en, this message translates to:
  /// **'Super speed'**
  String get superSpeed;

  /// No description provided for @sendingPurpose.
  ///
  /// In en, this message translates to:
  /// **'Sending purpose'**
  String get sendingPurpose;

  /// No description provided for @notePostalDelivery.
  ///
  /// In en, this message translates to:
  /// **'Note: To save costs, only use the FAST delivery service when absolutely necessary'**
  String get notePostalDelivery;

  /// No description provided for @explain.
  ///
  /// In en, this message translates to:
  /// **'Explain'**
  String get explain;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price (excluding VAT)'**
  String get unitPrice;

  /// No description provided for @numberOf.
  ///
  /// In en, this message translates to:
  /// **'Number of'**
  String get numberOf;

  /// No description provided for @intoMoney.
  ///
  /// In en, this message translates to:
  /// **'Into money'**
  String get intoMoney;

  /// No description provided for @moreOfficeProducts.
  ///
  /// In en, this message translates to:
  /// **'More office products'**
  String get moreOfficeProducts;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @pieces.
  ///
  /// In en, this message translates to:
  /// **'Pieces'**
  String get pieces;

  /// No description provided for @rolls.
  ///
  /// In en, this message translates to:
  /// **'rolls'**
  String get rolls;

  /// No description provided for @boxes.
  ///
  /// In en, this message translates to:
  /// **'boxes'**
  String get boxes;

  /// No description provided for @jars.
  ///
  /// In en, this message translates to:
  /// **'jars'**
  String get jars;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'books'**
  String get books;

  /// No description provided for @reams.
  ///
  /// In en, this message translates to:
  /// **'reams'**
  String get reams;

  /// No description provided for @volumes.
  ///
  /// In en, this message translates to:
  /// **'volumes'**
  String get volumes;

  /// No description provided for @bags.
  ///
  /// In en, this message translates to:
  /// **'Bags'**
  String get bags;

  /// No description provided for @blisters.
  ///
  /// In en, this message translates to:
  /// **'blisters'**
  String get blisters;

  /// No description provided for @pairs.
  ///
  /// In en, this message translates to:
  /// **'Pairs'**
  String get pairs;

  /// No description provided for @stationeryList.
  ///
  /// In en, this message translates to:
  /// **'Product list'**
  String get stationeryList;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @addProducts.
  ///
  /// In en, this message translates to:
  /// **'Add products'**
  String get addProducts;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @bike.
  ///
  /// In en, this message translates to:
  /// **'Bike'**
  String get bike;

  /// No description provided for @motorbike.
  ///
  /// In en, this message translates to:
  /// **'Motorbike'**
  String get motorbike;

  /// No description provided for @tram.
  ///
  /// In en, this message translates to:
  /// **'Tram'**
  String get tram;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get vehicleType;

  /// No description provided for @licensePlate.
  ///
  /// In en, this message translates to:
  /// **'License plate'**
  String get licensePlate;

  /// No description provided for @autoMaker.
  ///
  /// In en, this message translates to:
  /// **'Auto maker'**
  String get autoMaker;

  /// No description provided for @refuse.
  ///
  /// In en, this message translates to:
  /// **'Refuse'**
  String get refuse;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get process;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @overdueEdit.
  ///
  /// In en, this message translates to:
  /// **'Overdue edit'**
  String get overdueEdit;

  /// No description provided for @overdueApprove.
  ///
  /// In en, this message translates to:
  /// **'Overdue approve'**
  String get overdueApprove;

  /// No description provided for @newStatus.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newStatus;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @express.
  ///
  /// In en, this message translates to:
  /// **'Express'**
  String get express;

  /// No description provided for @sameDay.
  ///
  /// In en, this message translates to:
  /// **'Same Day'**
  String get sameDay;

  /// No description provided for @overnight.
  ///
  /// In en, this message translates to:
  /// **'Overnight'**
  String get overnight;

  /// No description provided for @twoDay.
  ///
  /// In en, this message translates to:
  /// **'Two Day'**
  String get twoDay;

  /// No description provided for @economy.
  ///
  /// In en, this message translates to:
  /// **'Economy'**
  String get economy;

  /// No description provided for @rush.
  ///
  /// In en, this message translates to:
  /// **'Rush'**
  String get rush;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @core.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get core;

  /// No description provided for @noBrowsingFlowYet.
  ///
  /// In en, this message translates to:
  /// **'No browsing flow yet'**
  String get noBrowsingFlowYet;

  /// No description provided for @cannotBeLeftBlank.
  ///
  /// In en, this message translates to:
  /// **'Cannot be left blank'**
  String get cannotBeLeftBlank;

  /// No description provided for @thereAreCurrentlyNoProducts.
  ///
  /// In en, this message translates to:
  /// **'There are currently no products'**
  String get thereAreCurrentlyNoProducts;

  /// No description provided for @removeFilter.
  ///
  /// In en, this message translates to:
  /// **'Remove filter'**
  String get removeFilter;

  /// No description provided for @paymentAfterTax.
  ///
  /// In en, this message translates to:
  /// **'Payment after tax'**
  String get paymentAfterTax;

  /// No description provided for @intoMoneyNoVAT.
  ///
  /// In en, this message translates to:
  /// **'Into money (excluding VAT)'**
  String get intoMoneyNoVAT;

  /// No description provided for @yearlyAndSeniorityLeave.
  ///
  /// In en, this message translates to:
  /// **'Yearly and seniority leave'**
  String get yearlyAndSeniorityLeave;

  /// No description provided for @otherLeave.
  ///
  /// In en, this message translates to:
  /// **'Other leave'**
  String get otherLeave;

  /// No description provided for @theStartTimeMustBeAfterTheCurrentTime.
  ///
  /// In en, this message translates to:
  /// **'The start time must be after the current time'**
  String get theStartTimeMustBeAfterTheCurrentTime;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @quantityCannotBeZero.
  ///
  /// In en, this message translates to:
  /// **'Quantity cannot be zero'**
  String get quantityCannotBeZero;

  /// No description provided for @duplicateEmail.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Email'**
  String get duplicateEmail;

  /// No description provided for @invalidParentId.
  ///
  /// In en, this message translates to:
  /// **'Invalid ParentId'**
  String get invalidParentId;

  /// No description provided for @itemNotExists.
  ///
  /// In en, this message translates to:
  /// **'Item Not Exists'**
  String get itemNotExists;

  /// No description provided for @dataInUse.
  ///
  /// In en, this message translates to:
  /// **'Data In Use'**
  String get dataInUse;

  /// No description provided for @duplicateCode.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Code'**
  String get duplicateCode;

  /// No description provided for @startDateAfterEndDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date After End Date'**
  String get startDateAfterEndDate;

  /// No description provided for @idsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Ids Empty'**
  String get idsEmpty;

  /// No description provided for @userDoesNotExist.
  ///
  /// In en, this message translates to:
  /// **'User Does Not Exist'**
  String get userDoesNotExist;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'Email In Use'**
  String get emailInUse;

  /// No description provided for @companyEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'Company Email In Use'**
  String get companyEmailInUse;

  /// No description provided for @phoneNumberInUse.
  ///
  /// In en, this message translates to:
  /// **'Phone Number In Use'**
  String get phoneNumberInUse;

  /// No description provided for @userCreationFailed.
  ///
  /// In en, this message translates to:
  /// **'User Creation Failed'**
  String get userCreationFailed;

  /// No description provided for @differentRoleUserSystem.
  ///
  /// In en, this message translates to:
  /// **'Different Role User System'**
  String get differentRoleUserSystem;

  /// No description provided for @userNameInUse.
  ///
  /// In en, this message translates to:
  /// **'UserName In Use'**
  String get userNameInUse;

  /// No description provided for @userNameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'User Name Cannot Be Empty'**
  String get userNameCannotBeEmpty;

  /// No description provided for @userNameNotFound.
  ///
  /// In en, this message translates to:
  /// **'User Name Not Found'**
  String get userNameNotFound;

  /// No description provided for @bothEmailsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Both Emails Empty'**
  String get bothEmailsEmpty;

  /// No description provided for @duplicatePassportNumber.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Passport Number'**
  String get duplicatePassportNumber;

  /// No description provided for @duplicateCitizenID.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Citizen ID'**
  String get duplicateCitizenID;

  /// No description provided for @emailCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email Cannot Be Empty'**
  String get emailCannotBeEmpty;

  /// No description provided for @onlyOneFulltimeInDepartment.
  ///
  /// In en, this message translates to:
  /// **'Only One Fulltime In Department'**
  String get onlyOneFulltimeInDepartment;

  /// No description provided for @parttimeToFulltimeOnly.
  ///
  /// In en, this message translates to:
  /// **'Parttime To Fulltime Only'**
  String get parttimeToFulltimeOnly;

  /// No description provided for @duplicateLicensePlate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate License Plate'**
  String get duplicateLicensePlate;

  /// No description provided for @duplicateTaxNumber.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Tax Number'**
  String get duplicateTaxNumber;

  /// No description provided for @duplicateBankAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Bank Account Number'**
  String get duplicateBankAccountNumber;

  /// No description provided for @timeSlotAlreadyPleaseChooseAnother.
  ///
  /// In en, this message translates to:
  /// **'Time Slot Already Please Choose Another'**
  String get timeSlotAlreadyPleaseChooseAnother;

  /// No description provided for @theNumberOfFormsCreatedHasExceededTheLimit.
  ///
  /// In en, this message translates to:
  /// **'The Number Of Forms Created Has Exceeded The Limit'**
  String get theNumberOfFormsCreatedHasExceededTheLimit;

  /// No description provided for @listOvertime.
  ///
  /// In en, this message translates to:
  /// **'List of overtime hours'**
  String get listOvertime;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get totalTime;

  /// No description provided for @yearlyLeave.
  ///
  /// In en, this message translates to:
  /// **'Yearly Leave'**
  String get yearlyLeave;

  /// No description provided for @seniorityLeave.
  ///
  /// In en, this message translates to:
  /// **'Seniority Leave'**
  String get seniorityLeave;

  /// No description provided for @weddingLeave.
  ///
  /// In en, this message translates to:
  /// **'Wedding Leave'**
  String get weddingLeave;

  /// No description provided for @mourningLeave.
  ///
  /// In en, this message translates to:
  /// **'Mourning Leave'**
  String get mourningLeave;

  /// No description provided for @homeSickLeave.
  ///
  /// In en, this message translates to:
  /// **'Home Sick Leave'**
  String get homeSickLeave;

  /// No description provided for @compensatoryLeave.
  ///
  /// In en, this message translates to:
  /// **'Compensatory leave'**
  String get compensatoryLeave;

  /// No description provided for @hospitalSickLeave.
  ///
  /// In en, this message translates to:
  /// **'Hospital Sick Leave'**
  String get hospitalSickLeave;

  /// No description provided for @maternityLeave.
  ///
  /// In en, this message translates to:
  /// **'Maternity Leave'**
  String get maternityLeave;

  /// No description provided for @revoke.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get revoke;

  /// No description provided for @leaveNumberUsed.
  ///
  /// In en, this message translates to:
  /// **'Leave number used'**
  String get leaveNumberUsed;

  /// No description provided for @leaveNumberPermission.
  ///
  /// In en, this message translates to:
  /// **'Leave number allowed'**
  String get leaveNumberPermission;

  /// No description provided for @leaveNumberRemaining.
  ///
  /// In en, this message translates to:
  /// **'Leave number remaining'**
  String get leaveNumberRemaining;

  /// No description provided for @youEarly.
  ///
  /// In en, this message translates to:
  /// **'You early'**
  String get youEarly;

  /// No description provided for @youLater.
  ///
  /// In en, this message translates to:
  /// **'You later'**
  String get youLater;

  /// No description provided for @timeKeepingList.
  ///
  /// In en, this message translates to:
  /// **'list Timekeeping'**
  String get timeKeepingList;

  /// No description provided for @listTime.
  ///
  /// In en, this message translates to:
  /// **'List time'**
  String get listTime;

  /// No description provided for @workOffset.
  ///
  /// In en, this message translates to:
  /// **'Work offset'**
  String get workOffset;

  /// No description provided for @reasonForRelease.
  ///
  /// In en, this message translates to:
  /// **'Reason for release'**
  String get reasonForRelease;

  /// No description provided for @reasonForBusinessTrip.
  ///
  /// In en, this message translates to:
  /// **'Reason for business trip'**
  String get reasonForBusinessTrip;

  /// No description provided for @unpaidLeave.
  ///
  /// In en, this message translates to:
  /// **'Unpaid leave'**
  String get unpaidLeave;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @leaveManagement.
  ///
  /// In en, this message translates to:
  /// **'Leave management'**
  String get leaveManagement;

  /// No description provided for @registerShift.
  ///
  /// In en, this message translates to:
  /// **'Register shift'**
  String get registerShift;

  /// No description provided for @listSchools.
  ///
  /// In en, this message translates to:
  /// **'List schools'**
  String get listSchools;

  /// No description provided for @overTimeLeave.
  ///
  /// In en, this message translates to:
  /// **'OverTime Leave'**
  String get overTimeLeave;

  /// No description provided for @leaveList.
  ///
  /// In en, this message translates to:
  /// **'Leave list'**
  String get leaveList;

  /// No description provided for @leaveUseHistory.
  ///
  /// In en, this message translates to:
  /// **'Leave use history'**
  String get leaveUseHistory;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get used;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @addition.
  ///
  /// In en, this message translates to:
  /// **'Addition'**
  String get addition;

  /// No description provided for @subtraction.
  ///
  /// In en, this message translates to:
  /// **'Subtraction'**
  String get subtraction;

  /// No description provided for @totalLeaveOfChanges.
  ///
  /// In en, this message translates to:
  /// **'Total leave of changes'**
  String get totalLeaveOfChanges;

  /// No description provided for @actionName.
  ///
  /// In en, this message translates to:
  /// **'Action name'**
  String get actionName;

  /// No description provided for @totalRemainingLeaveDays.
  ///
  /// In en, this message translates to:
  /// **'Total remaining days of leave'**
  String get totalRemainingLeaveDays;

  /// No description provided for @vacationPeriod.
  ///
  /// In en, this message translates to:
  /// **'Vacation period'**
  String get vacationPeriod;

  /// No description provided for @seeRequest.
  ///
  /// In en, this message translates to:
  /// **'See request'**
  String get seeRequest;

  /// No description provided for @sourceOfLeave.
  ///
  /// In en, this message translates to:
  /// **'Source of leave'**
  String get sourceOfLeave;

  /// No description provided for @doYouWantRevokeYourRequest.
  ///
  /// In en, this message translates to:
  /// **'Do you want revoke your request?'**
  String get doYouWantRevokeYourRequest;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @flow.
  ///
  /// In en, this message translates to:
  /// **'Flow'**
  String get flow;

  /// No description provided for @trackFlowProgres.
  ///
  /// In en, this message translates to:
  /// **'Track flow progress'**
  String get trackFlowProgres;

  /// No description provided for @worksheet.
  ///
  /// In en, this message translates to:
  /// **'Worksheet'**
  String get worksheet;

  /// No description provided for @actualWork.
  ///
  /// In en, this message translates to:
  /// **'Actual work'**
  String get actualWork;

  /// No description provided for @leaveWork.
  ///
  /// In en, this message translates to:
  /// **'Leave work'**
  String get leaveWork;

  /// No description provided for @holidayWork.
  ///
  /// In en, this message translates to:
  /// **'Holiday Work'**
  String get holidayWork;

  /// No description provided for @noSalaryWork.
  ///
  /// In en, this message translates to:
  /// **'No Salary Work'**
  String get noSalaryWork;

  /// No description provided for @workTime.
  ///
  /// In en, this message translates to:
  /// **'Work Time'**
  String get workTime;

  /// No description provided for @timeEarly.
  ///
  /// In en, this message translates to:
  /// **'Time Early'**
  String get timeEarly;

  /// No description provided for @timeLate.
  ///
  /// In en, this message translates to:
  /// **'Time Late'**
  String get timeLate;

  /// No description provided for @salaryWork.
  ///
  /// In en, this message translates to:
  /// **'Salary Work'**
  String get salaryWork;

  /// No description provided for @realWork.
  ///
  /// In en, this message translates to:
  /// **'Real Work'**
  String get realWork;

  /// No description provided for @seeDetails.
  ///
  /// In en, this message translates to:
  /// **'See details'**
  String get seeDetails;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On time'**
  String get onTime;

  /// No description provided for @forgotChecking.
  ///
  /// In en, this message translates to:
  /// **'Forgot checking'**
  String get forgotChecking;

  /// No description provided for @offWork.
  ///
  /// In en, this message translates to:
  /// **'Off work'**
  String get offWork;

  /// No description provided for @isRequest.
  ///
  /// In en, this message translates to:
  /// **'Is request'**
  String get isRequest;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @noAttendance.
  ///
  /// In en, this message translates to:
  /// **'No attendance'**
  String get noAttendance;

  /// No description provided for @offSet.
  ///
  /// In en, this message translates to:
  /// **'Off set'**
  String get offSet;

  /// No description provided for @timeWork.
  ///
  /// In en, this message translates to:
  /// **'Time work'**
  String get timeWork;

  /// No description provided for @detailWork.
  ///
  /// In en, this message translates to:
  /// **'Detail work'**
  String get detailWork;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @shift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get shift;

  /// No description provided for @workInDay.
  ///
  /// In en, this message translates to:
  /// **'Work in day'**
  String get workInDay;

  /// No description provided for @minutesToLate.
  ///
  /// In en, this message translates to:
  /// **'Minutes to late'**
  String get minutesToLate;

  /// No description provided for @minutesToEarly.
  ///
  /// In en, this message translates to:
  /// **'Minutes to early'**
  String get minutesToEarly;

  /// No description provided for @totalOTHours.
  ///
  /// In en, this message translates to:
  /// **'Total OT hours'**
  String get totalOTHours;

  /// No description provided for @typeOfShift.
  ///
  /// In en, this message translates to:
  /// **'Type of shift'**
  String get typeOfShift;

  /// No description provided for @oTCoefficient.
  ///
  /// In en, this message translates to:
  /// **'OT coefficient'**
  String get oTCoefficient;

  /// No description provided for @dateType.
  ///
  /// In en, this message translates to:
  /// **'Date type'**
  String get dateType;

  /// No description provided for @ot.
  ///
  /// In en, this message translates to:
  /// **'OverTime'**
  String get ot;

  /// No description provided for @totalLeaveWork.
  ///
  /// In en, this message translates to:
  /// **'Total leave work'**
  String get totalLeaveWork;

  /// No description provided for @noShiftsWork.
  ///
  /// In en, this message translates to:
  /// **'No shifts work'**
  String get noShiftsWork;

  /// No description provided for @regularDay.
  ///
  /// In en, this message translates to:
  /// **'Regular day'**
  String get regularDay;

  /// No description provided for @timeFrameOT.
  ///
  /// In en, this message translates to:
  /// **'Time frame OT'**
  String get timeFrameOT;

  /// No description provided for @timeFrame.
  ///
  /// In en, this message translates to:
  /// **'Time frame'**
  String get timeFrame;

  /// No description provided for @numberOfLate.
  ///
  /// In en, this message translates to:
  /// **'Number Of Late'**
  String get numberOfLate;

  /// No description provided for @numberOfEarly.
  ///
  /// In en, this message translates to:
  /// **'Number Of Early'**
  String get numberOfEarly;

  /// No description provided for @workOT.
  ///
  /// In en, this message translates to:
  /// **'Overtime work'**
  String get workOT;

  /// No description provided for @historyTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'History timekeeping'**
  String get historyTimekeeping;

  /// No description provided for @totalTimeWork.
  ///
  /// In en, this message translates to:
  /// **'Total Time Work'**
  String get totalTimeWork;

  /// No description provided for @totalTimeWorkCompensatory.
  ///
  /// In en, this message translates to:
  /// **'Total number of compensatory hours'**
  String get totalTimeWorkCompensatory;

  /// No description provided for @calendarWork.
  ///
  /// In en, this message translates to:
  /// **'Calendar work'**
  String get calendarWork;

  /// No description provided for @shiftManagement.
  ///
  /// In en, this message translates to:
  /// **'Shift management'**
  String get shiftManagement;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @pendingCancel.
  ///
  /// In en, this message translates to:
  /// **'Pending cancel'**
  String get pendingCancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @usable.
  ///
  /// In en, this message translates to:
  /// **'Usable'**
  String get usable;

  /// No description provided for @unusable.
  ///
  /// In en, this message translates to:
  /// **'Unusable'**
  String get unusable;

  /// No description provided for @administrativeShift.
  ///
  /// In en, this message translates to:
  /// **'Administrative shift'**
  String get administrativeShift;

  /// No description provided for @singleShift.
  ///
  /// In en, this message translates to:
  /// **'Single shift'**
  String get singleShift;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'sunday'**
  String get sunday;

  /// No description provided for @unregistered.
  ///
  /// In en, this message translates to:
  /// **'Unregistered'**
  String get unregistered;

  /// No description provided for @cancelShiftRegistration.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift registration'**
  String get cancelShiftRegistration;

  /// No description provided for @cancelShiftReceiveRegistration.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift receive registration'**
  String get cancelShiftReceiveRegistration;

  /// No description provided for @cancelShiftCancellationRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift cancellation request'**
  String get cancelShiftCancellationRequest;

  /// No description provided for @registerForShifts.
  ///
  /// In en, this message translates to:
  /// **'Register for shifts'**
  String get registerForShifts;

  /// No description provided for @reasonForCancelingRequest.
  ///
  /// In en, this message translates to:
  /// **'Reason for canceling request'**
  String get reasonForCancelingRequest;

  /// No description provided for @youDoNotHaveAShiftToday.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have a shift today!'**
  String get youDoNotHaveAShiftToday;

  /// No description provided for @distanceNotEnough.
  ///
  /// In en, this message translates to:
  /// **'Distance Not Enough'**
  String get distanceNotEnough;
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
