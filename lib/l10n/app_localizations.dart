import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

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
  /// **'Stay Signed in'**
  String get staySignedIn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @notAMember.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have An Account?'**
  String get notAMember;

  /// No description provided for @alreadyAMember.
  ///
  /// In en, this message translates to:
  /// **'Already Have An Account?'**
  String get alreadyAMember;

  /// No description provided for @signUpNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get signUpNow;

  /// No description provided for @logInNow.
  ///
  /// In en, this message translates to:
  /// **'Log In Now'**
  String get logInNow;

  /// No description provided for @whatIsYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Your Email'**
  String get whatIsYourEmail;

  /// No description provided for @chooseAUsername.
  ///
  /// In en, this message translates to:
  /// **'Choose A Username'**
  String get chooseAUsername;

  /// No description provided for @chooseAPassword.
  ///
  /// In en, this message translates to:
  /// **'Choose A Password'**
  String get chooseAPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter Password'**
  String get confirmPassword;

  /// No description provided for @weak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get weak;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Average'**
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

  /// No description provided for @statusRequest.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusRequest;

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

  /// No description provided for @recentRequest.
  ///
  /// In en, this message translates to:
  /// **'Recent request'**
  String get recentRequest;

  /// No description provided for @requestIsProcessing.
  ///
  /// In en, this message translates to:
  /// **'Request in Progress'**
  String get requestIsProcessing;

  /// No description provided for @requestProcessed.
  ///
  /// In en, this message translates to:
  /// **'Request processed'**
  String get requestProcessed;

  /// No description provided for @timeKeeping.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping'**
  String get timeKeeping;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @managementRequests.
  ///
  /// In en, this message translates to:
  /// **'Requirements Management'**
  String get managementRequests;

  /// No description provided for @managementRoom.
  ///
  /// In en, this message translates to:
  /// **'Meeting Room Management'**
  String get managementRoom;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log off'**
  String get logout;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Headline/Title'**
  String get title;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Add Files'**
  String get selectFile;

  /// No description provided for @typeRequest.
  ///
  /// In en, this message translates to:
  /// **'Request Type'**
  String get typeRequest;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @approver.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approver;

  /// No description provided for @createOvertimeRequestIsSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully Created OT Request'**
  String get createOvertimeRequestIsSuccess;

  /// No description provided for @successfullyCreatedRequest.
  ///
  /// In en, this message translates to:
  /// **'Request Successfully Initiated'**
  String get successfullyCreatedRequest;

  /// No description provided for @doYouWantToCreateARequest.
  ///
  /// In en, this message translates to:
  /// **'Do you want to initiate a request?'**
  String get doYouWantToCreateARequest;

  /// No description provided for @doYouWantToDeleteTheRoom.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete a room?'**
  String get doYouWantToDeleteTheRoom;

  /// No description provided for @doYouWantToUpdateARequest.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update the request?'**
  String get doYouWantToUpdateARequest;

  /// No description provided for @doYouWantToUpdateANote.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update the note?'**
  String get doYouWantToUpdateANote;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password Change Successful!'**
  String get changePasswordSuccess;

  /// No description provided for @doYouWantToChangeYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Do you want to change your password?'**
  String get doYouWantToChangeYourPassword;

  /// No description provided for @leaveACommentHere.
  ///
  /// In en, this message translates to:
  /// **'Write Content Here'**
  String get leaveACommentHere;

  /// No description provided for @previouslyAvailableSchedules.
  ///
  /// In en, this message translates to:
  /// **'Available Schedules'**
  String get previouslyAvailableSchedules;

  /// No description provided for @thereAreCurrentlyNoMeetingsScheduled.
  ///
  /// In en, this message translates to:
  /// **'No Meetings Are Currently Scheduled'**
  String get thereAreCurrentlyNoMeetingsScheduled;

  /// No description provided for @scheduleAMeeting.
  ///
  /// In en, this message translates to:
  /// **'Schedule A Meeting'**
  String get scheduleAMeeting;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get endTime;

  /// No description provided for @startTimeH.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String startTimeH(Object a);

  /// No description provided for @endTimeH.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String endTimeH(Object a);

  /// No description provided for @startTimeD.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startTimeD;

  /// No description provided for @endTimeD.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endTimeD;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @seats.
  ///
  /// In en, this message translates to:
  /// **'Chair'**
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
  /// **'Creation Time'**
  String get createTime;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
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
  /// **'Notes'**
  String get note;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get currentPassword;

  /// No description provided for @noteRoomLeader.
  ///
  /// In en, this message translates to:
  /// **'Head\'s Note'**
  String get noteRoomLeader;

  /// No description provided for @noteManager.
  ///
  /// In en, this message translates to:
  /// **'Manager\'s note'**
  String get noteManager;

  /// No description provided for @explanation.
  ///
  /// In en, this message translates to:
  /// **'Request to amend timekeeping'**
  String get explanation;

  /// No description provided for @startDay.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDay;

  /// No description provided for @endDay.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDay;

  /// No description provided for @roomName.
  ///
  /// In en, this message translates to:
  /// **'Room Name'**
  String get roomName;

  /// No description provided for @numberOfSeats.
  ///
  /// In en, this message translates to:
  /// **'Number of Seats'**
  String get numberOfSeats;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Additional Information '**
  String get description;

  /// No description provided for @isApproval.
  ///
  /// In en, this message translates to:
  /// **'Approval Required'**
  String get isApproval;

  /// No description provided for @isNotApproval.
  ///
  /// In en, this message translates to:
  /// **'No Approval Required'**
  String get isNotApproval;

  /// No description provided for @updateSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Information Updated Successfully!'**
  String get updateSuccessful;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Successful!'**
  String get success;

  /// No description provided for @unsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Fail!'**
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
  /// **'Continue'**
  String get continues;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @lateTime.
  ///
  /// In en, this message translates to:
  /// **'Late Time'**
  String get lateTime;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book An Appointment/ Booking'**
  String get book;

  /// No description provided for @errorEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect Account Name Or Password'**
  String get errorEmailOrPassword;

  /// No description provided for @endTimeMustBeAfterStartTime.
  ///
  /// In en, this message translates to:
  /// **'The End Time Must Be After The Start Time!'**
  String get endTimeMustBeAfterStartTime;

  /// No description provided for @bookingTimeMustBeAfterCurrentTime.
  ///
  /// In en, this message translates to:
  /// **'The Booking Time Must Be After The Current Time!'**
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
  /// **'Days Ago'**
  String get daysAgo;

  /// No description provided for @setRoom.
  ///
  /// In en, this message translates to:
  /// **'Book A Room'**
  String get setRoom;

  /// No description provided for @projectAndTasksCannotBeLeftBlank.
  ///
  /// In en, this message translates to:
  /// **'Project And Task Can\'t Be Left Blank'**
  String get projectAndTasksCannotBeLeftBlank;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found!'**
  String get noDataFound;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops/Oh'**
  String get oops;

  /// No description provided for @changeStatusRequestByManager.
  ///
  /// In en, this message translates to:
  /// **'Do you want to modify the status of the requests?'**
  String get changeStatusRequestByManager;

  /// No description provided for @doYouWantToCreateDepartment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create a new department?'**
  String get doYouWantToCreateDepartment;

  /// No description provided for @doYouWantToCreatePosition.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create a new position?'**
  String get doYouWantToCreatePosition;

  /// No description provided for @doYouWantToUpdateDepartment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to edit the department information?'**
  String get doYouWantToUpdateDepartment;

  /// No description provided for @doYouWantToUpdatePosition.
  ///
  /// In en, this message translates to:
  /// **'Do you want to edit the position information?'**
  String get doYouWantToUpdatePosition;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @createDepartment.
  ///
  /// In en, this message translates to:
  /// **'Department Initialization'**
  String get createDepartment;

  /// No description provided for @createPosition.
  ///
  /// In en, this message translates to:
  /// **'Position Initialization'**
  String get createPosition;

  /// No description provided for @updateDepartment.
  ///
  /// In en, this message translates to:
  /// **'Edit Department'**
  String get updateDepartment;

  /// No description provided for @updatePosition.
  ///
  /// In en, this message translates to:
  /// **'Edit Position'**
  String get updatePosition;

  /// No description provided for @parent.
  ///
  /// In en, this message translates to:
  /// **'Parent Company'**
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
  /// **'Human Resources'**
  String get personnel;

  /// No description provided for @createPersonnel.
  ///
  /// In en, this message translates to:
  /// **'Initialize employee information'**
  String get createPersonnel;

  /// No description provided for @updatePersonnel.
  ///
  /// In en, this message translates to:
  /// **'Edit employee information'**
  String get updatePersonnel;

  /// No description provided for @createCheckInSetting.
  ///
  /// In en, this message translates to:
  /// **'Initialize work hours information'**
  String get createCheckInSetting;

  /// No description provided for @updateCheckInSetting.
  ///
  /// In en, this message translates to:
  /// **'Edit work hours information'**
  String get updateCheckInSetting;

  /// No description provided for @doYouWantToCreatePersonnel.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create a new employee?'**
  String get doYouWantToCreatePersonnel;

  /// No description provided for @doYouWantToUpdatePersonnel.
  ///
  /// In en, this message translates to:
  /// **'Do you want to edit employee information?'**
  String get doYouWantToUpdatePersonnel;

  /// No description provided for @doYouWantToCreateCheckInSetting.
  ///
  /// In en, this message translates to:
  /// **'Do you want to create a new work schedule?'**
  String get doYouWantToCreateCheckInSetting;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// No description provided for @attendanceId.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping code'**
  String get attendanceId;

  /// No description provided for @morningStartTime.
  ///
  /// In en, this message translates to:
  /// **'Morning shift start time'**
  String get morningStartTime;

  /// No description provided for @morningEndTime.
  ///
  /// In en, this message translates to:
  /// **'Morning shift end time'**
  String get morningEndTime;

  /// No description provided for @afternoonStartTime.
  ///
  /// In en, this message translates to:
  /// **'Afternoon shift start time'**
  String get afternoonStartTime;

  /// No description provided for @afternoonEndTime.
  ///
  /// In en, this message translates to:
  /// **'Afternoon shift end time'**
  String get afternoonEndTime;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @addWorkTime.
  ///
  /// In en, this message translates to:
  /// **'Add work hours'**
  String get addWorkTime;

  /// No description provided for @removeWorkTime.
  ///
  /// In en, this message translates to:
  /// **'Cancel work hours'**
  String get removeWorkTime;

  /// No description provided for @workingTime.
  ///
  /// In en, this message translates to:
  /// **'Working hours'**
  String get workingTime;

  /// No description provided for @pleaseEnterTheEmailYouWantToRetrieveYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter the email to retrieve your password!'**
  String get pleaseEnterTheEmailYouWantToRetrieveYourPassword;

  /// No description provided for @newPasswordHasJustBeenSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'A new password has been sent to your email'**
  String get newPasswordHasJustBeenSentToEmail;

  /// No description provided for @pleaseCheckYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please check your email.'**
  String get pleaseCheckYourEmail;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
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

  /// No description provided for @dateNote.
  ///
  /// In en, this message translates to:
  /// **'Note date'**
  String get dateNote;

  /// No description provided for @enterYourRegisteredUsernameAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the registered username and password'**
  String get enterYourRegisteredUsernameAndPassword;

  /// No description provided for @supportContact.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get supportContact;

  /// No description provided for @theContentAndTitleCannotBeLeftBlank.
  ///
  /// In en, this message translates to:
  /// **'Content and subject cannot be empty'**
  String get theContentAndTitleCannotBeLeftBlank;

  /// No description provided for @theNoteDateCannotBeBeforeThePresentTime.
  ///
  /// In en, this message translates to:
  /// **'Note date cannot be before the current time'**
  String get theNoteDateCannotBeBeforeThePresentTime;

  /// No description provided for @youMadeANoteOnTheDate.
  ///
  /// In en, this message translates to:
  /// **'You have noted on the date'**
  String get youMadeANoteOnTheDate;

  /// No description provided for @requiredDataFields.
  ///
  /// In en, this message translates to:
  /// **'All fields are required'**
  String get requiredDataFields;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @doYouWantToDeleteTheNote.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this note?'**
  String get doYouWantToDeleteTheNote;

  /// No description provided for @doYouWantToDeleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this account?'**
  String get doYouWantToDeleteYourAccount;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @userInformation.
  ///
  /// In en, this message translates to:
  /// **'User profile'**
  String get userInformation;

  /// No description provided for @employeeCode.
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get employeeCode;

  /// No description provided for @personalEmail.
  ///
  /// In en, this message translates to:
  /// **'Personal email'**
  String get personalEmail;

  /// No description provided for @companyEmail.
  ///
  /// In en, this message translates to:
  /// **'Company email'**
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
  /// **'Settings'**
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
  /// **'Do you want to edit personal information?'**
  String get doYouWantToUpdateProfile;

  /// No description provided for @checkInOut.
  ///
  /// In en, this message translates to:
  /// **'Check-in/out'**
  String get checkInOut;

  /// No description provided for @viewAttendanceHistory.
  ///
  /// In en, this message translates to:
  /// **'View timekeeping history'**
  String get viewAttendanceHistory;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @administrativeTime.
  ///
  /// In en, this message translates to:
  /// **'Working hours'**
  String get administrativeTime;

  /// No description provided for @formOfTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping method'**
  String get formOfTimekeeping;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Clock in'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Clock out'**
  String get checkOut;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @timeWorking.
  ///
  /// In en, this message translates to:
  /// **'Work shift'**
  String get timeWorking;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get date;

  /// No description provided for @dialogWrongPasswordA.
  ///
  /// In en, this message translates to:
  /// **'You have entered incorrect login information 5 times. Your account has been temporarily locked. Please contact HR to reset your password.'**
  String get dialogWrongPasswordA;

  /// No description provided for @dialogWrongPasswordB.
  ///
  /// In en, this message translates to:
  /// **'to reset password'**
  String get dialogWrongPasswordB;

  /// No description provided for @newPasswordOtherConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'New password does not match the confirmation password!'**
  String get newPasswordOtherConfirmPassword;

  /// No description provided for @notRegisteredForBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Please log in to the app to activate biometric authentication.'**
  String get notRegisteredForBiometrics;

  /// No description provided for @pleaseEnterYourUsernameAndPasswordHere.
  ///
  /// In en, this message translates to:
  /// **'Enter your username and password here'**
  String get pleaseEnterYourUsernameAndPasswordHere;

  /// No description provided for @youWantToSaveTheAboveAccountForBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save this account for biometric login?'**
  String get youWantToSaveTheAboveAccountForBiometrics;

  /// No description provided for @yourBiometricAccountIsIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Your biometric account is incorrect'**
  String get yourBiometricAccountIsIncorrect;

  /// No description provided for @youPressYourFingerHere.
  ///
  /// In en, this message translates to:
  /// **'Press your finger here'**
  String get youPressYourFingerHere;

  /// No description provided for @touchTheIconToTimeClock.
  ///
  /// In en, this message translates to:
  /// **'Tap the icon to clock in'**
  String get touchTheIconToTimeClock;

  /// No description provided for @timekeepingImmediately.
  ///
  /// In en, this message translates to:
  /// **'Clock in now'**
  String get timekeepingImmediately;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @locationServicesAreDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled'**
  String get locationServicesAreDisabled;

  /// No description provided for @locationPermissionsAreDenied.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get locationPermissionsAreDenied;

  /// No description provided for @locationPermissionsArePermanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'Access denied, we are unable to request location access'**
  String get locationPermissionsArePermanentlyDenied;

  /// No description provided for @validateToolLocation.
  ///
  /// In en, this message translates to:
  /// **'Authenticate timekeeping location'**
  String get validateToolLocation;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @singleWordList.
  ///
  /// In en, this message translates to:
  /// **'Request list'**
  String get singleWordList;

  /// No description provided for @createANewSingleWord.
  ///
  /// In en, this message translates to:
  /// **'Create a new request'**
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
  /// **'Pending approval'**
  String get pending;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @modification.
  ///
  /// In en, this message translates to:
  /// **'Request revision'**
  String get modification;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
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
  /// **'Revision overdue'**
  String get expiredEdit;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get expired;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave request'**
  String get leave;

  /// No description provided for @overtime.
  ///
  /// In en, this message translates to:
  /// **'Overtime request'**
  String get overtime;

  /// No description provided for @overtimeCreate.
  ///
  /// In en, this message translates to:
  /// **'Create overtime request'**
  String get overtimeCreate;

  /// No description provided for @vehicleDispatch.
  ///
  /// In en, this message translates to:
  /// **'Vehicle request form'**
  String get vehicleDispatch;

  /// No description provided for @vehicleDispatchCreate.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Request Form Initialization'**
  String get vehicleDispatchCreate;

  /// No description provided for @postalDelivery.
  ///
  /// In en, this message translates to:
  /// **'Postal delivery request form'**
  String get postalDelivery;

  /// No description provided for @releaseOfWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse release request form'**
  String get releaseOfWarehouse;

  /// No description provided for @releaseOfWarehouseCreate.
  ///
  /// In en, this message translates to:
  /// **'Create warehouse release request form'**
  String get releaseOfWarehouseCreate;

  /// No description provided for @stationeryOrder.
  ///
  /// In en, this message translates to:
  /// **'Stationery order form'**
  String get stationeryOrder;

  /// No description provided for @stationeryOrderCreate.
  ///
  /// In en, this message translates to:
  /// **'Create stationery order form'**
  String get stationeryOrderCreate;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business trip request'**
  String get business;

  /// No description provided for @businessCreate.
  ///
  /// In en, this message translates to:
  /// **'Create business trip request'**
  String get businessCreate;

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
  /// **'Middle school'**
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
  /// **'Master\'s degree'**
  String get masterDegree;

  /// No description provided for @doctorate.
  ///
  /// In en, this message translates to:
  /// **'Doctorate'**
  String get doctorate;

  /// No description provided for @working.
  ///
  /// In en, this message translates to:
  /// **'Currently working'**
  String get working;

  /// No description provided for @resignation.
  ///
  /// In en, this message translates to:
  /// **'Resigned'**
  String get resignation;

  /// No description provided for @aboutToStart.
  ///
  /// In en, this message translates to:
  /// **'Starting soon'**
  String get aboutToStart;

  /// No description provided for @longTermUnpaidLeave.
  ///
  /// In en, this message translates to:
  /// **'Long-term unpaid leave'**
  String get longTermUnpaidLeave;

  /// No description provided for @yourRequisition.
  ///
  /// In en, this message translates to:
  /// **'Your requests'**
  String get yourRequisition;

  /// No description provided for @requisitionYouApproval.
  ///
  /// In en, this message translates to:
  /// **'Requests you approved'**
  String get requisitionYouApproval;

  /// No description provided for @requisitionYouFollow.
  ///
  /// In en, this message translates to:
  /// **'Requests you are following'**
  String get requisitionYouFollow;

  /// No description provided for @applicationCode.
  ///
  /// In en, this message translates to:
  /// **'Request code'**
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
  /// **'Request details'**
  String get contentOfApplication;

  /// No description provided for @follower.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
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
  /// **'Business trip details'**
  String get workingContent;

  /// No description provided for @attach.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attach;

  /// No description provided for @workApplicationForm.
  ///
  /// In en, this message translates to:
  /// **'Request template'**
  String get workApplicationForm;

  /// No description provided for @drivingTime.
  ///
  /// In en, this message translates to:
  /// **'Vehicle scheduling time'**
  String get drivingTime;

  /// No description provided for @drive.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get drive;

  /// No description provided for @carCaller.
  ///
  /// In en, this message translates to:
  /// **'Vehicle dispatcher'**
  String get carCaller;

  /// No description provided for @walker.
  ///
  /// In en, this message translates to:
  /// **'Passenger'**
  String get walker;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Itinerary'**
  String get schedule;

  /// No description provided for @reasonForDriving.
  ///
  /// In en, this message translates to:
  /// **'Reason for vehicle dispatch'**
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

  /// No description provided for @reasonCreate.
  ///
  /// In en, this message translates to:
  /// **'Reason for Creating Request'**
  String get reasonCreate;

  /// No description provided for @reasonForExplanation.
  ///
  /// In en, this message translates to:
  /// **'Reason for Explanation'**
  String get reasonForExplanation;

  /// No description provided for @detailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Detailed description'**
  String get detailedDescription;

  /// No description provided for @totalMinute.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get totalMinute;

  /// No description provided for @leaveEarly.
  ///
  /// In en, this message translates to:
  /// **'Request to leave early'**
  String get leaveEarly;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Request to arrive late'**
  String get late;

  /// No description provided for @leaveCorrection.
  ///
  /// In en, this message translates to:
  /// **'Request to modify leave'**
  String get leaveCorrection;

  /// No description provided for @editTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'Request to modify timekeeping'**
  String get editTimekeeping;

  /// No description provided for @replaceDay.
  ///
  /// In en, this message translates to:
  /// **'Make-up workday'**
  String get replaceDay;

  /// No description provided for @attachedFiles.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get attachedFiles;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @timeHasBeenRequestedInAdvance.
  ///
  /// In en, this message translates to:
  /// **'A request already exists for the selected time, please choose again'**
  String get timeHasBeenRequestedInAdvance;

  /// No description provided for @workDay.
  ///
  /// In en, this message translates to:
  /// **'Workdays'**
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
  /// **'Leave duration'**
  String get intervalOnLeave;

  /// No description provided for @substitute.
  ///
  /// In en, this message translates to:
  /// **'Work replacement during leave'**
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
  /// **'Unpaid leave'**
  String get leaveWithoutPay;

  /// No description provided for @permissionBiometric.
  ///
  /// In en, this message translates to:
  /// **'You have not granted biometric authentication permissions to the app, please grant permission!'**
  String get permissionBiometric;

  /// No description provided for @transferType.
  ///
  /// In en, this message translates to:
  /// **'Delivery type'**
  String get transferType;

  /// No description provided for @often.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get often;

  /// No description provided for @superSpeed.
  ///
  /// In en, this message translates to:
  /// **'Express'**
  String get superSpeed;

  /// No description provided for @sendingPurpose.
  ///
  /// In en, this message translates to:
  /// **'Shipping purpose'**
  String get sendingPurpose;

  /// No description provided for @explain.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get explain;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price (before VAT)'**
  String get unitPrice;

  /// No description provided for @numberOf.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get numberOf;

  /// No description provided for @intoMoney.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get intoMoney;

  /// No description provided for @moreOfficeProducts.
  ///
  /// In en, this message translates to:
  /// **'Add stationery'**
  String get moreOfficeProducts;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit of Measure'**
  String get unit;

  /// No description provided for @pieces.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get pieces;

  /// No description provided for @rolls.
  ///
  /// In en, this message translates to:
  /// **'Roll'**
  String get rolls;

  /// No description provided for @boxes.
  ///
  /// In en, this message translates to:
  /// **'Box'**
  String get boxes;

  /// No description provided for @jars.
  ///
  /// In en, this message translates to:
  /// **'Bottle'**
  String get jars;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Notebook'**
  String get books;

  /// No description provided for @reams.
  ///
  /// In en, this message translates to:
  /// **'Ream'**
  String get reams;

  /// No description provided for @volumes.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get volumes;

  /// No description provided for @bags.
  ///
  /// In en, this message translates to:
  /// **'Bag'**
  String get bags;

  /// No description provided for @blisters.
  ///
  /// In en, this message translates to:
  /// **'Blister pack'**
  String get blisters;

  /// No description provided for @pairs.
  ///
  /// In en, this message translates to:
  /// **'Pair'**
  String get pairs;

  /// No description provided for @stationeryList.
  ///
  /// In en, this message translates to:
  /// **'Product List'**
  String get stationeryList;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @addProducts.
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get addProducts;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @bike.
  ///
  /// In en, this message translates to:
  /// **'Bicycle'**
  String get bike;

  /// No description provided for @motorbike.
  ///
  /// In en, this message translates to:
  /// **'Motorbike'**
  String get motorbike;

  /// No description provided for @tram.
  ///
  /// In en, this message translates to:
  /// **'Electric bike'**
  String get tram;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get vehicleType;

  /// No description provided for @licensePlate.
  ///
  /// In en, this message translates to:
  /// **'License plate number'**
  String get licensePlate;

  /// No description provided for @autoMaker.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get autoMaker;

  /// No description provided for @refuse.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get refuse;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Pending approval'**
  String get process;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Request revision'**
  String get edit;

  /// No description provided for @overdueEdit.
  ///
  /// In en, this message translates to:
  /// **'Revision overdue'**
  String get overdueEdit;

  /// No description provided for @overdueApprove.
  ///
  /// In en, this message translates to:
  /// **'Approval overdue'**
  String get overdueApprove;

  /// No description provided for @newStatus.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newStatus;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard shipping'**
  String get standard;

  /// No description provided for @express.
  ///
  /// In en, this message translates to:
  /// **'Express shipping'**
  String get express;

  /// No description provided for @sameDay.
  ///
  /// In en, this message translates to:
  /// **'Same-day delivery'**
  String get sameDay;

  /// No description provided for @overnight.
  ///
  /// In en, this message translates to:
  /// **'Overnight delivery'**
  String get overnight;

  /// No description provided for @twoDay.
  ///
  /// In en, this message translates to:
  /// **'Two-day delivery'**
  String get twoDay;

  /// No description provided for @economy.
  ///
  /// In en, this message translates to:
  /// **'Economy shipping'**
  String get economy;

  /// No description provided for @rush.
  ///
  /// In en, this message translates to:
  /// **'Rush shipping'**
  String get rush;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled delivery'**
  String get scheduled;

  /// No description provided for @core.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get core;

  /// No description provided for @noBrowsingFlowYet.
  ///
  /// In en, this message translates to:
  /// **'No approval flow'**
  String get noBrowsingFlowYet;

  /// No description provided for @cannotBeLeftBlank.
  ///
  /// In en, this message translates to:
  /// **'Cannot be empty'**
  String get cannotBeLeftBlank;

  /// No description provided for @thereAreCurrentlyNoProducts.
  ///
  /// In en, this message translates to:
  /// **'No products available at the moment'**
  String get thereAreCurrentlyNoProducts;

  /// No description provided for @removeFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get removeFilter;

  /// No description provided for @paymentAfterTax.
  ///
  /// In en, this message translates to:
  /// **'Payment after tax'**
  String get paymentAfterTax;

  /// No description provided for @intoMoneyNoVAT.
  ///
  /// In en, this message translates to:
  /// **'Total before VAT'**
  String get intoMoneyNoVAT;

  /// No description provided for @yearlyAndSeniorityLeave.
  ///
  /// In en, this message translates to:
  /// **'Annual leave and seniority leave'**
  String get yearlyAndSeniorityLeave;

  /// No description provided for @otherLeave.
  ///
  /// In en, this message translates to:
  /// **'Other leave'**
  String get otherLeave;

  /// No description provided for @horizontalCalendar.
  ///
  /// In en, this message translates to:
  /// **'Horizontal calendar'**
  String get horizontalCalendar;

  /// No description provided for @verticalCalendar.
  ///
  /// In en, this message translates to:
  /// **'Vertical calendar'**
  String get verticalCalendar;

  /// No description provided for @unpaidLeave.
  ///
  /// In en, this message translates to:
  /// **'Company unpaid leave'**
  String get unpaidLeave;

  /// No description provided for @theStartTimeMustBeAfterTheCurrentTime.
  ///
  /// In en, this message translates to:
  /// **'Start time must be after the current time'**
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
  /// **'Duplicate email'**
  String get duplicateEmail;

  /// No description provided for @invalidParentId.
  ///
  /// In en, this message translates to:
  /// **'Invalid object ID'**
  String get invalidParentId;

  /// No description provided for @itemNotExists.
  ///
  /// In en, this message translates to:
  /// **'Object does not exist'**
  String get itemNotExists;

  /// No description provided for @dataInUse.
  ///
  /// In en, this message translates to:
  /// **'Data is in use'**
  String get dataInUse;

  /// No description provided for @duplicateCode.
  ///
  /// In en, this message translates to:
  /// **'Duplicate code'**
  String get duplicateCode;

  /// No description provided for @startDateAfterEndDate.
  ///
  /// In en, this message translates to:
  /// **'Start date after end date'**
  String get startDateAfterEndDate;

  /// No description provided for @idsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty IDs'**
  String get idsEmpty;

  /// No description provided for @userDoesNotExist.
  ///
  /// In en, this message translates to:
  /// **'User does not exist'**
  String get userDoesNotExist;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'Email is already in use'**
  String get emailInUse;

  /// No description provided for @companyEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'Company email is already in use'**
  String get companyEmailInUse;

  /// No description provided for @phoneNumberInUse.
  ///
  /// In en, this message translates to:
  /// **'Phone number is already in use'**
  String get phoneNumberInUse;

  /// No description provided for @userCreationFailed.
  ///
  /// In en, this message translates to:
  /// **'User creation failed'**
  String get userCreationFailed;

  /// No description provided for @differentRoleUserSystem.
  ///
  /// In en, this message translates to:
  /// **'User system with a different role'**
  String get differentRoleUserSystem;

  /// No description provided for @userNameInUse.
  ///
  /// In en, this message translates to:
  /// **'Username is already in use'**
  String get userNameInUse;

  /// No description provided for @userNameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Username cannot be empty'**
  String get userNameCannotBeEmpty;

  /// No description provided for @userNameNotFound.
  ///
  /// In en, this message translates to:
  /// **'Username does not exist'**
  String get userNameNotFound;

  /// No description provided for @bothEmailsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Both personal and company emails are empty'**
  String get bothEmailsEmpty;

  /// No description provided for @duplicatePassportNumber.
  ///
  /// In en, this message translates to:
  /// **'Duplicate passport number'**
  String get duplicatePassportNumber;

  /// No description provided for @duplicateCitizenID.
  ///
  /// In en, this message translates to:
  /// **'Duplicate ID/CCCD number'**
  String get duplicateCitizenID;

  /// No description provided for @emailCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get emailCannotBeEmpty;

  /// No description provided for @onlyOneFulltimeInDepartment.
  ///
  /// In en, this message translates to:
  /// **'Only one full-time employee per department is allowed'**
  String get onlyOneFulltimeInDepartment;

  /// No description provided for @parttimeToFulltimeOnly.
  ///
  /// In en, this message translates to:
  /// **'Can only transition from part-time to full-time'**
  String get parttimeToFulltimeOnly;

  /// No description provided for @duplicateLicensePlate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate license plate number'**
  String get duplicateLicensePlate;

  /// No description provided for @duplicateTaxNumber.
  ///
  /// In en, this message translates to:
  /// **'Duplicate tax code'**
  String get duplicateTaxNumber;

  /// No description provided for @duplicateBankAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Duplicate bank account number'**
  String get duplicateBankAccountNumber;

  /// No description provided for @listOvertime.
  ///
  /// In en, this message translates to:
  /// **'Overtime hours record'**
  String get listOvertime;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get totalTime;

  /// No description provided for @yearlyLeave.
  ///
  /// In en, this message translates to:
  /// **'Annual leave'**
  String get yearlyLeave;

  /// No description provided for @seniorityLeave.
  ///
  /// In en, this message translates to:
  /// **'Seniority leave'**
  String get seniorityLeave;

  /// No description provided for @compensatoryLeave.
  ///
  /// In en, this message translates to:
  /// **'Compensatory leave'**
  String get compensatoryLeave;

  /// No description provided for @weddingLeave.
  ///
  /// In en, this message translates to:
  /// **'Marriage leave'**
  String get weddingLeave;

  /// No description provided for @mourningLeave.
  ///
  /// In en, this message translates to:
  /// **'Bereavement leave'**
  String get mourningLeave;

  /// No description provided for @homeSickLeave.
  ///
  /// In en, this message translates to:
  /// **'Sick leave (home)'**
  String get homeSickLeave;

  /// No description provided for @hospitalSickLeave.
  ///
  /// In en, this message translates to:
  /// **'Sick leave (hospital)'**
  String get hospitalSickLeave;

  /// No description provided for @maternityLeave.
  ///
  /// In en, this message translates to:
  /// **'Maternity leave'**
  String get maternityLeave;

  /// No description provided for @revoke.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get revoke;

  /// No description provided for @leaveNumberUsed.
  ///
  /// In en, this message translates to:
  /// **'Maximum leave days'**
  String get leaveNumberUsed;

  /// No description provided for @leaveNumberPermission.
  ///
  /// In en, this message translates to:
  /// **'Leave days taken'**
  String get leaveNumberPermission;

  /// No description provided for @leaveNumberRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining leave days'**
  String get leaveNumberRemaining;

  /// No description provided for @leaveNumberUsedH.
  ///
  /// In en, this message translates to:
  /// **'Maximum leave hours taken'**
  String get leaveNumberUsedH;

  /// No description provided for @leaveNumberPermissionH.
  ///
  /// In en, this message translates to:
  /// **'Leave hours'**
  String get leaveNumberPermissionH;

  /// No description provided for @leaveNumberRemainingH.
  ///
  /// In en, this message translates to:
  /// **'Remaining leave hours'**
  String get leaveNumberRemainingH;

  /// No description provided for @youEarly.
  ///
  /// In en, this message translates to:
  /// **'Early departure'**
  String get youEarly;

  /// No description provided for @youLater.
  ///
  /// In en, this message translates to:
  /// **'Late arrival'**
  String get youLater;

  /// No description provided for @timeKeepingList.
  ///
  /// In en, this message translates to:
  /// **'Time records'**
  String get timeKeepingList;

  /// No description provided for @listTime.
  ///
  /// In en, this message translates to:
  /// **'Time records'**
  String get listTime;

  /// No description provided for @workOffset.
  ///
  /// In en, this message translates to:
  /// **'Make-up work'**
  String get workOffset;

  /// No description provided for @reasonForRelease.
  ///
  /// In en, this message translates to:
  /// **'Reason for goods issuance'**
  String get reasonForRelease;

  /// No description provided for @reasonForBusinessTrip.
  ///
  /// In en, this message translates to:
  /// **'Reason for business trip'**
  String get reasonForBusinessTrip;

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
  /// **'Register work schedule'**
  String get registerShift;

  /// No description provided for @listSchools.
  ///
  /// In en, this message translates to:
  /// **'School list'**
  String get listSchools;

  /// No description provided for @overTimeLeave.
  ///
  /// In en, this message translates to:
  /// **'OT compensatory leave'**
  String get overTimeLeave;

  /// No description provided for @leaveList.
  ///
  /// In en, this message translates to:
  /// **'Leave records'**
  String get leaveList;

  /// No description provided for @leaveUseHistory.
  ///
  /// In en, this message translates to:
  /// **'Leave history'**
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
  /// **'Add'**
  String get addition;

  /// No description provided for @subtraction.
  ///
  /// In en, this message translates to:
  /// **'Subtract'**
  String get subtraction;

  /// No description provided for @totalLeaveOfChanges.
  ///
  /// In en, this message translates to:
  /// **'Total leave changes'**
  String get totalLeaveOfChanges;

  /// No description provided for @actionName.
  ///
  /// In en, this message translates to:
  /// **'Action name'**
  String get actionName;

  /// No description provided for @totalRemainingLeaveDays.
  ///
  /// In en, this message translates to:
  /// **'Total remaining leave days'**
  String get totalRemainingLeaveDays;

  /// No description provided for @vacationPeriod.
  ///
  /// In en, this message translates to:
  /// **'Leave request time'**
  String get vacationPeriod;

  /// No description provided for @seeRequest.
  ///
  /// In en, this message translates to:
  /// **'View request'**
  String get seeRequest;

  /// No description provided for @sourceOfLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave source'**
  String get sourceOfLeave;

  /// No description provided for @doYouWantRevokeYourRequest.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel to request?'**
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
  /// **'Approval Flow'**
  String get flow;

  /// No description provided for @trackFlowProgres.
  ///
  /// In en, this message translates to:
  /// **'Track approval progress'**
  String get trackFlowProgres;

  /// No description provided for @youDoNotHaveAShiftToday.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have a shift today!'**
  String get youDoNotHaveAShiftToday;

  /// No description provided for @worksheet.
  ///
  /// In en, this message translates to:
  /// **'Timesheet'**
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

  /// No description provided for @salaryWork.
  ///
  /// In en, this message translates to:
  /// **'Paid work'**
  String get salaryWork;

  /// No description provided for @noSalaryWork.
  ///
  /// In en, this message translates to:
  /// **'Unpaid work'**
  String get noSalaryWork;

  /// No description provided for @workTime.
  ///
  /// In en, this message translates to:
  /// **'Work hours'**
  String get workTime;

  /// No description provided for @timeEarly.
  ///
  /// In en, this message translates to:
  /// **'Early departure time'**
  String get timeEarly;

  /// No description provided for @timeLate.
  ///
  /// In en, this message translates to:
  /// **'Late arrival time'**
  String get timeLate;

  /// No description provided for @realWork.
  ///
  /// In en, this message translates to:
  /// **'Actual Work'**
  String get realWork;

  /// No description provided for @seeDetails.
  ///
  /// In en, this message translates to:
  /// **'See details'**
  String get seeDetails;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On time clock-in'**
  String get onTime;

  /// No description provided for @forgotChecking.
  ///
  /// In en, this message translates to:
  /// **'Missed clock-in'**
  String get forgotChecking;

  /// No description provided for @offWork.
  ///
  /// In en, this message translates to:
  /// **'No shift'**
  String get offWork;

  /// No description provided for @isRequest.
  ///
  /// In en, this message translates to:
  /// **'Request exists'**
  String get isRequest;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @noAttendance.
  ///
  /// In en, this message translates to:
  /// **'No attendance required'**
  String get noAttendance;

  /// No description provided for @offSet.
  ///
  /// In en, this message translates to:
  /// **'Compensatory work'**
  String get offSet;

  /// No description provided for @timeWork.
  ///
  /// In en, this message translates to:
  /// **'Work hours'**
  String get timeWork;

  /// No description provided for @detailWork.
  ///
  /// In en, this message translates to:
  /// **'Detailed work'**
  String get detailWork;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary of work'**
  String get summary;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Leave requests'**
  String get request;

  /// No description provided for @shift.
  ///
  /// In en, this message translates to:
  /// **'Work shift'**
  String get shift;

  /// No description provided for @workInDay.
  ///
  /// In en, this message translates to:
  /// **'Daily attendance record'**
  String get workInDay;

  /// No description provided for @minutesToLate.
  ///
  /// In en, this message translates to:
  /// **'Minutes late'**
  String get minutesToLate;

  /// No description provided for @minutesToEarly.
  ///
  /// In en, this message translates to:
  /// **'Minutes left early'**
  String get minutesToEarly;

  /// No description provided for @totalOTHours.
  ///
  /// In en, this message translates to:
  /// **'Total OT hours'**
  String get totalOTHours;

  /// No description provided for @typeOfShift.
  ///
  /// In en, this message translates to:
  /// **'Work shift type'**
  String get typeOfShift;

  /// No description provided for @oTCoefficient.
  ///
  /// In en, this message translates to:
  /// **'OT coefficient'**
  String get oTCoefficient;

  /// No description provided for @dateType.
  ///
  /// In en, this message translates to:
  /// **'Day type'**
  String get dateType;

  /// No description provided for @ot.
  ///
  /// In en, this message translates to:
  /// **'Overtime work'**
  String get ot;

  /// No description provided for @totalLeaveWork.
  ///
  /// In en, this message translates to:
  /// **'Total leave days'**
  String get totalLeaveWork;

  /// No description provided for @noShiftsWork.
  ///
  /// In en, this message translates to:
  /// **'No work shift assigned'**
  String get noShiftsWork;

  /// No description provided for @regularDay.
  ///
  /// In en, this message translates to:
  /// **'Weekday'**
  String get regularDay;

  /// No description provided for @timeFrameOT.
  ///
  /// In en, this message translates to:
  /// **'OT time frame'**
  String get timeFrameOT;

  /// No description provided for @timeFrame.
  ///
  /// In en, this message translates to:
  /// **'Time frame'**
  String get timeFrame;

  /// No description provided for @numberOfLate.
  ///
  /// In en, this message translates to:
  /// **'Early departures'**
  String get numberOfLate;

  /// No description provided for @numberOfEarly.
  ///
  /// In en, this message translates to:
  /// **'Late arrivals'**
  String get numberOfEarly;

  /// No description provided for @workOT.
  ///
  /// In en, this message translates to:
  /// **'Overtime hours'**
  String get workOT;

  /// No description provided for @historyTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping history'**
  String get historyTimekeeping;

  /// No description provided for @totalTimeWork.
  ///
  /// In en, this message translates to:
  /// **'Total working hours'**
  String get totalTimeWork;

  /// No description provided for @totalTimeWorkCompensatory.
  ///
  /// In en, this message translates to:
  /// **'Total make-up time'**
  String get totalTimeWorkCompensatory;

  /// No description provided for @titleBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business trip duration'**
  String get titleBusiness;

  /// No description provided for @timeStart.
  ///
  /// In en, this message translates to:
  /// **'Leaving time'**
  String get timeStart;

  /// No description provided for @timeEnd.
  ///
  /// In en, this message translates to:
  /// **'Return time'**
  String get timeEnd;

  /// No description provided for @socialInsuranceLeave.
  ///
  /// In en, this message translates to:
  /// **'Paid by social insurance (BHXH)'**
  String get socialInsuranceLeave;

  /// No description provided for @lateOrEarly.
  ///
  /// In en, this message translates to:
  /// **'Late Arrival/Early Departure'**
  String get lateOrEarly;

  /// No description provided for @lateOrEarlyCreate.
  ///
  /// In en, this message translates to:
  /// **'Create request for Late Arrival/Early Departure'**
  String get lateOrEarlyCreate;

  /// No description provided for @timekeepingError.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping error'**
  String get timekeepingError;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @calendarWork.
  ///
  /// In en, this message translates to:
  /// **'Work schedule'**
  String get calendarWork;

  /// No description provided for @shiftManagement.
  ///
  /// In en, this message translates to:
  /// **'Manage work schedule'**
  String get shiftManagement;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @pendingCancel.
  ///
  /// In en, this message translates to:
  /// **'Pending shift cancellation'**
  String get pendingCancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get remove;

  /// No description provided for @usable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get usable;

  /// No description provided for @unusable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unusable;

  /// No description provided for @administrativeShift.
  ///
  /// In en, this message translates to:
  /// **'Business hour shift'**
  String get administrativeShift;

  /// No description provided for @singleShift.
  ///
  /// In en, this message translates to:
  /// **'Single shift'**
  String get singleShift;

  /// No description provided for @unregistered.
  ///
  /// In en, this message translates to:
  /// **'Not registered'**
  String get unregistered;

  /// No description provided for @cancelShiftRegistration.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift registration'**
  String get cancelShiftRegistration;

  /// No description provided for @cancelShiftReceiveRegistration.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift acceptance'**
  String get cancelShiftReceiveRegistration;

  /// No description provided for @cancelShiftCancellationRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift cancellation request'**
  String get cancelShiftCancellationRequest;

  /// No description provided for @registerForShifts.
  ///
  /// In en, this message translates to:
  /// **'Register shift'**
  String get registerForShifts;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;

  /// No description provided for @fingerprint.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint'**
  String get fingerprint;

  /// No description provided for @gPS.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get gPS;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get wrongPassword;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get none;

  /// No description provided for @reasonForCancelingRequest.
  ///
  /// In en, this message translates to:
  /// **'Reason for request cancellation'**
  String get reasonForCancelingRequest;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get loading;

  /// No description provided for @halfDayToOneDay.
  ///
  /// In en, this message translates to:
  /// **'Request for Leave (0.5 - 1 Day)'**
  String get halfDayToOneDay;

  /// No description provided for @twoDayToFourDay.
  ///
  /// In en, this message translates to:
  /// **'Request for Leave (2 - 4 Day)'**
  String get twoDayToFourDay;

  /// No description provided for @fiveDaysOrMore.
  ///
  /// In en, this message translates to:
  /// **'Request for Leave (5 or More Days)'**
  String get fiveDaysOrMore;

  /// No description provided for @halfDayToOneDayCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Request for Leave (0.5 - 1 Day)'**
  String get halfDayToOneDayCreate;

  /// No description provided for @twoDayToFourDayCreate.
  ///
  /// In en, this message translates to:
  /// **'CCreate Request for Leave (2 - 4 Day)'**
  String get twoDayToFourDayCreate;

  /// No description provided for @fiveDaysOrMoreCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Request for Leave (5 or More Days)'**
  String get fiveDaysOrMoreCreate;

  /// No description provided for @earlyLate.
  ///
  /// In en, this message translates to:
  /// **'Request for Late Arrival/Early Departure'**
  String get earlyLate;

  /// No description provided for @vehicleF.
  ///
  /// In en, this message translates to:
  /// **'Request for Vehicle Allocation'**
  String get vehicleF;

  /// No description provided for @businessF.
  ///
  /// In en, this message translates to:
  /// **'Request for Business Trip'**
  String get businessF;

  /// No description provided for @releaseOfWarehouseF.
  ///
  /// In en, this message translates to:
  /// **'Request for Inventory Withdrawal'**
  String get releaseOfWarehouseF;

  /// No description provided for @stationery.
  ///
  /// In en, this message translates to:
  /// **'Stationery Order Form'**
  String get stationery;

  /// No description provided for @explanationF.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping Correction Request'**
  String get explanationF;

  /// No description provided for @oT.
  ///
  /// In en, this message translates to:
  /// **'Overtime Request'**
  String get oT;

  /// No description provided for @requestType.
  ///
  /// In en, this message translates to:
  /// **'Request type'**
  String get requestType;

  /// No description provided for @chooseARequest.
  ///
  /// In en, this message translates to:
  /// **'Select request type'**
  String get chooseARequest;

  /// No description provided for @nameSchool.
  ///
  /// In en, this message translates to:
  /// **'School name'**
  String nameSchool(Object a);

  /// No description provided for @nameClass.
  ///
  /// In en, this message translates to:
  /// **'Class name'**
  String nameClass(Object a);

  /// No description provided for @nameTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher\'s name'**
  String nameTeacher(Object a);

  /// No description provided for @timekeepingTime.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping time'**
  String get timekeepingTime;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @timekeepingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping successful'**
  String get timekeepingSuccess;

  /// No description provided for @timekeepingUnSuccess.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping failed'**
  String get timekeepingUnSuccess;

  /// No description provided for @chooseWorkShift.
  ///
  /// In en, this message translates to:
  /// **'Select work shift'**
  String get chooseWorkShift;

  /// No description provided for @ifOto.
  ///
  /// In en, this message translates to:
  /// **'If traveling by car, driver’s name'**
  String get ifOto;

  /// No description provided for @totalOvertimeHours.
  ///
  /// In en, this message translates to:
  /// **'Total overtime hours'**
  String get totalOvertimeHours;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @personalReasons.
  ///
  /// In en, this message translates to:
  /// **'Personal reason'**
  String get personalReasons;

  /// No description provided for @companyReasons.
  ///
  /// In en, this message translates to:
  /// **'Company reason'**
  String get companyReasons;

  /// No description provided for @firstShift.
  ///
  /// In en, this message translates to:
  /// **'First shift'**
  String get firstShift;

  /// No description provided for @lastShift.
  ///
  /// In en, this message translates to:
  /// **'Last shift'**
  String get lastShift;

  /// No description provided for @totalWork.
  ///
  /// In en, this message translates to:
  /// **'Number of workdays'**
  String get totalWork;

  /// No description provided for @createRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request creation failed'**
  String get createRequestFailed;

  /// No description provided for @editRequestUnsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Request update failed'**
  String get editRequestUnsuccessful;

  /// No description provided for @createSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request created successfully'**
  String get createSuccess;

  /// No description provided for @editRequestSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request updated successfully'**
  String get editRequestSuccess;

  /// No description provided for @theTotalNumberOfLeaveIsNotEnough.
  ///
  /// In en, this message translates to:
  /// **'You have used up all your leave days!'**
  String get theTotalNumberOfLeaveIsNotEnough;

  /// No description provided for @approvedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Approval successful'**
  String get approvedSuccess;

  /// No description provided for @approvedUnsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Approval failed'**
  String get approvedUnsuccessful;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get cancelRequest;

  /// No description provided for @leaveReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for leave'**
  String get leaveReason;

  /// No description provided for @reasonType.
  ///
  /// In en, this message translates to:
  /// **'Reason type'**
  String get reasonType;

  /// No description provided for @updateUnsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Update information failed!'**
  String get updateUnsuccessful;

  /// No description provided for @postal.
  ///
  /// In en, this message translates to:
  /// **'Postal'**
  String get postal;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @numberTotalWork.
  ///
  /// In en, this message translates to:
  /// **'Total number of work days'**
  String get numberTotalWork;

  /// No description provided for @gPSAndFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping method: GPS & Fingerprint'**
  String get gPSAndFingerprint;

  /// No description provided for @noTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping method: No timekeeping'**
  String get noTimekeeping;

  /// No description provided for @reasonCreateRequest.
  ///
  /// In en, this message translates to:
  /// **'Reason for request'**
  String get reasonCreateRequest;

  /// No description provided for @descriptionR.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionR;

  /// No description provided for @caseL.
  ///
  /// In en, this message translates to:
  /// **'Case'**
  String get caseL;

  /// No description provided for @revokeRequestSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request canceled successfully'**
  String get revokeRequestSuccess;

  /// No description provided for @revokeRequestUnsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Request cancelation failed'**
  String get revokeRequestUnsuccessful;

  /// No description provided for @notSelectedAShift.
  ///
  /// In en, this message translates to:
  /// **'You have not selected a shift yet'**
  String get notSelectedAShift;

  /// No description provided for @notSelectedAOverTime.
  ///
  /// In en, this message translates to:
  /// **'You have not selected overtime hours yet'**
  String get notSelectedAOverTime;

  /// No description provided for @selectTypeLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave type'**
  String get selectTypeLeave;

  /// No description provided for @selectLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave source'**
  String get selectLeave;

  /// No description provided for @destinationOT.
  ///
  /// In en, this message translates to:
  /// **'Overtime location'**
  String get destinationOT;

  /// No description provided for @inCompany.
  ///
  /// In en, this message translates to:
  /// **'Inside the company'**
  String get inCompany;

  /// No description provided for @outCompany.
  ///
  /// In en, this message translates to:
  /// **'Outside the company'**
  String get outCompany;

  /// No description provided for @makeUpWork.
  ///
  /// In en, this message translates to:
  /// **'Compensatory work request'**
  String get makeUpWork;

  /// No description provided for @createMakeUpWork.
  ///
  /// In en, this message translates to:
  /// **'Create compensatory work request'**
  String get createMakeUpWork;

  /// No description provided for @reasonMakeUpWork.
  ///
  /// In en, this message translates to:
  /// **'Reason for compensatory work'**
  String get reasonMakeUpWork;

  /// No description provided for @leaveDate.
  ///
  /// In en, this message translates to:
  /// **'Leave date'**
  String get leaveDate;

  /// No description provided for @makeUpWorkDate.
  ///
  /// In en, this message translates to:
  /// **'Compensatory work date'**
  String get makeUpWorkDate;

  /// No description provided for @totalMakeUpWorkTime.
  ///
  /// In en, this message translates to:
  /// **'Total compensatory work hours'**
  String get totalMakeUpWorkTime;

  /// No description provided for @youDoNotHaveAShift.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have a shift on the selected date!'**
  String get youDoNotHaveAShift;

  /// No description provided for @shiftWasLeave.
  ///
  /// In en, this message translates to:
  /// **'Shift off'**
  String get shiftWasLeave;

  /// No description provided for @realCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Actual Check-in time'**
  String get realCheckIn;

  /// No description provided for @realCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Actual Check-out time'**
  String get realCheckOut;

  /// No description provided for @settingBiometric.
  ///
  /// In en, this message translates to:
  /// **'Set up Touch Id/Face Id'**
  String get settingBiometric;

  /// No description provided for @cancelBiometricSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Biometric login cancellation successful'**
  String get cancelBiometricSuccessful;

  /// No description provided for @settingBiometricSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Biometric login setup successful'**
  String get settingBiometricSuccessful;

  /// No description provided for @authAccount.
  ///
  /// In en, this message translates to:
  /// **'Account verification'**
  String get authAccount;

  /// No description provided for @offDay.
  ///
  /// In en, this message translates to:
  /// **'Day off'**
  String get offDay;

  /// No description provided for @oTSalary.
  ///
  /// In en, this message translates to:
  /// **'OT salary coefficient'**
  String get oTSalary;

  /// No description provided for @oTMakeUpLeave.
  ///
  /// In en, this message translates to:
  /// **'Compensatory OT coefficient'**
  String get oTMakeUpLeave;

  /// No description provided for @oTSalaryH.
  ///
  /// In en, this message translates to:
  /// **'OT hours for salary'**
  String get oTSalaryH;

  /// No description provided for @oTMakeUpLeaveH.
  ///
  /// In en, this message translates to:
  /// **'OT hours for compensatory leave'**
  String get oTMakeUpLeaveH;

  /// No description provided for @makeUpTime.
  ///
  /// In en, this message translates to:
  /// **'Compensatory time'**
  String get makeUpTime;

  /// No description provided for @nameNotNullOrEmpty.
  ///
  /// In en, this message translates to:
  /// **' Name must not be empty'**
  String get nameNotNullOrEmpty;

  /// No description provided for @statusOtherActiveOrInActive.
  ///
  /// In en, this message translates to:
  /// **' Status must be either Active or Inactive'**
  String get statusOtherActiveOrInActive;

  /// No description provided for @stepFlowNotNull.
  ///
  /// In en, this message translates to:
  /// **' Approval step must not be empty'**
  String get stepFlowNotNull;

  /// No description provided for @nameNull.
  ///
  /// In en, this message translates to:
  /// **' Name is empty'**
  String get nameNull;

  /// No description provided for @nameAlreadyExist.
  ///
  /// In en, this message translates to:
  /// **' Name already exists'**
  String get nameAlreadyExist;

  /// No description provided for @thisDepartmentAlreadyExistFlow.
  ///
  /// In en, this message translates to:
  /// **' Department already has a flow for this type of request'**
  String get thisDepartmentAlreadyExistFlow;

  /// No description provided for @thisPositionAlreadyExistFlow.
  ///
  /// In en, this message translates to:
  /// **' Position already has a flow for this type of request'**
  String get thisPositionAlreadyExistFlow;

  /// No description provided for @thisDepartmentPositionAlreadyExistFlow.
  ///
  /// In en, this message translates to:
  /// **' Department and position already have a flow for this type of request'**
  String get thisDepartmentPositionAlreadyExistFlow;

  /// No description provided for @thisUserAlreadyExistFlow.
  ///
  /// In en, this message translates to:
  /// **' Employee already has a flow for this type of request'**
  String get thisUserAlreadyExistFlow;

  /// No description provided for @typeAlreadyHasStepFlow.
  ///
  /// In en, this message translates to:
  /// **' This request already has an approval flow'**
  String get typeAlreadyHasStepFlow;

  /// No description provided for @thisFlowAlreadyExistsRequest.
  ///
  /// In en, this message translates to:
  /// **' This flow already has a request'**
  String get thisFlowAlreadyExistsRequest;

  /// No description provided for @flowNotExist.
  ///
  /// In en, this message translates to:
  /// **' Flow does not exist'**
  String get flowNotExist;

  /// No description provided for @flowIsNotCoreType.
  ///
  /// In en, this message translates to:
  /// **' Flow type is not an approval flow'**
  String get flowIsNotCoreType;

  /// No description provided for @statusInActiveUnableUpdate.
  ///
  /// In en, this message translates to:
  /// **' Inactive status cannot be updated'**
  String get statusInActiveUnableUpdate;

  /// No description provided for @userIdNotNull.
  ///
  /// In en, this message translates to:
  /// **' Applier must not be empty'**
  String get userIdNotNull;

  /// No description provided for @departmentIdOrPositionIdMustNotExist.
  ///
  /// In en, this message translates to:
  /// **' Department or position must not exist when the type is employee'**
  String get departmentIdOrPositionIdMustNotExist;

  /// No description provided for @departmentIdAndPositionIdNotNull.
  ///
  /// In en, this message translates to:
  /// **' Department or position must not be empty'**
  String get departmentIdAndPositionIdNotNull;

  /// No description provided for @userIdMustNotExist.
  ///
  /// In en, this message translates to:
  /// **' Employee must not exist when the type is department or position'**
  String get userIdMustNotExist;

  /// No description provided for @positionIdNotNull.
  ///
  /// In en, this message translates to:
  /// **' Position must not be empty'**
  String get positionIdNotNull;

  /// No description provided for @departmentIdOrUserIdMustNotExist.
  ///
  /// In en, this message translates to:
  /// **' Department and employee must not exist when the type is position'**
  String get departmentIdOrUserIdMustNotExist;

  /// No description provided for @departmentIdNotNull.
  ///
  /// In en, this message translates to:
  /// **' Department must not be empty'**
  String get departmentIdNotNull;

  /// No description provided for @positionIdOrUserIdMustNotExist.
  ///
  /// In en, this message translates to:
  /// **' Position and employee must not exist when the type is department'**
  String get positionIdOrUserIdMustNotExist;

  /// No description provided for @inValidFormat.
  ///
  /// In en, this message translates to:
  /// **' Invalid format'**
  String get inValidFormat;

  /// No description provided for @configNotNull.
  ///
  /// In en, this message translates to:
  /// **' Request data must not be empty'**
  String get configNotNull;

  /// No description provided for @exceededTheRequestedCreateTimeframe.
  ///
  /// In en, this message translates to:
  /// **' Request creation time has exceeded the allowed limit'**
  String get exceededTheRequestedCreateTimeframe;

  /// No description provided for @currentStatusIsNotEdit.
  ///
  /// In en, this message translates to:
  /// **' Current status is not editable'**
  String get currentStatusIsNotEdit;

  /// No description provided for @currentStatusIsNotProcessOrEdit.
  ///
  /// In en, this message translates to:
  /// **' Request is not in a valid state for cancellation.'**
  String get currentStatusIsNotProcessOrEdit;

  /// No description provided for @theNumberOfFormsCreatedHasExceededTheLimit.
  ///
  /// In en, this message translates to:
  /// **' The number of requests created has exceeded the limit'**
  String get theNumberOfFormsCreatedHasExceededTheLimit;

  /// No description provided for @endDateGreaterThanStartDate.
  ///
  /// In en, this message translates to:
  /// **' End date is greater than the start date'**
  String get endDateGreaterThanStartDate;

  /// No description provided for @employeeNotFullTimeOrPartTime.
  ///
  /// In en, this message translates to:
  /// **' Employee is neither full-time nor part-time'**
  String get employeeNotFullTimeOrPartTime;

  /// No description provided for @userIdAndPositionIdCannotExistSameTime.
  ///
  /// In en, this message translates to:
  /// **' Employee and position cannot coexist simultaneously'**
  String get userIdAndPositionIdCannotExistSameTime;

  /// No description provided for @userIdOrPositionIdCanNotNull.
  ///
  /// In en, this message translates to:
  /// **' User or position must not be empty'**
  String get userIdOrPositionIdCanNotNull;

  /// No description provided for @flowDoesNotHaveEnoughComponents.
  ///
  /// In en, this message translates to:
  /// **' Flow must include start, steps, and end components'**
  String get flowDoesNotHaveEnoughComponents;

  /// No description provided for @ifStepTypeStartOrEndNoUserIdPositionIdDepartmentId.
  ///
  /// In en, this message translates to:
  /// **'If it is a start or end type, it should not include employee, position, or department'**
  String get ifStepTypeStartOrEndNoUserIdPositionIdDepartmentId;

  /// No description provided for @currentStatusNotNew.
  ///
  /// In en, this message translates to:
  /// **' Current status is not new'**
  String get currentStatusNotNew;

  /// No description provided for @nameStepFlowNotNull.
  ///
  /// In en, this message translates to:
  /// **' Approval step name must not be empty'**
  String get nameStepFlowNotNull;

  /// No description provided for @dataNotNull.
  ///
  /// In en, this message translates to:
  /// **' Data must not be empty'**
  String get dataNotNull;

  /// No description provided for @timeSlotAlreadyPleaseChooseAnother.
  ///
  /// In en, this message translates to:
  /// **'A request with the same time frame already exists, please select a different time'**
  String get timeSlotAlreadyPleaseChooseAnother;

  /// No description provided for @mustCreateMinimumTimeInAdvance.
  ///
  /// In en, this message translates to:
  /// **' Must be created before the minimum time'**
  String get mustCreateMinimumTimeInAdvance;

  /// No description provided for @pastTheDateOfExplanation.
  ///
  /// In en, this message translates to:
  /// **' Past the explanation date'**
  String get pastTheDateOfExplanation;

  /// No description provided for @errorTimeMakeUp1.
  ///
  /// In en, this message translates to:
  /// **'The total number of compensatory hours must be greater than or equal to the number of missed working hours. Please adjust.'**
  String get errorTimeMakeUp1;

  /// No description provided for @errorTimeMakeUp2.
  ///
  /// In en, this message translates to:
  /// **'Compensation time overlaps with another shift. Please select again.'**
  String get errorTimeMakeUp2;

  /// No description provided for @errorPlease.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again later!'**
  String get errorPlease;

  /// No description provided for @limitFile.
  ///
  /// In en, this message translates to:
  /// **'The number of files exceeds 5'**
  String get limitFile;

  /// No description provided for @saveRequest.
  ///
  /// In en, this message translates to:
  /// **'Save request'**
  String get saveRequest;

  /// No description provided for @createRequest.
  ///
  /// In en, this message translates to:
  /// **'Create request'**
  String get createRequest;

  /// No description provided for @setHoursAndMinutes.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get setHoursAndMinutes;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @rejectSucceed.
  ///
  /// In en, this message translates to:
  /// **'Request rejected successfully'**
  String get rejectSucceed;

  /// No description provided for @requestSucceed.
  ///
  /// In en, this message translates to:
  /// **'Modification request submitted successfully'**
  String get requestSucceed;

  /// No description provided for @cancelSucceed.
  ///
  /// In en, this message translates to:
  /// **'Request canceled successfully'**
  String get cancelSucceed;

  /// No description provided for @approveSucceed.
  ///
  /// In en, this message translates to:
  /// **'Request approved successfully'**
  String get approveSucceed;

  /// No description provided for @rejectFailed.
  ///
  /// In en, this message translates to:
  /// **'Request rejection failed'**
  String get rejectFailed;

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Modification request submission failed'**
  String get requestFailed;

  /// No description provided for @cancelFailed.
  ///
  /// In en, this message translates to:
  /// **'Request cancellation failed'**
  String get cancelFailed;

  /// No description provided for @approveFailed.
  ///
  /// In en, this message translates to:
  /// **'Request approval failed'**
  String get approveFailed;

  /// No description provided for @contentPopUpOpenGPS.
  ///
  /// In en, this message translates to:
  /// **'Allow HRM to access your location'**
  String get contentPopUpOpenGPS;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @contentDialogTimeKeepingUnSuccess.
  ///
  /// In en, this message translates to:
  /// **'Timekeeping failed. Please try again'**
  String get contentDialogTimeKeepingUnSuccess;

  /// No description provided for @contentDialogTimeKeepingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Attendance was successful'**
  String get contentDialogTimeKeepingSuccess;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @rejectTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this employee from the current shift?'**
  String get rejectTitle;

  /// No description provided for @rejectTitle1.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this employee\'s shift cancellation request?'**
  String get rejectTitle1;

  /// No description provided for @rejectTitle2.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to refuse to approve this employee\'s shift registration request?'**
  String get rejectTitle2;

  /// No description provided for @proactiveCaseRegistrationManagement.
  ///
  /// In en, this message translates to:
  /// **'Proactive shift registration management'**
  String get proactiveCaseRegistrationManagement;

  /// No description provided for @receivedShift.
  ///
  /// In en, this message translates to:
  /// **'Shift received'**
  String get receivedShift;

  /// No description provided for @rejectShift.
  ///
  /// In en, this message translates to:
  /// **'Shift rejected'**
  String get rejectShift;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @waitingForApprovalToCancelShift.
  ///
  /// In en, this message translates to:
  /// **'Waiting for shift cancellation approval'**
  String get waitingForApprovalToCancelShift;

  /// No description provided for @waitingForShiftRegistrationApproval.
  ///
  /// In en, this message translates to:
  /// **'Waiting for shift registration approval'**
  String get waitingForShiftRegistrationApproval;

  /// No description provided for @notRegisteredYet.
  ///
  /// In en, this message translates to:
  /// **'not registered yet'**
  String get notRegisteredYet;

  /// No description provided for @dialogConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'Do you want to approve this shift?'**
  String get dialogConfirmContent;

  /// No description provided for @shiftOfDay.
  ///
  /// In en, this message translates to:
  /// **'Today\'s shift: '**
  String get shiftOfDay;

  /// No description provided for @moveToTheAppropriate.
  ///
  /// In en, this message translates to:
  /// **'Please move to a valid location on the map'**
  String get moveToTheAppropriate;

  /// No description provided for @chooseASchedule.
  ///
  /// In en, this message translates to:
  /// **'You need to select a schedule for timekeeping.'**
  String get chooseASchedule;

  /// No description provided for @noDataTimekeeping.
  ///
  /// In en, this message translates to:
  /// **'No timekeeping data'**
  String get noDataTimekeeping;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get sent;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @readAll.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get readAll;

  /// No description provided for @noNotification.
  ///
  /// In en, this message translates to:
  /// **'No notification'**
  String get noNotification;

  /// No description provided for @shiftDetails.
  ///
  /// In en, this message translates to:
  /// **'Shift details'**
  String get shiftDetails;

  /// No description provided for @shiftCode.
  ///
  /// In en, this message translates to:
  /// **'Shift Code'**
  String get shiftCode;

  /// No description provided for @shiftName.
  ///
  /// In en, this message translates to:
  /// **'Shift name'**
  String get shiftName;

  /// No description provided for @workingTime1.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get workingTime1;

  /// No description provided for @recordedNumberOfShifts.
  ///
  /// In en, this message translates to:
  /// **'Recorded number of shifts'**
  String get recordedNumberOfShifts;

  /// No description provided for @operationDay.
  ///
  /// In en, this message translates to:
  /// **'Date of operation'**
  String get operationDay;

  /// No description provided for @validTimeKeeping.
  ///
  /// In en, this message translates to:
  /// **'Valid timekeeping'**
  String get validTimeKeeping;

  /// No description provided for @cancelShift1.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift registration'**
  String get cancelShift1;

  /// No description provided for @cancelShift2.
  ///
  /// In en, this message translates to:
  /// **'Shift status history'**
  String get cancelShift2;

  /// No description provided for @shiftHistory.
  ///
  /// In en, this message translates to:
  /// **'Case status history'**
  String get shiftHistory;

  /// No description provided for @noConnected.
  ///
  /// In en, this message translates to:
  /// **'No Connection/ An error occured, please check again later!'**
  String get noConnected;

  /// No description provided for @reasonForCancellation.
  ///
  /// In en, this message translates to:
  /// **'Reason for cancellation'**
  String get reasonForCancellation;

  /// No description provided for @shiftIsCancelled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get shiftIsCancelled;

  /// No description provided for @skipLogin.
  ///
  /// In en, this message translates to:
  /// **'Skip Login'**
  String get skipLogin;

  /// No description provided for @cancelShiftSuccess.
  ///
  /// In en, this message translates to:
  /// **'Submit request to cancel shift successfully, the request needs to be confirmed'**
  String get cancelShiftSuccess;

  /// No description provided for @cancelShiftSuccess1.
  ///
  /// In en, this message translates to:
  /// **'Cancel shift successfully'**
  String get cancelShiftSuccess1;

  /// No description provided for @cancelCancelShiftSuccess.
  ///
  /// In en, this message translates to:
  /// **'Cancel request cancel shift successfully'**
  String get cancelCancelShiftSuccess;

  /// No description provided for @registeredShiftSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Registered Shift Successfully, shift is awaiting approval'**
  String get registeredShiftSuccessfully;

  /// No description provided for @remove2.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove2;

  /// No description provided for @inputNameStaff.
  ///
  /// In en, this message translates to:
  /// **'Input name staff'**
  String get inputNameStaff;

  /// No description provided for @edit2.
  ///
  /// In en, this message translates to:
  /// **'Request revision'**
  String get edit2;

  /// No description provided for @errorNumber.
  ///
  /// In en, this message translates to:
  /// **'Quantity must not be left blank'**
  String get errorNumber;

  /// No description provided for @errNotData.
  ///
  /// In en, this message translates to:
  /// **'Not data'**
  String get errNotData;

  /// No description provided for @filterByMonth.
  ///
  /// In en, this message translates to:
  /// **'Filter by month'**
  String get filterByMonth;

  /// No description provided for @filterByDay.
  ///
  /// In en, this message translates to:
  /// **'Filter by day'**
  String get filterByDay;

  /// No description provided for @requestDeniedBy.
  ///
  /// In en, this message translates to:
  /// **'Request Denied by: '**
  String get requestDeniedBy;

  /// No description provided for @requestCancelBy.
  ///
  /// In en, this message translates to:
  /// **'Request Canceled by:'**
  String get requestCancelBy;

  /// No description provided for @requestEditBy.
  ///
  /// In en, this message translates to:
  /// **'Request Edited by:'**
  String get requestEditBy;

  /// No description provided for @reasonReject.
  ///
  /// In en, this message translates to:
  /// **'Reason for rejection:'**
  String get reasonReject;

  /// No description provided for @reasonCancel.
  ///
  /// In en, this message translates to:
  /// **'Reason for cancellation:'**
  String get reasonCancel;

  /// No description provided for @reasonForCanceling.
  ///
  /// In en, this message translates to:
  /// **'Reason for canceling'**
  String get reasonForCanceling;

  /// No description provided for @reasonForRejection.
  ///
  /// In en, this message translates to:
  /// **'Reason for rejection'**
  String get reasonForRejection;

  /// No description provided for @nameWorkShift.
  ///
  /// In en, this message translates to:
  /// **'Work shift name'**
  String get nameWorkShift;

  /// No description provided for @reasonForRemove.
  ///
  /// In en, this message translates to:
  /// **'Reason for stop'**
  String get reasonForRemove;

  /// No description provided for @mapLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get mapLocation;

  /// No description provided for @reasonCannotBeLeftBlank.
  ///
  /// In en, this message translates to:
  /// **'Reason cannot be left blank'**
  String get reasonCannotBeLeftBlank;

  /// No description provided for @reasonCancelShift.
  ///
  /// In en, this message translates to:
  /// **'Reason cancel shift'**
  String get reasonCancelShift;

  /// No description provided for @selectFilter.
  ///
  /// In en, this message translates to:
  /// **'Select filter'**
  String get selectFilter;

  /// No description provided for @loginBiometricAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Log in with biometric authentication'**
  String get loginBiometricAuthentication;

  /// No description provided for @useFaceIDInsteadOfAPassword.
  ///
  /// In en, this message translates to:
  /// **'Use your Face ID instead of a password'**
  String get useFaceIDInsteadOfAPassword;

  /// No description provided for @approveShiftSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Approve shift registration successfully'**
  String get approveShiftSuccessfully;

  /// No description provided for @refusedToRegisterASuccessfulShift.
  ///
  /// In en, this message translates to:
  /// **'Refused to register a successful shift'**
  String get refusedToRegisterASuccessfulShift;

  /// No description provided for @approveTheRequestToCancelTheShiftSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Approve the request to cancel the shift successfully'**
  String get approveTheRequestToCancelTheShiftSuccessfully;

  /// No description provided for @rejectTheRequestToCancelTheShiftSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Reject the request to cancel the shift successfully'**
  String get rejectTheRequestToCancelTheShiftSuccessfully;

  /// No description provided for @removeTheEmployeeShift.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove the employee {a} from the shift?'**
  String removeTheEmployeeShift(Object a);

  /// No description provided for @removeEmployeeSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Remove employee from successful shift'**
  String get removeEmployeeSuccessful;

  /// No description provided for @areYouSureCancelShift.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel employee {a}\'s shift?'**
  String areYouSureCancelShift(Object a);

  /// No description provided for @quitLoggingInAccessUtilities.
  ///
  /// In en, this message translates to:
  /// **'Skip login, access utilities'**
  String get quitLoggingInAccessUtilities;

  /// No description provided for @ifYouDoNotHaveAnAccountPleaseContactHCNS.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t have an account, please contact Human Resources.'**
  String get ifYouDoNotHaveAnAccountPleaseContactHCNS;

  /// No description provided for @enterReason.
  ///
  /// In en, this message translates to:
  /// **'Enter reason...'**
  String get enterReason;

  /// No description provided for @forgotPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password success!'**
  String get forgotPasswordSuccess;

  /// No description provided for @saveUpdateInfo.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveUpdateInfo;

  /// No description provided for @i18nDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get i18nDays;

  /// No description provided for @i18nHours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get i18nHours;

  /// No description provided for @i18nNotFullTimeOrPartTime.
  ///
  /// In en, this message translates to:
  /// **'You are not eligible to submit a request.'**
  String get i18nNotFullTimeOrPartTime;

  /// No description provided for @i18nCompensatoryLeave.
  ///
  /// In en, this message translates to:
  /// **'Compensatory Leave'**
  String get i18nCompensatoryLeave;

  /// No description provided for @i18nOTRate.
  ///
  /// In en, this message translates to:
  /// **'OT rate'**
  String get i18nOTRate;

  /// No description provided for @i18nOTInformation.
  ///
  /// In en, this message translates to:
  /// **'OT Information'**
  String get i18nOTInformation;

  /// No description provided for @i18nOTInformationList.
  ///
  /// In en, this message translates to:
  /// **'OT Information List'**
  String get i18nOTInformationList;

  /// No description provided for @i18nRate.
  ///
  /// In en, this message translates to:
  /// **'Coefficient'**
  String get i18nRate;

  /// No description provided for @i18nTotalHour.
  ///
  /// In en, this message translates to:
  /// **'Total Hours'**
  String get i18nTotalHour;

  /// No description provided for @i18nReadMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get i18nReadMore;

  /// No description provided for @i18nClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get i18nClose;

  /// No description provided for @i18nTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again to continue.'**
  String get i18nTokenExpired;

  /// No description provided for @i18nYouWantToApproveThisApplication.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to approve this application?'**
  String get i18nYouWantToApproveThisApplication;

  /// No description provided for @i18nReportLastMonthIsWorkOnlyOnThe1stAnd2nd.
  ///
  /// In en, this message translates to:
  /// **'The attendance explanation for last month expired on the 2nd of this month.'**
  String get i18nReportLastMonthIsWorkOnlyOnThe1stAnd2nd;

  /// No description provided for @i18nOnlyAllowedToEditWorkThisMonthOrLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Only allowed to edit work this month or last month.'**
  String get i18nOnlyAllowedToEditWorkThisMonthOrLastMonth;
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
