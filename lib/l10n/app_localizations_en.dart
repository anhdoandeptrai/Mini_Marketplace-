// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get role => 'Role';

  @override
  String get teacher => 'Teacher';

  @override
  String get student => 'Student';

  @override
  String get logout => 'Logout';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get pleaseEnterEmail => 'Please enter email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get pleaseEnterPassword => 'Please enter password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get pleaseEnterName => 'Please enter name';

  @override
  String get pleaseSelectRole => 'Please select a role';

  @override
  String get courses => 'Courses';

  @override
  String get myCourses => 'My Courses';

  @override
  String get createCourse => 'Create Course';

  @override
  String get courseTitle => 'Course Title';

  @override
  String get courseDescription => 'Description';

  @override
  String get price => 'Price';

  @override
  String get priceInVND => 'Price (VND)';

  @override
  String get tags => 'Tags';

  @override
  String get selectImage => 'Select Image';

  @override
  String get imageSelected => 'Image selected';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get create => 'Create';

  @override
  String get noCourses => 'No courses yet';

  @override
  String get createFirstCourse => 'Create your first course!';

  @override
  String get students => 'students';

  @override
  String enrolledCount(int count) {
    return '$count students';
  }

  @override
  String get active => 'Active';

  @override
  String get locked => 'Locked';

  @override
  String get lockCourse => 'Lock Course';

  @override
  String get unlockCourse => 'Unlock Course';

  @override
  String get lockCourseConfirm => 'Do you want to lock this course?';

  @override
  String get unlockCourseConfirm => 'Do you want to unlock this course?';

  @override
  String get studentsCannotAccess => 'Students will not be able to access this course.';

  @override
  String get studentsCanAccess => 'Students will be able to access this course.';

  @override
  String get cancel => 'Cancel';

  @override
  String get lock => 'Lock';

  @override
  String get unlock => 'Unlock';

  @override
  String get courseStatusUpdated => 'Course status updated';

  @override
  String get courseUpdated => 'Course updated successfully!';

  @override
  String get courseDeleted => 'Course deleted successfully!';

  @override
  String get editCourse => 'Edit Course';

  @override
  String get deleteCourse => 'Delete Course';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get confirmDeleteCourse => 'Are you sure you want to delete this course? This action cannot be undone.';

  @override
  String get youtubeUrl => 'YouTube URL';

  @override
  String get pdfUrl => 'PDF URL';

  @override
  String get videoLink => 'Video Link';

  @override
  String get documentLink => 'Document Link';

  @override
  String get learningMaterials => 'Learning Materials';

  @override
  String get noMaterialsAvailable => 'No learning materials available yet';

  @override
  String get myLearning => 'My Learning';

  @override
  String get purchasedCourses => 'Purchased Courses';

  @override
  String get noPurchasedCourses => 'You haven\'t purchased any courses yet';

  @override
  String get startLearning => 'Start learning by purchasing a course!';

  @override
  String get viewCourse => 'View Course';

  @override
  String get continueLearning => 'Continue Learning';

  @override
  String get loadingCourses => 'Loading your courses';

  @override
  String get orders => 'Orders';

  @override
  String get myOrders => 'My Orders';

  @override
  String get buyNow => 'Buy Now';

  @override
  String get orderCreated => 'Order created successfully!';

  @override
  String get noOrders => 'No orders yet';

  @override
  String get browseCoursesAndBuy => 'Browse courses and make your first purchase!';

  @override
  String get orderStatus => 'Status';

  @override
  String get orderDate => 'Order Date';

  @override
  String get amount => 'Amount';

  @override
  String get pending => 'Pending';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get chat => 'Chat';

  @override
  String get messages => 'Messages';

  @override
  String chatWith(String name) {
    return 'Chat with $name';
  }

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get send => 'Send';

  @override
  String get noMessages => 'No messages yet';

  @override
  String get noMessagesYet => 'No messages yet';

  @override
  String get startConversation => 'Start a conversation!';

  @override
  String get startConversationWithTeacher => 'Start chatting with a teacher to ask about courses!';

  @override
  String get newMessage => 'New Message';

  @override
  String get selectTeacher => 'Select Teacher';

  @override
  String get noTeachersAvailable => 'No teachers available';

  @override
  String get errorLoadingMessages => 'Error loading messages';

  @override
  String get home => 'Home';

  @override
  String get welcome => 'Welcome';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get browseAllCourses => 'Browse All Courses';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get english => 'English';

  @override
  String get error => 'Error';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get sort => 'Sort';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get networkError => 'Network error. Please check your connection.';

  @override
  String get authError => 'Authentication error';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get unknownError => 'Unknown error occurred';

  @override
  String get payment => 'Payment';

  @override
  String get paymentInformation => 'Payment Information';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get enterCardDetails => 'Enter your card details to complete payment';

  @override
  String get cardNumber => 'Card Number';

  @override
  String get cardHolderName => 'Card Holder Name';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get pleaseEnterCardNumber => 'Please enter card number';

  @override
  String get cardNumberMustBe16Digits => 'Card number must be 16 digits';

  @override
  String get pleaseEnterCardHolderName => 'Please enter card holder name';

  @override
  String get required => 'Required';

  @override
  String get invalidDate => 'Invalid date';

  @override
  String get invalidCVV => 'Invalid CVV';

  @override
  String get securePaymentInfo => 'Secure payment with SSL encryption. Your card information is protected.';

  @override
  String get payNow => 'Pay Now';

  @override
  String get paymentSuccessful => 'Payment Successful!';

  @override
  String get demoMode => 'Demo Mode';

  @override
  String get demoPaymentInfo => 'This is demo mode. You can enter any card information (16 digits, name, MM/YY, 3-digit CVV) to complete the payment.';

  @override
  String get courseAddedToMyLearning => 'Course has been added to \'My Learning\'!';

  @override
  String get goToMyLearningToStartLearning => 'Go to \'My Learning\' tab on home page to start learning!';

  @override
  String get backToHome => 'Back to Home';
}
