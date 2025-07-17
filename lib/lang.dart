import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Localization extends Translations {
  static const locale = Locale('en', 'US');
  static const fallbackLocale = Locale('en', 'US');

  static final langs = ['en', 'ar'];

  static final locales = [const Locale('en', 'US'), const Locale('ar', 'SA')];

  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'splashText': 'Safora',
      'welcome_to': 'Welcome to\n',
      'welcome': 'Welcome Back',
      'select_language': 'Select Language',
      'english': 'English',
      'arabic': 'Arabic',
      'select': 'Select',
      'signin_continue': 'Sign in as a Supplier',
      'contact_number': 'Contact Number',
      'enter_your_contact_number': 'Enter your contact number',
      'enter_your_password': 'Enter your password',
      'enter_password': 'Enter password',
      'forgot': 'Forgot Password?',
      'signin': 'Sign In',
      'email': 'Email',
      'enter_email': 'Enter email address',
      'password': 'Password',
      'submit': 'Submit',
      'error': 'Error',
      'success': 'Success',

      // for forgot pass screen
      'forgot_pass': 'Forgot Password',
      'reset_pass': 'Reset Password',
      'enter_your_contact_des':
          'Enter your contact number to receive\na password reset code',
      'send_code': 'Send Reset Code',

      // otp screen
      'verify_otp': 'Verify OTP',
      'verification': 'Verification Code',
      'sent': 'We have send the verification code to',
      'no_code': 'Didn\'t received code?',
      'verify_btn': 'Verify & Proceed',
      'second': 'Resend in 28 sec',

      // dashboard
      'add_client_': 'Add Client',
      'dashboard': 'Dashboard',
      'no_client': 'No Clients Yet',
      'no_supplier': 'No Suppliers Yet',
      'add_client': 'Add your first client by clicking the + button',
      'add_client_btn': 'Add Client',

      // for add client screen
      'addclient_heading': 'Add New Client',
      'update_client': 'Update Client',
      'client_info': 'Client Information',
      'client_profile': 'Profile Image',
      'first_name': 'First Name',
      'enter_first_name': 'Enter first name',
      'last_name': 'Last Name',
      'enter_last_name': 'Enter last name',
      'address': 'Address',
      'enter_address': 'Enter residential address',
      'business_heading': 'Business Information',
      'business_logo': 'Business Logo',
      'business_name': 'Business Name',
      'enter_businsess_name': 'Enter business name',
      'office_address': 'Office Address',
      'enter_office_address': 'Enter office address',
      'add_client_btn': 'Create Client',
      'update_client_btn': 'Update Client',
      'error_message': 'Please fill all required fields',
      'error_message_image': 'Please select both profile and business images',
      'failed_update': 'Failed to update client',
      'success_message': 'Client information saved successfully',
      'success_client_update': 'Client information Update successfully',

      // for dashboard having data
      'my_client': 'My Clients',
      'name': 'Sewii mirza',
      'gold': 'Inventory',
      'search': 'Search client here..',
      'search_label': 'Search',
      // sample
      'example_phone_number': '0852368444',
      'example_email': 'sewii@gmail.com',
      'example_address': 'pakistan lahore',

      /// for dialog box
      'delete_client': 'Delete Client',
      'confirm_delete_client': 'Are your sure you want to delete',
      'delete': 'Delete',
      'cancel': 'Cancel',

      //  for welcome back
      'welcome': 'Welcome Back',
      'login_success': 'Login Successful',
      'successful': 'Successful',
      'login_as_a_supplier': 'Login Successful as a Supplier',
      'login_as_a_client': 'Login Successful as a Client',
      'login_failed': 'Login failed',

      // for lading
      'loading': 'Please wait',

      // for setting screen
      'setting': 'Profile',
      'setting-scr': 'Settings',
      'logout': 'Logout',
      'try_again': 'try again',

      // delete client
      'delete_client': 'Delete Client',
      'delete_client_confirm': 'Are you sure you want to delete this client?',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'success': 'Success',
      'client_deleted': 'Client deleted successfully',
      'error': 'Error',
      'delete_failed': 'Failed to delete client',

      'profile': 'Gold',
      'choose_language': 'Choose language for further continue',

      // inventory screen
      'add_gold': 'Add Record',
      'select_client': 'Select Client',
      'gold_type': 'Gold Type',
      'received_date': 'Received Date',
      'received_gold': 'Gold Received',
      'net_weight': 'Net Weight',
      'tehleel': 'Tehleel',
      'gold_21k': 'Gold 21K',
      'rate': 'Rate',
      'total_value': 'Total Value',
      'deliver_date': 'Deliver Date',
      'gold_given': 'Gold Given',
      'deliver_netWeight': 'Delivery Net Weight',
      'delivery_tehleel': 'Delivery Tehleel',
      'image': 'Image',
      'choose_image': 'Choose Image',
      'table_id': 'Id',
      'received_rate': 'Received Rate',
      'receive_amount_SAR': ' Receive Amount SAR',
      'sample_pic': 'Sample Picture',

      // gold card widget
      'gold_contact': 'Client Contact Number : ',
      'gold_address': 'Address : ',
      'gold_gold': 'Gold 21K Balance : ',
      'gold_SAR_cash': 'Cash SAR Balance : ',
      'gold_debit': 'Total Debited Cash Gold 21K : ',
      'gold_credit': 'Total Credited Cash Gold 21K : ',
      'gold_total_debit': 'Total Debit Cash : ',
      'gold_total_credit': 'Total Credit Cash : ',
      'export': 'Import',
      'export_data': 'Import File',
      'action' : 'Action',
      'update_gold': 'Update Gold',
      'update_gold_btn': 'Update',
      'recievedd_date': 'Received Date',
      'recievedd_gold' :'Received Gold',
      'gold_success_update' : 'Gold updates Successfully',
      'download' : 'Download'

    },

    'ar': {
      'splashText': 'صفورا',
      'welcome_to': 'مرحباً بك في\n',
      'welcome': 'مرحباً بعودتك',
      'select_language': 'اختر اللغة',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'select': 'اختيار',
      'signin_continue': 'تسجيل الدخول كمورد',
      'contact_number': 'رقم الاتصال',
      'enter_your_contact_number': 'أدخل رقم الاتصال',
      'enter_your_password': 'أدخل كلمة المرور',
      'enter_password': 'أدخل كلمة المرور',
      'forgot': 'نسيت كلمة المرور؟',
      'signin': 'تسجيل الدخول',
      'email': 'البريد الإلكتروني',
      'enter_email': 'أدخل البريد الإلكتروني',
      'password': 'كلمة المرور',
      'submit': 'إرسال',
      'error': 'خطأ',
      'success': 'نجاح',

      'forgot_pass': 'نسيت كلمة المرور',
      'reset_pass': 'إعادة تعيين كلمة المرور',
      'enter_your_contact_des':
          'أدخل رقم الاتصال لتلقي\nرمز إعادة تعيين كلمة المرور',
      'send_code': 'إرسال رمز إعادة التعيين',

      'verify_otp': 'التحقق من الرمز',
      'verification': 'رمز التحقق',
      'sent': 'لقد أرسلنا رمز التحقق إلى',
      'no_code': 'لم تتلق الرمز؟',
      'verify_btn': 'تحقق ومتابعة',
      'second': 'إعادة الإرسال خلال 28 ثانية',

      'add_client_': 'إضافة عميل',
      'dashboard': 'لوحة التحكم',
      'no_client': 'لا يوجد عملاء حتى الآن',
      'no_supplier': 'لا يوجد موردين حتى الآن',
      'add_client': 'أضف أول عميل لك بالنقر على زر +',
      'add_client_btn': 'إضافة عميل',

      'addclient_heading': 'إضافة عميل جديد',
      'update_client': 'تحديث العميل',
      'client_info': 'معلومات العميل',
      'client_profile': 'صورة الملف الشخصي',
      'first_name': 'الاسم الأول',
      'enter_first_name': 'أدخل الاسم الأول',
      'last_name': 'اسم العائلة',
      'enter_last_name': 'أدخل اسم العائلة',
      'address': 'العنوان',
      'enter_address': 'أدخل العنوان السكني',
      'business_heading': 'معلومات العمل',
      'business_logo': 'شعار العمل',
      'business_name': 'اسم العمل',
      'enter_businsess_name': 'أدخل اسم العمل',
      'office_address': 'عنوان المكتب',
      'enter_office_address': 'أدخل عنوان المكتب',
      'add_client_btn': 'إنشاء عميل',
      'update_client_btn': 'تحديث العميل',
      'error_message': 'يرجى ملء جميع الحقول المطلوبة',
      'error_message_image': 'يرجى اختيار صورة الملف الشخصي وصورة العمل',
      'failed_update': 'فشل تحديث العميل',
      'success_message': 'تم حفظ معلومات العميل بنجاح',
      'success_client_update': 'تم تحديث معلومات العميل بنجاح',

      'my_client': 'عملائي',
      'name': 'سويي ميرزا',
      'gold': 'المخزون',
      'search': 'ابحث عن عميل هنا..',
      'search_label': 'بحث',

      'example_phone_number': '٠٨٥٢٣٦٨٤٤٤',
      'example_email': 'sewii@gmail.com',
      'example_address': 'باكستان لاهور',

      'delete_client': 'حذف العميل',
      'confirm_delete_client': 'هل أنت متأكد أنك تريد الحذف',
      'delete': 'حذف',
      'cancel': 'إلغاء',

      'welcome': 'مرحباً بعودتك',
      'login_success': 'تم تسجيل الدخول بنجاح',
      'successful': 'ناجح',
      'login_as_a_supplier': 'تم تسجيل الدخول بنجاح كمورد',
      'login_as_a_client': 'تم تسجيل الدخول بنجاح كعميل',
      'login_failed': 'فشل تسجيل الدخول',

      'loading': 'يرجى الانتظار',

      'setting': 'الملف الشخصي',
      'setting-scr': 'الإعدادات',
      'logout': 'تسجيل الخروج',

      'client_deleted': 'تم حذف العميل بنجاح',
      'delete_failed': 'فشل حذف العميل',

      'profile': 'الذهب',
      'choose_language': 'اختر اللغة للمتابعة',

      // inventory screen
      'add_gold': 'إضافة سجل',
      'select_client': 'اختر العميل',
      'gold_type': 'نوع الذهب',
      'received_date': 'تاريخ الاستلام',
      'received_gold': 'الذهب المستلم',
      'net_weight': 'الوزن الصافي',
      'tehleel': 'التحليل',
      'gold_21k': 'ذهب عيار ٢١',
      'rate': 'السعر',
      'total_value': 'القيمة الإجمالية',
      'deliver_date': 'تاريخ التسليم',
      'gold_given': 'الذهب المسلم',
      'deliver_netWeight': 'الوزن الصافي للتسليم',
      'delivery_tehleel': 'تحليل التسليم',
      'image': 'صورة',
      'choose_image': 'اختر صورة',
      'table_id': 'رقم المعرف',
      'received_rate': 'سعر الاستلام',
      'receive_amount_SAR': 'المبلغ المستلم بالريال',
      'sample_pic': 'صورة العينة',

      // gold card widget
      'gold_contact': 'رقم اتصال العميل : ',
      'gold_address': 'العنوان : ',
      'gold_gold': 'رصيد الذهب عيار ٢١ : ',
      'gold_SAR_cash': 'رصيد النقد بالريال : ',
      'gold_debit': 'إجمالي الذهب المدين عيار ٢١ : ',
      'gold_credit': 'إجمالي الذهب الدائن عيار ٢١ : ',
      'gold_total_debit': 'إجمالي النقد المدين : ',
      'gold_total_credit': 'إجمالي النقد الدائن : ',
      'export': 'استيراد',
      'export_data': 'استيراد ملف',
      'action' : 'الإجراء',
      'recievedd_date': 'تاريخ الاستلام',
      'recievedd_gold': 'الذهب المستلم',
      'gold_success_update': 'تم تحديث الذهب بنجاح',
      'download': 'تحميل',
    },
  };

  static void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  static Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return locale;
  }
}
