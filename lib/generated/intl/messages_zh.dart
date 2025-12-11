// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(msg) => "${msg} 版权所有。";

  static String m1(msg) => "您确定要从应用中${msg}吗？";

  static String m2(msg) => "错误：${msg}";

  static String m3(length) => "必须至少为 ${length} 个字符";

  static String m4(secondsRemaining) => "00:${secondsRemaining} 后重新发送验证码";

  static String m5(length) => "至少使用 ${length} 个字符";

  static String m6(method) => "通过 ${method} 支付。希望您旅途愉快！别忘了留下评分。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("账户"),
    "activity": MessageLookupByLibrary.simpleMessage("活动"),
    "add_balance_to_your_wallet": MessageLookupByLibrary.simpleMessage(
      "向您的钱包充值",
    ),
    "add_coupon_code": MessageLookupByLibrary.simpleMessage("添加优惠码"),
    "add_new": MessageLookupByLibrary.simpleMessage("新增"),
    "add_payment_gateway": MessageLookupByLibrary.simpleMessage("添加支付网关"),
    "add_wallet": MessageLookupByLibrary.simpleMessage("添加钱包"),
    "affordableConvenient": MessageLookupByLibrary.simpleMessage("实惠又方便"),
    "all_rights_reserved": m0,
    "allow": MessageLookupByLibrary.simpleMessage("允许"),
    "app_encountered_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "应用程序遇到意外错误并被迫关闭。这可能是由于设备内存不足、应用程序中的错误或文件损坏引起的。如果问题持续，请重启应用或重新安装。",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("应用"),
    "are_you_sure_msg": m1,
    "bad_certificate_with_api_server": MessageLookupByLibrary.simpleMessage(
      "API 服务器证书错误",
    ),
    "bad_request": MessageLookupByLibrary.simpleMessage("错误请求"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "cancel_ride": MessageLookupByLibrary.simpleMessage("取消行程"),
    "cancel_subtitle": MessageLookupByLibrary.simpleMessage("请告诉我们您取消行程的原因。"),
    "cancel_the_ride": MessageLookupByLibrary.simpleMessage("取消行程"),
    "cancel_title": MessageLookupByLibrary.simpleMessage("请告诉我们您取消行程的原因"),
    "card_number": MessageLookupByLibrary.simpleMessage("卡号"),
    "cardholder_name": MessageLookupByLibrary.simpleMessage("持卡人姓名"),
    "change_password": MessageLookupByLibrary.simpleMessage("更改密码"),
    "choose_ride_title": MessageLookupByLibrary.simpleMessage("选择适合您的行程"),
    "close": MessageLookupByLibrary.simpleMessage("关闭"),
    "complete_ride": MessageLookupByLibrary.simpleMessage("完成行程"),
    "confirm": MessageLookupByLibrary.simpleMessage("确认"),
    "confirm_destination": MessageLookupByLibrary.simpleMessage("确认目的地"),
    "confirm_new_password": MessageLookupByLibrary.simpleMessage("确认新密码"),
    "confirm_password": MessageLookupByLibrary.simpleMessage("确认密码"),
    "confirm_pay": MessageLookupByLibrary.simpleMessage("确认付款"),
    "confirm_pickup": MessageLookupByLibrary.simpleMessage("确认上车点"),
    "connection_error_with_api_server": MessageLookupByLibrary.simpleMessage(
      "与 API 服务器连接错误",
    ),
    "connection_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "与 API 服务器连接超时",
    ),
    "contact_support": MessageLookupByLibrary.simpleMessage("联系支持"),
    "country": MessageLookupByLibrary.simpleMessage("国家"),
    "coupon_description": MessageLookupByLibrary.simpleMessage(
      "请输入有效的优惠码以获取行程折扣。",
    ),
    "current_password": MessageLookupByLibrary.simpleMessage("当前密码"),
    "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "delete_account": MessageLookupByLibrary.simpleMessage("删除账户"),
    "delete_account_confirmation": MessageLookupByLibrary.simpleMessage(
      "您确定要删除您的账户吗？",
    ),
    "delete_account_warning": MessageLookupByLibrary.simpleMessage(
      "此操作是永久性的，无法撤销。",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("目的地"),
    "details": MessageLookupByLibrary.simpleMessage("详情"),
    "discount": MessageLookupByLibrary.simpleMessage("折扣"),
    "downloadReceipt": MessageLookupByLibrary.simpleMessage("下载收据"),
    "drag_map_adjust_location": MessageLookupByLibrary.simpleMessage(
      "拖动地图以调整位置",
    ),
    "driver_arrived": MessageLookupByLibrary.simpleMessage(
      "您的司机已到达接送地点，请立即前往。",
    ),
    "driver_heading_to_you": MessageLookupByLibrary.simpleMessage(
      "您的司机正在前往您的位置，请准备好。",
    ),
    "either_phone_number_is_null_or_password_is_empty":
        MessageLookupByLibrary.simpleMessage("电话号码为空或密码为空"),
    "email": MessageLookupByLibrary.simpleMessage("电子邮件"),
    "email_label": MessageLookupByLibrary.simpleMessage("电子邮件"),
    "enterPhoneDes": MessageLookupByLibrary.simpleMessage(
      "请输入您的电话号码以继续出行并保持更新。",
    ),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage("请输入电话号码"),
    "enter_3_digit_cvv": MessageLookupByLibrary.simpleMessage("输入3位数CVV"),
    "enter_a_valid_amount": MessageLookupByLibrary.simpleMessage("输入有效金额"),
    "enter_amount": MessageLookupByLibrary.simpleMessage("输入金额"),
    "enter_cardholder_name": MessageLookupByLibrary.simpleMessage("输入持卡人姓名"),
    "enter_coupon_code": MessageLookupByLibrary.simpleMessage("输入优惠码"),
    "enter_destination": MessageLookupByLibrary.simpleMessage("请输入目的地"),
    "enter_experience": MessageLookupByLibrary.simpleMessage("输入您的体验！"),
    "enter_pickup_point": MessageLookupByLibrary.simpleMessage("请输入上车点"),
    "enter_stop_point": MessageLookupByLibrary.simpleMessage("请输入中途站点"),
    "enter_valid_card_number": MessageLookupByLibrary.simpleMessage("输入有效的卡号"),
    "error_with_msg": m2,
    "estimated_time": MessageLookupByLibrary.simpleMessage("预计时间"),
    "exit": MessageLookupByLibrary.simpleMessage("退出"),
    "exp_date": MessageLookupByLibrary.simpleMessage("到期日期"),
    "fetching_address": MessageLookupByLibrary.simpleMessage("正在获取地址..."),
    "field_required": MessageLookupByLibrary.simpleMessage("此字段是必填项"),
    "find_you_faster": MessageLookupByLibrary.simpleMessage("让我们更快找到你！"),
    "find_you_faster_msg": MessageLookupByLibrary.simpleMessage(
      "启用位置访问以快速匹配附近的司机。",
    ),
    "forbidden_access_please_login_again": MessageLookupByLibrary.simpleMessage(
      "禁止访问。请重新登录。",
    ),
    "form_is_not_valid": MessageLookupByLibrary.simpleMessage("表单无效"),
    "full_name": MessageLookupByLibrary.simpleMessage("全名"),
    "gender": MessageLookupByLibrary.simpleMessage("性别"),
    "gender_female": MessageLookupByLibrary.simpleMessage("女"),
    "gender_label": MessageLookupByLibrary.simpleMessage("性别"),
    "gender_male": MessageLookupByLibrary.simpleMessage("男"),
    "gender_other": MessageLookupByLibrary.simpleMessage("其他"),
    "gender_required": MessageLookupByLibrary.simpleMessage("性别为必填项"),
    "gender_select": MessageLookupByLibrary.simpleMessage("选择性别"),
    "getStarted": MessageLookupByLibrary.simpleMessage("开始使用"),
    "go_back_to_ride": MessageLookupByLibrary.simpleMessage("返回行程"),
    "grant_permission": MessageLookupByLibrary.simpleMessage("授予权限"),
    "helloText": MessageLookupByLibrary.simpleMessage("你好..."),
    "home": MessageLookupByLibrary.simpleMessage("首页"),
    "initializing": MessageLookupByLibrary.simpleMessage("初始化中..."),
    "insertAllData": MessageLookupByLibrary.simpleMessage("请输入所有数据"),
    "inside_car": MessageLookupByLibrary.simpleMessage("您已上车，请舒适坐好"),
    "internal_server_error": MessageLookupByLibrary.simpleMessage("服务器内部错误"),
    "issueSubmitted": MessageLookupByLibrary.simpleMessage("您的问题已成功提交"),
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "letsGo": MessageLookupByLibrary.simpleMessage("出发吧"),
    "location_permission_msg": MessageLookupByLibrary.simpleMessage(
      "请启用位置访问权限以使用此功能。",
    ),
    "location_permission_needed": MessageLookupByLibrary.simpleMessage(
      "需要位置权限",
    ),
    "log_out": MessageLookupByLibrary.simpleMessage("退出登录"),
    "loggingInSomewhereElse": MessageLookupByLibrary.simpleMessage("正在其他设备登录"),
    "login": MessageLookupByLibrary.simpleMessage("登录"),
    "loginSignup": MessageLookupByLibrary.simpleMessage("登录 / 注册"),
    "login_with_your_password": MessageLookupByLibrary.simpleMessage(
      "使用您的密码登录",
    ),
    "min_length_error": m3,
    "mobile_number": MessageLookupByLibrary.simpleMessage("手机号码"),
    "my_profile": MessageLookupByLibrary.simpleMessage("我的资料"),
    "name_label": MessageLookupByLibrary.simpleMessage("姓名"),
    "new_password": MessageLookupByLibrary.simpleMessage("新密码"),
    "no_address_found": MessageLookupByLibrary.simpleMessage("未找到地址"),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage("还没有卡片！"),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage("无网络连接。"),
    "no_internet_connection_please_check": MessageLookupByLibrary.simpleMessage(
      "无网络连接。请检查您的网络。",
    ),
    "no_payment_methods_available": MessageLookupByLibrary.simpleMessage(
      "无可用的支付方式",
    ),
    "no_rides_yet": MessageLookupByLibrary.simpleMessage("暂无行程。"),
    "no_service_available": MessageLookupByLibrary.simpleMessage("暂无服务"),
    "no_wallet_data_available": MessageLookupByLibrary.simpleMessage("没有钱包数据"),
    "or_select_avatar": MessageLookupByLibrary.simpleMessage("或从下面的列表中选择一个头像："),
    "otp_enter_title": MessageLookupByLibrary.simpleMessage("输入您的验证码"),
    "otp_input_hint": MessageLookupByLibrary.simpleMessage("输入验证码"),
    "otp_resend": MessageLookupByLibrary.simpleMessage("重新发送"),
    "otp_resend_timer": m4,
    "otp_save_button": MessageLookupByLibrary.simpleMessage("保存"),
    "otp_sent_message": MessageLookupByLibrary.simpleMessage(
      "我们已将验证码发送到您的手机号码",
    ),
    "otp_title_short": MessageLookupByLibrary.simpleMessage("验证码"),
    "password_hint": MessageLookupByLibrary.simpleMessage("设置一个强密码"),
    "password_label": MessageLookupByLibrary.simpleMessage("密码"),
    "password_mismatch": MessageLookupByLibrary.simpleMessage("密码不匹配。"),
    "password_requirements": m5,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("支付方式"),
    "payment_completed": MessageLookupByLibrary.simpleMessage("谢谢！付款完成"),
    "payment_confirmation": m6,
    "payment_gateway": MessageLookupByLibrary.simpleMessage("支付网关"),
    "phoneMinLengthError": MessageLookupByLibrary.simpleMessage(
      "电话号码至少应包含6位数字",
    ),
    "phoneNo": MessageLookupByLibrary.simpleMessage("电话号码"),
    "pick_a_date": MessageLookupByLibrary.simpleMessage("选择日期"),
    "pickup": MessageLookupByLibrary.simpleMessage("上车点"),
    "please_select_payment_type": MessageLookupByLibrary.simpleMessage(
      "请选择支付类型",
    ),
    "please_wait": MessageLookupByLibrary.simpleMessage("请稍候..."),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "proceedNext": MessageLookupByLibrary.simpleMessage("继续下一步"),
    "profile_info_description": MessageLookupByLibrary.simpleMessage(
      "输入您的详细信息以完成个人资料并提升体验。",
    ),
    "profile_info_subtitle": MessageLookupByLibrary.simpleMessage("添加个人信息"),
    "profile_info_title": MessageLookupByLibrary.simpleMessage("个人信息"),
    "reason_changed_mind": MessageLookupByLibrary.simpleMessage("我改变了主意。"),
    "reason_driver_late": MessageLookupByLibrary.simpleMessage("司机花的时间太长了。"),
    "reason_mismatch_info": MessageLookupByLibrary.simpleMessage("司机/车辆信息不匹配。"),
    "reason_other": MessageLookupByLibrary.simpleMessage("其他"),
    "reason_wrong_location": MessageLookupByLibrary.simpleMessage("接载位置错误。"),
    "receive_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "从 API 服务器接收超时",
    ),
    "received_invalid_response_from_server":
        MessageLookupByLibrary.simpleMessage("从服务器接收到无效响应。"),
    "reportIssue": MessageLookupByLibrary.simpleMessage("报告问题"),
    "reportIssueSubtitle": MessageLookupByLibrary.simpleMessage(
      "告诉我们发生了什么。我们会立即处理。",
    ),
    "reportIssueTitle": MessageLookupByLibrary.simpleMessage("出现问题了吗？报告一个问题"),
    "reportType": MessageLookupByLibrary.simpleMessage("报告类型"),
    "requestEntityTooLarge": MessageLookupByLibrary.simpleMessage("请求实体过大"),
    "request_timed_out_please_try_again": MessageLookupByLibrary.simpleMessage(
      "请求超时。请再试一次。",
    ),
    "request_to_api_server_was_cancelled": MessageLookupByLibrary.simpleMessage(
      "请求已被取消",
    ),
    "resource_not_found": MessageLookupByLibrary.simpleMessage("资源未找到。"),
    "rideBookingEase": MessageLookupByLibrary.simpleMessage(
      "享受优惠价格、多种乘车选择和一键式轻松预订。",
    ),
    "rideCharge": MessageLookupByLibrary.simpleMessage("车费"),
    "rideDetails": MessageLookupByLibrary.simpleMessage("行程详情"),
    "rideFeatures": MessageLookupByLibrary.simpleMessage(
      "实时追踪、认证司机和安全支付，确保您无忧出行。",
    ),
    "rideYourWay": MessageLookupByLibrary.simpleMessage("您的出行，由您掌控"),
    "ride_complete": MessageLookupByLibrary.simpleMessage("您的行程已完成"),
    "ride_feedback_prompt": MessageLookupByLibrary.simpleMessage(
      "希望您有愉快的旅程，请完成付款并评分。",
    ),
    "ride_in_progress": MessageLookupByLibrary.simpleMessage("请放松，司机将带您前往目的地。"),
    "ride_on_the_way": MessageLookupByLibrary.simpleMessage("您的行程正在前往中"),
    "ride_preferences": MessageLookupByLibrary.simpleMessage("行程偏好"),
    "ride_preferences_description": MessageLookupByLibrary.simpleMessage(
      "请选择最适合您需求的行程类型。",
    ),
    "ride_ready": MessageLookupByLibrary.simpleMessage("您的行程已准备好！"),
    "ride_requested": MessageLookupByLibrary.simpleMessage("行程已请求"),
    "ride_started": MessageLookupByLibrary.simpleMessage("您的行程已开始"),
    "safeSecure": MessageLookupByLibrary.simpleMessage("安全可靠的出行"),
    "safetyPriority": MessageLookupByLibrary.simpleMessage("您的安全，我们的首要任务"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "search_destination": MessageLookupByLibrary.simpleMessage("搜索目的地"),
    "searching_for_driver": MessageLookupByLibrary.simpleMessage("正在搜索在线司机.."),
    "see_you_next_ride": MessageLookupByLibrary.simpleMessage("期待您下次再来搭乘！"),
    "selectReportType": MessageLookupByLibrary.simpleMessage("选择报告类型"),
    "select_a_country": MessageLookupByLibrary.simpleMessage("选择一个国家"),
    "select_card_type": MessageLookupByLibrary.simpleMessage("选择卡类型"),
    "select_payment_method": MessageLookupByLibrary.simpleMessage("选择支付方式"),
    "select_pickup_location": MessageLookupByLibrary.simpleMessage("选择上车地点"),
    "select_profile_image": MessageLookupByLibrary.simpleMessage("选择个人头像"),
    "select_service": MessageLookupByLibrary.simpleMessage("请选择服务！"),
    "send_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "向 API 服务器发送超时",
    ),
    "service_charge": MessageLookupByLibrary.simpleMessage("服务费"),
    "services": MessageLookupByLibrary.simpleMessage("服务"),
    "share_experience": MessageLookupByLibrary.simpleMessage("分享您的体验！"),
    "skip": MessageLookupByLibrary.simpleMessage("跳过"),
    "skip_for_now": MessageLookupByLibrary.simpleMessage("暂时跳过"),
    "smartRideSavings": MessageLookupByLibrary.simpleMessage("智能出行，聪明省钱。"),
    "something_went_wrong": MessageLookupByLibrary.simpleMessage("出现错误"),
    "something_went_wrong_exclamation": MessageLookupByLibrary.simpleMessage(
      "出了点问题！",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("开始行程"),
    "status": MessageLookupByLibrary.simpleMessage("状态"),
    "stayOnThisDevice": MessageLookupByLibrary.simpleMessage("留在此设备上"),
    "stop_point": MessageLookupByLibrary.simpleMessage("中途站点"),
    "submit": MessageLookupByLibrary.simpleMessage("提交"),
    "terms_conditions": MessageLookupByLibrary.simpleMessage("条款和条件"),
    "textCopied": MessageLookupByLibrary.simpleMessage("文本已复制"),
    "thanksForReporting": MessageLookupByLibrary.simpleMessage(
      "感谢您的反馈。我们的团队会尽快查看您的问题并与您联系。",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("主题"),
    "today": MessageLookupByLibrary.simpleMessage("今天"),
    "top_up_your_wallet_securely_and_enjoy_seamless_payments":
        MessageLookupByLibrary.simpleMessage("安全地为您的钱包充值，享受无缝支付体验。"),
    "total_amount": MessageLookupByLibrary.simpleMessage("总金额"),
    "trips": MessageLookupByLibrary.simpleMessage("行程"),
    "type_a_message": MessageLookupByLibrary.simpleMessage("输入消息"),
    "unauthorized_access_please_login_again":
        MessageLookupByLibrary.simpleMessage("未授权访问。请重新登录。"),
    "unexpected_application_crash": MessageLookupByLibrary.simpleMessage(
      "应用程序意外崩溃",
    ),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage("发生意外错误"),
    "unexpected_response_format": MessageLookupByLibrary.simpleMessage(
      "意外的响应格式",
    ),
    "upload_image": MessageLookupByLibrary.simpleMessage("上传图片"),
    "use_otp_instead": MessageLookupByLibrary.simpleMessage("改用一次性密码（OTP）"),
    "use_your_password_here": MessageLookupByLibrary.simpleMessage("在此使用您的密码"),
    "validation_error": MessageLookupByLibrary.simpleMessage("验证错误"),
    "view_details": MessageLookupByLibrary.simpleMessage("查看详情"),
    "wait_message": MessageLookupByLibrary.simpleMessage(
      "我们正在为您联系最近的可用司机，请稍候。",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("钱包"),
    "wallet_balance": MessageLookupByLibrary.simpleMessage("钱包余额"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("欢迎回来！"),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "轻松出行触手可及。随时随地体验快速、可靠和安全的交通服务。",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage("欢迎使用 Ready Ride"),
    "writeIssueDetails": MessageLookupByLibrary.simpleMessage("填写问题详情"),
    "yourAccountAlreadyActive": MessageLookupByLibrary.simpleMessage(
      "您的账户已在另一台设备上登录。要在此使用，它将在另一台设备上退出登录。",
    ),
  };
}
