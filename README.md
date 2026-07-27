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
- ViewModel에서 api로 부터 받은 데이터를 View영역에 binding
- input output struct를 활용하여 가독성 향상
- https://github.com/JangJaeHyung1/LookIntoMind/blob/main/LookIntoMind/Screens/Main/MainViewModel.swift
  
![image](https://github.com/JangJaeHyung1/LookIntoMind/assets/37135479/067b9793-97d3-4751-ba9f-1cc8614649e3)

### 4. 아카이빙

#### 캘린더 일기 조회 성능 개선

기존에는 `Date`를 문자열로 변환하여 비교하고, 캘린더 셀마다 전체 일기 배열을 반복해서 검색하는 문제가 있었습니다. 이를 날짜를 키로 사용하는 딕셔너리 구조로 변경해 일기를 바로 조회하도록 개선했습니다.

```swift
let record = records.filter {
    $0.date.summary == date.summary // 예: "2026.07.27"
}.first
```

일기가 1,000개이고 한 달에 30개의 날짜 셀을 표시한다면, 달력을 넘겨 새로운 월의 셀을 구성할 때마다 최대 30,000번의 날짜 비교 조회가 발생할 수 있습니다.

일기 데이터를 날짜별 딕셔너리로 구성하고:

```swift
private var recordsByDate: [Date: DataModel] = [:]
```

시간 값의 차이를 제거하기 위해 날짜를 하루의 시작 시점으로 통일한 뒤 조회했습니다.

```swift
let date = calendarCurrent.startOfDay(for: date)
let record = recordsByDate[date]
```

그 결과 셀 하나의 조회 비용을 `O(N)`에서 평균 `O(1)`로 개선하고, 반복적인 문자열 변환과 전체 배열 검색을 제거했습니다.
