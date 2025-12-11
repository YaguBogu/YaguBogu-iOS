# 야구보구-iOS

<img width="5760" height="3240" alt="브로셔_표지" src="https://github.com/user-attachments/assets/a7cb7756-796f-4af6-8d7c-98bd2b31bc43" />

<br>
<br>

> [**Sports-API**](https://api-sports.io)를 활용해 KBO 경기 일정 데이터(구장 위치, 경기 일정, 경기 결과)를 제공합니다.
>
> [**OpenWeatherMap API**](https://openweathermap.org/api)를 활용해 실시간 날씨와 5일/3시간 예보 정보를 제공합니다.
> 
> [**Naver MAP**](https://www.ncloud.com/v2/product/applicationService/maps)를 활용해  
>
> 
>
> 
>
> MVVM-C 아키텍처를 기반으로 **View / ViewModel / Model / Coordinator** 간의 의존성을 최소화하고, RxSwift를 통해 화면 간 데이터 갱신을 효율적으로 처리했습니다.

<br>

## 프로젝트 소개 

**프로젝트 주제**: KBO 경기를 보러 가는 사람들을 위해 경기장 방문 전/후로 필요한 정보를 제공하고 관리해주는 서비스 앱

**프로젝트 이름**: 야구보구(YaguBogu)

**와이어프레임**: 🔗 [피그마](https://www.figma.com/design/q4AqWcij9nUGOHwKAKzvbh/%EB%8D%95%EC%95%84%EC%9B%83_%EC%95%BC%EA%B5%AC%EB%B3%B4%EA%B5%AC?node-id=729-1949&t=5PoO7Gq47qoDj0i5-1)

**📱[야구보구 in App store](https://apps.apple.com/kr/app/%EC%95%BC%EA%B5%AC%EB%B3%B4%EA%B5%AC/id6755948443)**

**💬 [야구보구 서포트 페이지](https://www.notion.so/iOS-2beb000d70fa80c5b661f1c40785bd29$0)**

<br>

## 🍎 야구보구-iOS Team

<div align="center">

|신서연|이정은|장우석|
|-------------|--------------|-------------|
| <div align="center">[@hemssy](https://github.com/meowbyterh)</div> | <div align="center">[@zzaeun](https://github.com/hemssy)</div>  | <div align="center">[@oww10](https://github.com/zzaeun)</div> |

</div>

<br>

## 🛠️ 개발 환경

![iOS Version](https://img.shields.io/badge/iOS-18.5-lightgrey.svg?style=for-the-badge&logo=apple&logoColor=white)&nbsp;&nbsp;&nbsp;
![Xcode Version](https://img.shields.io/badge/Xcode-16.4-blue.svg?style=for-the-badge&logo=xcode&logoColor=white)&nbsp;&nbsp;&nbsp;
![Swift Version](https://img.shields.io/badge/Swift-6.1.2-orange.svg?style=for-the-badge&logo=swift&logoColor=white)&nbsp;&nbsp;&nbsp;

<br>

## 🛠️ 기술 스택 및 라이브러리
[![FSCalendar](https://img.shields.io/badge/FSCalendar-2.8.4-F36E6E?style=for-the-badge&logo=protoncalendar&logoColor=white)](https://github.com/WenchaoD/FSCalendar$0)&nbsp;&nbsp;&nbsp;
[![Gifu](https://img.shields.io/badge/Gifu-4.0.1-red?style=for-the-badge&logo=data:image/svg+xml;base64,문자열&logoColor=white)](https://github.com/kaishin/Gifu$0)&nbsp;&nbsp;&nbsp;
![NMapsGeometry](https://img.shields.io/badge/NMapsGeometry-1.0.2-00c73c?style=for-the-badge&logo=maplibre&logoColor=white)&nbsp;&nbsp;&nbsp;
![NMapsMap](https://img.shields.io/badge/NMapsMap-3.23.0-00c73c?style=for-the-badge&logo=maplibre&logoColor=white)&nbsp;&nbsp;&nbsp;
[![RxGesture](https://img.shields.io/badge/RxGesture-4.0.4-B7178C?style=for-the-badge&logo=data:image/svg+xml;base64,문자열&logoColor=white)](https://github.com/RxSwiftCommunity/RxGesture$0)&nbsp;&nbsp;&nbsp;
[![RxSwift 6.9.1](https://img.shields.io/badge/RxSwift-6.9.1-B7178C?style=for-the-badge&logo=reactivex&logoColor=white)](https://github.com/ReactiveX/RxSwift)
[![SnapKit 5.7.1](https://img.shields.io/badge/SnapKit-5.7.1-0A99E2?style=for-the-badge&logo=data:image/svg+xml;base64,문자열&logoColor=white)](https://github.com/SnapKit/SnapKit)&nbsp;&nbsp;&nbsp;
[![swift-confidential](https://img.shields.io/badge/swift_confidential-0.5.0-orange?style=for-the-badge&logo=swift&logoColor=white)](https://github.com/securevale/swift-confidential$0)&nbsp;&nbsp;&nbsp;
[![swift-confidential-plugin](https://img.shields.io/badge/swift_confidential_plugin-0.5.0-orange?style=for-the-badge&logo=swift&logoColor=white)](https://github.com/securevale/swift-confidential-plugin$0)&nbsp;&nbsp;&nbsp;
[![swift-syntax](https://img.shields.io/badge/swift_syntax-602.0.0-orange?style=for-the-badge&logo=swift&logoColor=white)](https://github.com/swiftlang/swift-syntax$0)&nbsp;&nbsp;&nbsp;

<br>

## 📱 주요 기능 

| 기능 구분 | 설명 | 뷰 |
|------------|-------|-------------|
| **관심 구단 선택** | - 앱 실행 시 **관심 구단을 선택**하는 화면 | 관심 구단 선택 이미지 |
| **홈 화면** | - **사용자가 선택한 관심 구단의 홈 구장을 기준으로 정보를 제공** <br> - **현재 구장의 실시간 날씨 정보**(현재 기온, 풍속, 습도, 강수 확률) 확인 가능 <br> - Gifu 라이브러리를 사용해 날씨 상태에 따라 구단 마스코트 GIF가 다르게 나타남 <br> - 화면을 아래로 당기면 현재 선택된 구장의 날씨/예보 데이터 다시 가져옴 <br> - OpenWeatherAPI의 5일/3시간 단위 API를 활용해 **일정 시간대별 날씨 정보 제공** <br> - **선택된 구장의 위치를 미리보기** 형태로 보여줌  | 홈 화면 이미지 |
| **경기 일정** | - 스포츠 API를 활용해 **사용자가 선택한 관심 구단의 경기 일정 제공** <br> - 경기 상태(경기 없음, 경기 종료, 경기 취소, 경기 예정) 에 맞는 뷰를 제공 <br> - **ToolTip을 활용**해 **경기 일정 탭바를 탭하면 Today로 돌아간다는 정보를 최초 1회 제공**| 경기 일정 이미지 |
| **직관 기록** | - 좌측 하단의 플로팅 버튼을 통해 **경기 선택, 제목, 내용, 사진을 기록** <br> - 작성된 게시물은 2열 그리드 형식의 스크롤 뷰로 나타나며 **기록한 사진, 경기 일자, 제목 확인 가능** <br> - 작성한 데이터는 코어데이터에 저장하여 화면에서 그리드 형식으로 확인 가능 <br> - **작성한 기록의 상세 기록 화면을 모달뷰로  확인 가능** | 직관 기록 이미지 | |

<br>

## 👷 아키텍처 개요
**MVVM-C (Model–View–ViewModel-Coordinator)** 패턴을 적용했습니다. Model은 경기 데이터와 관련된 구조체 및 API 응답 모델을 정의하고, View는 구단 선택, 홈, 경기 일정, 직관 기록 화면(UI)에 반영하고, ViewModel은 네트워크 요청 및 데이터 가공 로직을 담당합니다.

<br>

### 🏗️ 계층별 역할
| 계층 구분 | 주요 폴더 | 책임 |
|------------|-------|-------------|
| **Coordinator** | `App/Application/AppCoordinator`, `App/Base/BaseCoordinator`, `Features/SelectTeam/SelectTeamCoordinator`, `Features/Home/HomeCoordinator`, `Features/Schedule/ScheduleCoordinator`, `Features/Record/RecordCoordinator`| 코디네이터 책임 내용 작성 |
| **Model** | `Features/SelectTeam/Model`, `Features/Home/Model`, `Features/Schedule/Model`, `Features/Record/Model`| model 책임 내용 작성 |
| **View** | `Features/Splash/View`, `Features/Onboarding/View`, `Features/SelectTeam/View`, `Features/Home/View`, `Features/Schedule/View`, `Features/Record/View` | UIKit 기반 UI 구성, 사용자 입력 감지 및 ViewModel에 전달
| **ViewModel** | `Features/SelectTeam/SelectTeamViewModel`, `Features/Home/HomeViewModel`, `Features/Schedule/ScheduleViewModel`, `Features/Record/RecordViewModel` | Service로부터 받은 데이터를 가공하여 View에 전달 |

<br>

### 🏗️ 데이터 흐름

1. 

<br>

## 🗂️ 디렉토리 구조

```text
📦YaguBogu
├── 📂App
│   ├── 📂Application
│   │   ├── AppCoordinator.swift
│   │   ├── AppDelegate.swift
│   │   ├── AppVersionCheck.swift
│   │   └── SceneDelegate.swift
│   │
│   └── 📂Base
│       ├── BaseCoordinator.swift
│       ├── BaseViewController.swift
│       └── BaseViewModel.swift
│
├── 📂Features
│   ├── 📂Home
│   │   ├── 📂Coordinator
│   │   │   └── HomeCoordinator.swift
│   │   │
│   │   ├── 📂Model
│   │   │   ├── StadiumInfo.swift
│   │   │   ├── StadiumWeather.swift
│   │   │   ├── WeatherResponse.swift
│   │   │   └── WeatherService.swift
│   │   │
│   │   ├── 📂View
│   │   │   ├── ForecastItemView.swift
│   │   │   ├── HomeViewController.swift
│   │   │   ├── StadiumLocationView.swift
│   │   │   └── StadiumSelectViewController.swift
│   │   │
│   │   └── 📂ViewModel
│   │       └── HomeViewModel.swift
│   │
│   ├── 📂Onboarding
│   │   ├── 📂Coordinator
│   │   │   └── OnboardingCoordinator.swift
│   │   │
│   │   ├── 📂View
│   │   │   ├── 📂Components
│   │   │   │   ├── NextButtonView.swift
│   │   │   │   ├── OnboardingBottomView.swift
│   │   │   │   └── PageControlsView.swift
│   │   │   ├── OnboardingContainerView.swift
│   │   │   ├── OnboardingView1.swift
│   │   │   ├── OnboardingView2.swift
│   │   │   └── OnboardingView3.swift 
│   │   │
│   │   └── 📂ViewModel
│   │       └── OnboardingViewModel.swift
│   │   
│   ├── 📂PermissionModel
│   │   ├── 📂View
│   │   │   ├── PermissionBottomSheet.swift
│   │   │   └── PermissionBottomSheetView.swift
│   │   │
│   │   └── 📂ViewModel
│   │       └── PermissionBottomSheetViewModel.swift
│   │
│   ├── 📂Record
│   │   ├── 📂Coordinator
│   │   │   └── RecordCoordinator.swift
│   │   │
│   │   ├── 📂Model
│   │   │   ├── 📂CoreDate
│   │   │   │   ├── 📂.xcdatamodeld
│   │   │   │   │   └── PageControlsView.swift
│   │   │   │   │   
│   │   │   │   ├── 📂CoreData
│   │   │   │   │   ├── CoreDataManager.swift
│   │   │   │   │   ├── CoreDataStack.swift
│   │   │   │   │   ├── RecordData+CoreDataClass.swift
│   │   │   │   └── └── RecordData+CoreDataProperties.swift
│   │   │   │   
│   │   │   └── PageControlsView.swift
│   │   │
│   │   ├── 📂View
│   │   │   ├── 📂CreatRecordView
│   │   │   │    └── CreatRecordView.swift
│   │   │   │
│   │   │   ├── 📂DetailRecordModalView
│   │   │   │    └── DetailRecordModalView.swift
│   │   │   │
│   │   │   ├── 📂EmptyRecordView
│   │   │   │    └── EmptyRecordView.swift
│   │   │   │
│   │   │   ├── 📂ListRecordView
│   │   │   │   ├── 📂Cell
│   │   │   │   │   └── ListRecordCell.swift
│   │   │   │   └── RecordViewController.swift
│   │   │   │
│   │   │   └── 📂SelectGameModalView
│   │   │       ├── 📂Cell
│   │   │       │   └── SelectGameCell.swift
│   │   │       └── SelectGameModalView.swift
│   │   │
│   │   └── 📂ViewModel
│   │       ├── 📂CreatViewModel
│   │       │    └── CreatViewModel.swift
│   │       │
│   │       ├── 📂DetailRecordViewModel
│   │       │    └── DetailRecordViewModel.swift
│   │       │
│   │       ├── 📂RecordViewModel
│   │       │    └── RecordViewModel.swift
│   │       │
│   │       ├── 📂SelectGameViewModel
│   │       │   ├── ExtraTeamsJsonService.swift
│   │       │   ├── SelectGameCellModel.swift
│   │       │   └── SelectGameViewModel.swift
│   │       │
│   │       └── 📂Service
│   │           ├── RecordCoreDataService.swift
│   │           ├── RecordGameInfoService.swift
│   │           └── RecordService.swift
│   │ 
│   ├── 📂Schedule
│   │   ├── 📂Coordinator
│   │   │   └── ScheduleCoordinator.swift
│   │   │
│   │   ├── 📂Manager
│   │   │   └── TeamInfoManager.swift
│   │   │
│   │   ├── 📂Model
│   │   │   └── ScheduleModel.swift
│   │   │
│   │   ├── 📂Service
│   │   │   └── ScheduleService.swift
│   │   │
│   │   ├── 📂View
│   │   │   ├── 📂BaseScheduleCardView
│   │   │   │   └── BaseScheduleCardView.swift
│   │   │   │
│   │   │   ├── 📂CalendarView
│   │   │   │   ├── CustomCalendarCell.swift
│   │   │   │   ├── CustomCalendarHeaderView.swift
│   │   │   │   └── CustomCalendarView.swift
│   │   │   │
│   │   │   ├── 📂NoScheduleView
│   │   │   │   └── NoScheduleView.swift
│   │   │   │
│   │   │   └── 📂ScheduleViewController
│   │   │       └── ScheduleViewController.swift
│   │   │
│   │   └── 📂ViewModel
│   │       └── ScheduleViewModel.swift
│   │ 
│   ├── 📂SelectTeam
│   │   ├── 📂Coordinator
│   │   │   └── SelectTeamCoordinator.swift
│   │   │
│   │   ├── 📂Model
│   │   │   ├── TeamDataUserDefaults.swift
│   │   │   └── TeamInfoModel.swift
│   │   │  
│   │   ├── 📂View
│   │   │   ├── 📂Cell
│   │   │   │   └── SelectTeamCell.swift
│   │   │   ├── TeamHeaderView.swift
│   │   │   └── TeamViewController.swift
│   │   │  
│   │   └── 📂ViewModel
│   │       └── TeamViewModel.swift
│   │ 
│   ├── 📂Splash
│   │   ├── 📂View
│   │   │   └── SplashViewController.swift
│   │   │
│   │   └── 📂ViewModel
│   │       └── SplashViewModel.swift
│   │ 
│   └── 📂TabBar
│       ├── TabBarController.swift
│       └── TabBarCoordinator.swift
│
├── 📂Resources
│   ├── 📂Asnimations
│   │   ├── TeamDataUserDefaults.swift
│   │   └── TeamInfoModel.swift
│   ├── Assets
│   ├── Color_Extension.swift
│   └── LaunchScreen.storyboard
│   
├── 📂Utils
│   ├── 📂Alert
│   │   ├── CustomAlertCoordinator.swift
│   │   ├── CustomAlertView.swift
│   │   └── CustomAlertViewModel.swift
│   │   
│   ├── 📂Json
│   │   ├── ExtraTeamModel.json
│   │   └── JsonLoader.swift
│   │   
│   ├── 📂Translator
│   │   ├── DayTranslator.swift
│   │   └── TeamNameTranslator.swift
│   │   
│   ├── 📂UILabel
│   │   └── LineSpacingExtension.swift
│   │   
│   └── PhotoDataToString.swift
│
├── Info.plist
│
├── Secrets.swift
│
└── 📦Package Dependencies
    ├── FSCalnedar 2.8.4
    ├── Gifu 4.0.1
    ├── NMapsGeometry 1.0.2
    ├── NMapsMap 3.23.0
    ├── RxGesture 4.0.4
    ├── RxSwift 6.9.1
    ├── SnapKit 5.7.1
    ├── swift-confidential 0.5.0
    ├── swift-confidential-plugin 0.5.0
    └── swift-syntax 602.0.0

```

<br>

--- 
## 코딩 컨벤션

1. 더 이상 상속되지 않을 class에는 final 키워드를 붙인다.
2. class에서 사용되는 프로퍼티는 모두 private으로 선언한다. 
3. 파일명에 약어와 생략을 지양한다. (VC, TVC, Config → ViewController, TableViewCell, Configure)
4. 필요없는 주석 및 Mark 구문을 제거한다.
5. 강제 언래핑을 사용하지 않는다.
6. delegate 지정, UI관련 설정 등등 모두 함수와 역할에 따라서 extension 으로 빼도록 한다.

<br>

## 아키텍처 컨벤션
**MVVM-C 패턴 컨벤션**

1. 모든 Coordinator는 BaseCoordinator 프로토콜을 따른다.
2. 화면 이동(push/present)는 무조건 Coordinator에서만 처리한다.
3. ViewModel은 Coordinator를 직접 참조하지 않는다. 대신 이벤트 클로저 형태로 Coordinator에 전달한다.
4. AppCoordinator는 앱 최초 진입 흐름(start) 담당이다. 탭바 or 온보딩 여부를 판단한다.
5. 각 Feature는 자기 화면 흐름을 담당하는 Coordinator를 가진다.
6. 각 Feature는 아래 4단계를 기본으로 구성한다.

```swift
FeatureName/
    View/
    ViewModel/
    Model/
    Coordinator/
```

<br>

## 깃 플로우 전략
<img width="800" height="450" alt="image" src="https://github.com/user-attachments/assets/55fb2bdd-ab59-4ba6-9afc-83b476bb5d41" />

```swift
gitGraph
    commit id: "main-init" tag: "v0.1"

    // develop 브랜치 시작
    branch develop
    checkout develop
    commit id: "start-develop"

    // feature 작업 (반복 구조를 ... 으로 표시)
    branch feature
    checkout feature
    commit id: "feature-work"
    checkout develop
    merge feature
    commit id: "..."
    commit id: "..."

    // 최종 릴리스 (release 단어 제거)
    checkout main
    merge develop
    commit id: "v1.0" tag: "v1.0"


```

<br>

1. 작업할 내용에 대해서 이슈를 생성하고 이슈번호를 확인한다.
2. 나의 로컬에서 develop 브랜치가 최신화 되어있는지 확인한다.
3. develop 브랜치에서 새로운 이슈 브랜치를 생성한다.
    
     커밋타입/#이슈번호
     ex) feat/#1
    
4. 생성한 브랜치에서 작업을 시작한다.
5. 작업 완료 후, 에러가 없는지 확인하고 커밋 컨벤션에 맞춰 커밋한 후 push 한다.
6. PR을 작성한다.
7. 코드리뷰 후 수정사항 반영한 뒤, develop 브랜치에 merge 한다.
8. 머지 이후, 작업했던 브랜치는 삭제한다.

<br>

## 커밋타입
> `Feat`: 새로운 기능을 추가할 경우  
>
> 
> `Fix`: 버그를 고친 경우  
>
> 
> `Design`: CSS 등 사용자 UI 디자인 변경  
>
> 
> `Style`: 코드 포맷 변경, 세미 콜론 누락, 코드 수정이 없는 경우  
>
> 
> `Refactor`: 프로덕션 코드 리팩토링  
>
> 
> `Docs`: 문서를 수정한 경우  
>
> 
> `Test`: 테스트 추가, 테스트 리팩토링(프로덕션 코드 변경 X)  
>
> 
> `Chore`: gitignore 파일정리, 빌드 테스트 업데이트, 패키지 매니저를 설정하는 경우(프로덕션 코드 변경 X)  
>
> 
> `Rename`: 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우  
>
> 
> `Remove`: 파일을 삭제하는 작업만 수행한 경우  

<br>

## 이슈 / PR 제목


**이슈 제목**: `[커밋타입] 작업 이름`

**PR 제목**: `[커밋타입] #이슈번호 - 작업 이름`

<br>

## 커밋 메시지


커밋 메시지는 `[커밋타입] #이슈번호 - 작업 이름` 으로 적는다.

**충돌 해결 merge 시**: `[Merge] develop->브랜치이름 머지`

**PR을 develop에 merge 시** : `[Merge] 브랜치이름->develop 머지`

<br>

---

## 개발일지 
### [노션 바로가기](https://www.notion.so/2aab000d70fa80e19a43dcbc1053e72b$0)
