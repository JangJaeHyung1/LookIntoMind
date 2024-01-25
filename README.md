#마음보기 - 대분류를 통해 쉽게 본인의 감정을 선택하고, 총 116개의 감정어로 하루를 표현하는 '감정 다이어리 어플'입니다.

앱스토어 링크 - https://apps.apple.com/kr/app/id6473691443



### 1. 기술스택

|적용|기술|
|---|---|
|Project|MVVM, RxSwift|
|UI|SnapKit, FSCalendar|
|Database|Realm|

### 2. 기능
- 일기를 작성하다 취소할 때, 임시 저장 여부를 확인하여 불러오기 기능을 통해재작성을 돕는 UX를 제공하고 있습니다.
- 작성된 일기 리스트를 보여줄 때, tableView의 lastIndex가 willDisplay되면 fetch되도록 하는 infinite scroll 기능을 제공하고 있습니다.
- UITabBarController의 하단탭 UI를 사용하여 달력 페이지, 일기 리스트 페이지, 기록 통계 페이지 3가지 페이지를 제공하고 있습니다.
- 월별 기록 통계 페이지에서 기록한 감정의 비율을 한눈에 확인할 수 있습니다.
