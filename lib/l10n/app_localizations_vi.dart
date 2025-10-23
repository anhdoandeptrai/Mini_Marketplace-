// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get login => 'Đăng nhập';

  @override
  String get register => 'Đăng ký';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get name => 'Họ tên';

  @override
  String get role => 'Vai trò';

  @override
  String get teacher => 'Giáo viên';

  @override
  String get student => 'Học viên';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get signInWithGoogle => 'Đăng nhập bằng Google';

  @override
  String get pleaseEnterEmail => 'Vui lòng nhập email';

  @override
  String get pleaseEnterValidEmail => 'Vui lòng nhập email hợp lệ';

  @override
  String get pleaseEnterPassword => 'Vui lòng nhập mật khẩu';

  @override
  String get passwordMinLength => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get pleaseEnterName => 'Vui lòng nhập họ tên';

  @override
  String get pleaseSelectRole => 'Vui lòng chọn vai trò';

  @override
  String get courses => 'Khóa học';

  @override
  String get myCourses => 'Khóa học của tôi';

  @override
  String get createCourse => 'Tạo khóa học';

  @override
  String get courseTitle => 'Tiêu đề khóa học';

  @override
  String get courseDescription => 'Mô tả';

  @override
  String get price => 'Giá';

  @override
  String get priceInVND => 'Giá (VNĐ)';

  @override
  String get tags => 'Thẻ tag';

  @override
  String get selectImage => 'Chọn ảnh';

  @override
  String get imageSelected => 'Đã chọn ảnh';

  @override
  String get noImageSelected => 'Chưa chọn ảnh';

  @override
  String get create => 'Tạo';

  @override
  String get noCourses => 'Chưa có khóa học nào';

  @override
  String get createFirstCourse => 'Tạo khóa học đầu tiên của bạn!';

  @override
  String get students => 'học viên';

  @override
  String enrolledCount(int count) {
    return '$count học viên';
  }

  @override
  String get active => 'Đang mở';

  @override
  String get locked => 'Đã khóa';

  @override
  String get lockCourse => 'Khóa khóa học';

  @override
  String get unlockCourse => 'Mở khóa học';

  @override
  String get lockCourseConfirm => 'Bạn có muốn khóa khóa học này không?';

  @override
  String get unlockCourseConfirm => 'Bạn có muốn mở khóa học này không?';

  @override
  String get studentsCannotAccess => 'Học viên sẽ không thể truy cập khóa học này.';

  @override
  String get studentsCanAccess => 'Học viên sẽ có thể truy cập khóa học này.';

  @override
  String get cancel => 'Hủy';

  @override
  String get lock => 'Khóa';

  @override
  String get unlock => 'Mở';

  @override
  String get courseStatusUpdated => 'Đã cập nhật trạng thái khóa học';

  @override
  String get courseUpdated => 'Cập nhật khóa học thành công!';

  @override
  String get courseDeleted => 'Xóa khóa học thành công!';

  @override
  String get editCourse => 'Sửa khóa học';

  @override
  String get deleteCourse => 'Xóa khóa học';

  @override
  String get confirmDelete => 'Xác nhận xóa';

  @override
  String get confirmDeleteCourse => 'Bạn có chắc chắn muốn xóa khóa học này? Hành động này không thể hoàn tác.';

  @override
  String get youtubeUrl => 'Link YouTube';

  @override
  String get pdfUrl => 'Link PDF';

  @override
  String get videoLink => 'Link video';

  @override
  String get documentLink => 'Link tài liệu';

  @override
  String get learningMaterials => 'Tài liệu học tập';

  @override
  String get noMaterialsAvailable => 'Chưa có tài liệu học tập';

  @override
  String get myLearning => 'Khóa Học Của Tôi';

  @override
  String get purchasedCourses => 'Khóa học đã mua';

  @override
  String get noPurchasedCourses => 'Bạn chưa mua khóa học nào';

  @override
  String get startLearning => 'Bắt đầu học bằng cách mua một khóa học!';

  @override
  String get viewCourse => 'Xem khóa học';

  @override
  String get continueLearning => 'Tiếp tục học';

  @override
  String get loadingCourses => 'Đang tải khóa học của bạn';

  @override
  String get orders => 'Đơn hàng';

  @override
  String get myOrders => 'Đơn hàng của tôi';

  @override
  String get buyNow => 'Mua ngay';

  @override
  String get orderCreated => 'Đã tạo đơn hàng thành công!';

  @override
  String get noOrders => 'Chưa có đơn hàng nào';

  @override
  String get browseCoursesAndBuy => 'Khám phá khóa học và thực hiện mua hàng đầu tiên!';

  @override
  String get orderStatus => 'Trạng thái';

  @override
  String get orderDate => 'Ngày đặt';

  @override
  String get amount => 'Số tiền';

  @override
  String get pending => 'Đang chờ';

  @override
  String get completed => 'Hoàn thành';

  @override
  String get cancelled => 'Đã hủy';

  @override
  String get chat => 'Trò chuyện';

  @override
  String get messages => 'Tin nhắn';

  @override
  String chatWith(String name) {
    return 'Trò chuyện với $name';
  }

  @override
  String get typeMessage => 'Nhập tin nhắn...';

  @override
  String get send => 'Gửi';

  @override
  String get noMessages => 'Chưa có tin nhắn nào';

  @override
  String get noMessagesYet => 'Chưa có tin nhắn';

  @override
  String get startConversation => 'Bắt đầu cuộc trò chuyện!';

  @override
  String get startConversationWithTeacher => 'Bắt đầu trò chuyện với giáo viên để hỏi về khóa học!';

  @override
  String get newMessage => 'Tin nhắn mới';

  @override
  String get selectTeacher => 'Chọn giáo viên';

  @override
  String get noTeachersAvailable => 'Không có giáo viên nào';

  @override
  String get errorLoadingMessages => 'Lỗi khi tải tin nhắn';

  @override
  String get home => 'Trang chủ';

  @override
  String get welcome => 'Chào mừng';

  @override
  String get welcomeBack => 'Chào mừng trở lại!';

  @override
  String get browseAllCourses => 'Xem tất cả khóa học';

  @override
  String get settings => 'Cài đặt';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get english => 'English';

  @override
  String get error => 'Lỗi';

  @override
  String get loading => 'Đang tải...';

  @override
  String get retry => 'Thử lại';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String get edit => 'Sửa';

  @override
  String get yes => 'Có';

  @override
  String get no => 'Không';

  @override
  String get ok => 'OK';

  @override
  String get done => 'Xong';

  @override
  String get back => 'Quay lại';

  @override
  String get next => 'Tiếp theo';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get filter => 'Lọc';

  @override
  String get sort => 'Sắp xếp';

  @override
  String get errorOccurred => 'Đã xảy ra lỗi';

  @override
  String get networkError => 'Lỗi mạng. Vui lòng kiểm tra kết nối.';

  @override
  String get authError => 'Lỗi xác thực';

  @override
  String get serverError => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get unknownError => 'Đã xảy ra lỗi không xác định';

  @override
  String get payment => 'Thanh toán';

  @override
  String get paymentInformation => 'Thông tin thanh toán';

  @override
  String get orderSummary => 'Tóm tắt đơn hàng';

  @override
  String get totalAmount => 'Tổng tiền';

  @override
  String get enterCardDetails => 'Nhập thông tin thẻ của bạn để hoàn tất thanh toán';

  @override
  String get cardNumber => 'Số thẻ';

  @override
  String get cardHolderName => 'Tên chủ thẻ';

  @override
  String get expiryDate => 'Ngày hết hạn';

  @override
  String get pleaseEnterCardNumber => 'Vui lòng nhập số thẻ';

  @override
  String get cardNumberMustBe16Digits => 'Số thẻ phải có 16 chữ số';

  @override
  String get pleaseEnterCardHolderName => 'Vui lòng nhập tên chủ thẻ';

  @override
  String get required => 'Bắt buộc';

  @override
  String get invalidDate => 'Ngày không hợp lệ';

  @override
  String get invalidCVV => 'CVV không hợp lệ';

  @override
  String get securePaymentInfo => 'Thanh toán an toàn với mã hóa SSL. Thông tin thẻ của bạn được bảo mật.';

  @override
  String get payNow => 'Thanh toán';

  @override
  String get paymentSuccessful => 'Thanh toán thành công!';

  @override
  String get demoMode => 'Chế độ Demo';

  @override
  String get demoPaymentInfo => 'Đây là chế độ demo. Bạn có thể nhập bất kỳ thông tin thẻ nào (16 số, tên, MM/YY, CVV 3 số) để hoàn tất thanh toán.';

  @override
  String get courseAddedToMyLearning => 'Khóa học đã được thêm vào \'Khóa học của tôi\'!';

  @override
  String get goToMyLearningToStartLearning => 'Vào tab \'Khóa học của tôi\' ở trang chủ để bắt đầu học nhé!';

  @override
  String get backToHome => 'Về trang chủ';
}
