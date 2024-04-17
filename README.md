# 마음보기
## 대분류를 통해 쉽게 본인의 감정을 선택하고, <br>116개의 감정어로 하루를 표현하는 '감정 다이어리 어플'입니다.

앱스토어 링크 - https://apps.apple.com/kr/app/id6473691443



### 1. 기술스택

|적용|기술|
|---|---|
|Project|MVVM, RxSwift|
|UI|SnapKit, FSCalendar|
|Database|Realm|

### 2. 기능
- 일기를 작성하다 취소할 때, 임시 저장 여부를 확인하여 불러오기 기능을 통해 재작성을 돕는 UX를 제공하고 있습니다.
- 작성된 일기 리스트를 보여줄 때, tableView의 lastIndex가 willDisplay되면 fetch되도록 하는 infinite scroll 기능을 제공하고 있습니다.
- UITabBarController의 하단탭 UI를 사용하여 달력 페이지, 일기 리스트 페이지, 기록 통계 페이지 3가지 페이지를 제공하고 있습니다.
- 월별 기록 통계 페이지에서 기록한 감정의 비율을 한눈에 확인할 수 있습니다.


|기록 리스트|감정 선택|일기 작성|
|---|---|---|
|![400x800bb](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/05bd81c8-7c0a-4cd7-8f0e-ec969000c0b2)|![400x800bb (1)](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/84ad1433-2629-4a63-9ea5-e2cfce38c9b0)|![400x800bb (2)](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/31f617b8-91fc-4a84-b4d8-36a78b4d1be8)|

|일기 작성|달력|통계|
|---|---|---|
|![400x800bb (2)](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/31f617b8-91fc-4a84-b4d8-36a78b4d1be8)|![400x800bb (3)](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/c859de28-08ff-4bde-80f1-0debbbfefa12)|![400x800bb (4)](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/d32f06d9-fa7a-4ab4-8129-1797485c0551)|

### 3. Clean Architecture
- Rxswift로 데이터 스트림 제어
- ViewModel에서 api로 부터 받은 데이터를 View영역에 binding할 수 있게 정제
- input output struct를 활용하여 가독성 향상
  
![image](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/067b9793-97d3-4751-ba9f-1cc8614649e3)
