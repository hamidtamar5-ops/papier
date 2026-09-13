// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'الآجال';

  @override
  String get settings => 'الإعدادات';

  @override
  String get addDocument => 'إضافة وثيقة';

  @override
  String errorWithMessage(String error) {
    return 'خطأ: $error';
  }

  @override
  String get noDocsForPerson => 'لا توجد وثائق لهذا الشخص.';

  @override
  String get sectionRenew => 'يجب تجديدها';

  @override
  String get sectionWatch => 'قريبة';

  @override
  String get sectionOk => 'سارية';

  @override
  String get deleteConfirmTitle => 'حذف؟';

  @override
  String deleteDocumentBody(String label) {
    return 'إزالة «$label» من القائمة.';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get nextDeadline => 'أقرب أجل';

  @override
  String get filterAll => 'الكل';

  @override
  String get emptyTitle => 'لا توجد وثائق بعد';

  @override
  String get emptySubtitle =>
      'أضف تاريخًا (بطاقة هوية، جواز سفر، فحص فني، تأمين…). لا يُطلب أي صورة.';

  @override
  String get statusOk => 'ساري';

  @override
  String get statusSoon => 'قريبًا';

  @override
  String get statusOverdue => 'منتهٍ';

  @override
  String get expiredYesterday => 'انتهى أمس';

  @override
  String expiredDays(int count) {
    return 'انتهى منذ $count يومًا';
  }

  @override
  String get expiresToday => 'ينتهي اليوم';

  @override
  String get inOneDay => 'خلال يوم واحد';

  @override
  String inDays(int count) {
    return 'خلال $count يومًا';
  }

  @override
  String get digestTitleRenew => 'وثائق يجب تجديدها';

  @override
  String get digestTitleToday => 'ينتهي اليوم';

  @override
  String get digestTitleSoon => 'أجل قريب';

  @override
  String digestBodyOneOverdue(String label) {
    return '$label منتهية الصلاحية.';
  }

  @override
  String digestBodyOneToday(String label) {
    return '$label ينتهي اليوم.';
  }

  @override
  String digestBodyOneSoon(String label) {
    return '$label ينتهي خلال أقل من 7 أيام.';
  }

  @override
  String get digestPartOneOverdue => 'وثيقة واحدة منتهية';

  @override
  String digestPartManyOverdue(int count) {
    return '$count وثائق منتهية';
  }

  @override
  String get digestPartOneToday => 'واحدة اليوم';

  @override
  String digestPartManyToday(int count) {
    return '$count اليوم';
  }

  @override
  String get digestPartOneSoon => 'واحدة خلال أقل من 7 أيام';

  @override
  String digestPartManySoon(int count) {
    return '$count خلال أقل من 7 أيام';
  }

  @override
  String get aDocument => 'وثيقة';

  @override
  String get addPaper => 'إضافة وثيقة';

  @override
  String get edit => 'تعديل';

  @override
  String get documentType => 'نوع الوثيقة';

  @override
  String get details => 'التفاصيل';

  @override
  String get labelField => 'الاسم';

  @override
  String get holder => 'صاحب الوثيقة';

  @override
  String get computeFromStart => 'الحساب من تاريخ البداية';

  @override
  String get startDate => 'تاريخ البداية';

  @override
  String get expirationDate => 'تاريخ الانتهاء';

  @override
  String get choose => 'اختيار';

  @override
  String get alertsAndReminders => 'التنبيهات والتذكيرات';

  @override
  String get reminderHint =>
      'إشعار صباحًا عند الساعة 9، إضافةً إلى تنبيه يوم الاستحقاق.';

  @override
  String get notes => 'ملاحظات';

  @override
  String get notesHint => 'ملاحظات (اختياري، بدون رقم الوثيقة)';

  @override
  String get save => 'حفظ';

  @override
  String get chooseHolderAndDate => 'اختر صاحب الوثيقة وتاريخًا.';

  @override
  String get kindCni => 'بطاقة الهوية';

  @override
  String get kindPasseport => 'جواز السفر';

  @override
  String get kindPermis => 'رخصة القيادة';

  @override
  String get kindCarteVitale => 'بطاقة التأمين الصحي';

  @override
  String get kindCarteGrise => 'بطاقة السيارة';

  @override
  String get kindControleTechnique => 'الفحص الفني';

  @override
  String get kindAssuranceAuto => 'تأمين السيارة';

  @override
  String get kindPersonnalise => 'وثيقة أخرى';

  @override
  String get hintCni =>
      'أدخل تاريخ الانتهاء المكتوب على البطاقة. المدة المعتادة: 10 سنوات بعد الإصدار — تحقق دائمًا من البطاقة.';

  @override
  String get hintPasseport =>
      'تاريخ الانتهاء على جواز السفر. غالبًا 10 سنوات (بالغ) أو 5 سنوات (قاصر).';

  @override
  String get hintPermis => 'أدخل التاريخ الظاهر على الرخصة. لا تُفترض أي مدة.';

  @override
  String get hintCarteVitale =>
      'أدخل التاريخ الذي تريد متابعته، إن كان معروفًا.';

  @override
  String get hintCarteGrise =>
      'أدخل التاريخ المراد مراقبته (بدون مسح الشهادة).';

  @override
  String get hintControleTechnique =>
      'تاريخ الصلاحية، أو الحساب من آخر فحص (+سنتان، أو +4 سنوات إذا كانت المركبة جديدة).';

  @override
  String get hintAssuranceAuto =>
      'تاريخ الاستحقاق، أو +سنة واحدة من بداية العقد.';

  @override
  String get hintPersonnalise => 'اسم حر وتاريخ. بدون صورة، بدون رقم وثيقة.';

  @override
  String get offset2Years => '+ سنتان (قيد الاستعمال)';

  @override
  String get offset4Years => '+ 4 سنوات (مركبة جديدة)';

  @override
  String get offset1Year => '+ سنة واحدة';

  @override
  String get appearance => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get language => 'اللغة';

  @override
  String get languageSystem => 'لغة الهاتف';

  @override
  String get languageFr => 'Français';

  @override
  String get languageEn => 'English';

  @override
  String get languageEs => 'Español';

  @override
  String get languageDe => 'Deutsch';

  @override
  String get languageAr => 'العربية';

  @override
  String get alertsAndNotifications => 'التنبيهات والإشعارات';

  @override
  String get householdHolders => 'أفراد الأسرة';

  @override
  String get addHolder => 'إضافة صاحب وثيقة';

  @override
  String get iapNote =>
      'الأسرة غير المحدودة وتصدير PDF مخططان كعملية شراء لمرة واحدة. في الإصدار 1، كل شيء مفتوح.';

  @override
  String get backup => 'النسخ الاحتياطي';

  @override
  String get exportJson => 'تصدير JSON';

  @override
  String get exportJsonSubtitle => 'ملف محلي، بدون صور.';

  @override
  String get importJson => 'استيراد JSON';

  @override
  String get importDone => 'اكتمل الاستيراد.';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get privacyText =>
      'تبقى التواريخ على هذا الجهاز. لا حساب، لا تحليلات، لا صورة هوية. هذا التطبيق ليس خدمة إدارية. قد تظهر إعلانات Google AdMob؛ في المنطقة الاقتصادية الأوروبية يُطلب موافقتك.';

  @override
  String get privacyAdsTitle => 'الإعلانات';

  @override
  String get privacyAdsBody =>
      'قد يظهر شريط إعلاني أسفل الصفحة الرئيسية. لا تُعرض إعلان بيني إلا بعد الحفظ، وليس عند التشغيل أو عند مغادرة التطبيق.';

  @override
  String get manageAdsConsent => 'إدارة موافقة الإعلانات';

  @override
  String get deleteHolderTitle => 'حذف صاحب الوثيقة؟';

  @override
  String deleteHolderBody(String name) {
    return 'سيتم حذف «$name» ووثائقه.';
  }

  @override
  String get newHolder => 'صاحب وثيقة جديد';

  @override
  String get firstName => 'الاسم';

  @override
  String get ok => 'حسنًا';

  @override
  String get deviceAlerts => 'تنبيهات الجهاز';

  @override
  String get deviceAlertsSubtitle =>
      'تذكيرات الساعة 9 صباحًا وتنبيه يوم الاستحقاق.';

  @override
  String get notifsDisabled => 'الإشعارات معطّلة لهذا التطبيق.';

  @override
  String get allowAlerts => 'السماح بالتنبيهات';

  @override
  String get defaultReminders => 'التذكيرات الافتراضية';

  @override
  String get testNotifSent => 'تم إرسال إشعار تجريبي.';

  @override
  String get sendTestNotif => 'إرسال إشعار تجريبي';

  @override
  String notifExpiresToday(String date) {
    return 'ينتهي اليوم ($date).';
  }

  @override
  String notifDueInDays(int days, String date) {
    return 'ينتهي خلال $days يومًا ($date).';
  }

  @override
  String get testNotifTitle => 'تنبيهات الآجال';

  @override
  String get testNotifBody => 'الإشعارات تعمل. سيتم تذكيرك قبل كل تاريخ.';

  @override
  String get widgetNoDeadline => 'لا أجل';

  @override
  String get widgetAddPaper => 'أضف وثيقة';

  @override
  String get deleteTooltip => 'حذف';
}
