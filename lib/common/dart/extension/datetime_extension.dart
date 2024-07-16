import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('yyyy/MM/dd').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('dd/MM/yyyy HH:mm').format(this);

  String get relativeDays {
    // 오직 날짜만 비교 결과 : int
    final diffDays = difference(DateTime.now().onlyDate).inDays;
    // 비교한 날짜가 음수,양수인지 확인
    // 만약 음수라면 지난 날짜, 양수라면 앞으로 다가올 날짜
    final isNegative = diffDays.isNegative;

    // 비교를 위해 날짜 비교 결과 값(int) 지난날 체크 값(bool)을 가진 객체 생성
    final checkCondition = (diffDays, isNegative);
    return switch (checkCondition) {
      (0, _) => _tillToday, // 오늘 날짜
      (1, _) => _tillTomorrow, // 내일 날짜
      (_, true) => _dayPassed, // 과거 날짜
      _ => _dayLeft // 위 모두 아니라면 몇 일이 남았는지 표현 하는 함수
    };
  }

  DateTime get onlyDate {
    return DateTime(year, month, day);
  }

  String get _dayLeft => 'daysLeft'.tr(namedArgs: {
        "daysCount": difference(DateTime.now().onlyDate).inDays.toString()
      });
  String get _dayPassed => 'daysPassed'.tr(namedArgs: {
        "daysCount": difference(DateTime.now().onlyDate).inDays.abs().toString()
      });
  String get _tillToday => 'tillToday'.tr();

  String get _tillTomorrow => 'tillTomorrow'.tr();
}
