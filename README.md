# 🟡 GoldShop - POS App for Gold Businesses

GoldShop is a modern Point of Sale (POS) mobile application tailored for gold shop businesses. It enables shop owners to manage sales, purchases, mortgaging, employees, and external expenses efficiently — all from the convenience of their mobile devices.

---

## 🛠️ Built With

- **Flutter** – Cross-platform UI toolkit  
- **Firebase** – Backend (Authentication, Firestore, Storage)  
- **GetX** – Lightweight State Management  
- **BLoC Architecture** – For scalable, testable business logic  
- **Cloud Firestore** – Real-time data storage  
- **Firebase Auth** – Secure login/signup and password recovery  
- **Firebase Storage** – Uploading receipts or gold item images  

---

## 📱 Features

| Feature          | Description |
|------------------|-------------|
| 🔐 **Authentication** | Login, Signup, Forgot Password, Email Verification |
| 💰 **Sell Page**     | Record customer gold sales with details and images |
| 💸 **Buy Page**      | Register purchases made from customers or suppliers |
| 🔒 **Mortgage**      | Handle mortgaged gold items with due tracking |
| 👨‍💼 **Employee Page** | Add, manage, and track employee activity |
| 💳 **Payment Page**  | Track received and pending payments |
| 📤 **External Cost** | Record expenses like rent, electricity, advertising |
| 🏠 **Dashboard**     | Quick stats and summary of sales, purchases, dues, etc. |

---

## 📸 Screenshots

- Dashboard Overview  
- Sell / Buy Page  
- Mortgage & Payments  
- Calculator  

![iScreen Shoter - 20250604122732203](https://github.com/user-attachments/assets/2912072c-bf75-4091-8cbc-62ca0897311d)


![list_screen](https://github.com/user-attachments/assets/ae1b200d-d777-478f-b0f9-cb7fc4549913)


![sell_screen](https://github.com/user-attachments/assets/4f6065f7-896d-4fd4-88a8-a26d17f913dd)
![mortgage_screen](https://github.com/user-attachments/assets/a1a24c2a-a996-45bd-8ade-f186f4d1b072)


![mortgage_details_screen](https://github.com/user-attachments/assets/f9c0ab92-ea0c-4ebd-b38b-72079d4685f4)

![pay_screen](https://github.com/user-attachments/assets/70d42e3f-1ab3-4403-ad14-fa3369914acf)
![work_screen](https://github.com/user-attachments/assets/8dcbf0c3-1a71-4c24-b92d-26ef1fea0fc4)

![product_screen](https://github.com/user-attachments/assets/fba5b210-e7f2-445e-a6c6-5a07d36a034d)

![sell_details_screen](https:![calculator](https://github.com/user-attachments/assets/08ffc9a2-a81b-4be1-bbb7-27c5e0c3cdbd)
![calculator](https://github.com/user-attachments/assets/0a102044-6324-483b-8bd8-eadec430c996)

![pdf](https://github.com/user-attachments/assets/49bc4113-9c9c-4115-8abf-36d272c8aa73)



---

## ⚙️ Architecture

The app uses a hybrid **GetX + BLoC** architecture for optimized modularity, readability, and separation of concerns.

![pp](https://github.com/user-attachments/assets/c5ac1237-21fb-4e1e-b275-43feb099d8a6)


🧪 Roadmap
 Add charts and analytics to dashboard
 Export reports as PDF or Excel
 Push notifications for dues and reminders
 Multi-language support


 🙌 Contributing
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change




💬 Feedback
If you find this project useful or have any suggestions, please feel free to reach out or create an issue. Stars ⭐ are appreciated!



```bash
git clone https://github.com/yourusername/goldshop.git
cd UIPtv
flutter pub get
flutter run
Directory structure:
└── hridoydhar1-goldshop_app.git/
    ├── README.md
    ├── analysis_options.yaml
    ├── firebase.json
    ├── pubspec.lock
    ├── pubspec.yaml
    ├── .firebaserc
    ├── .metadata
    ├── android/
    │   ├── build.gradle.kts
    │   ├── gradle.properties
    │   ├── settings.gradle.kts
    │   ├── app/
    │   │   ├── build.gradle.kts
    │   │   ├── google-services.json
    │   │   └── src/
    │   │       ├── debug/
    │   │       │   └── AndroidManifest.xml
    │   │       ├── main/
    │   │       │   ├── AndroidManifest.xml
    │   │       │   ├── kotlin/
    │   │       │   │   └── com/
    │   │       │   │       └── example/
    │   │       │   │           └── goldshop/
    │   │       │   │               └── MainActivity.kt
    │   │       │   └── res/
    │   │       │       ├── drawable/
    │   │       │       │   └── launch_background.xml
    │   │       │       ├── drawable-v21/
    │   │       │       │   └── launch_background.xml
    │   │       │       ├── values/
    │   │       │       │   └── styles.xml
    │   │       │       └── values-night/
    │   │       │           └── styles.xml
    │   │       └── profile/
    │   │           └── AndroidManifest.xml
    │   └── gradle/
    │       └── wrapper/
    │           └── gradle-wrapper.properties
    ├── dataconnect/
    │   ├── dataconnect.yaml
    │   ├── connector/
    │   │   ├── connector.yaml
    │   │   ├── mutations.gql
    │   │   └── queries.gql
    │   └── schema/
    │       └── schema.gql
    ├── dataconnect-generated/
    │   └── dart/
    │       └── default_connector/
    │           ├── README.md
    │           └── default.dart
    ├── ios/
    │   ├── Podfile
    │   ├── Flutter/
    │   │   ├── AppFrameworkInfo.plist
    │   │   ├── Debug.xcconfig
    │   │   └── Release.xcconfig
    │   ├── Runner/
    │   │   ├── AppDelegate.swift
    │   │   ├── Info.plist
    │   │   ├── Runner-Bridging-Header.h
    │   │   ├── Assets.xcassets/
    │   │   │   ├── AppIcon.appiconset/
    │   │   │   │   └── Contents.json
    │   │   │   └── LaunchImage.imageset/
    │   │   │       ├── README.md
    │   │   │       └── Contents.json
    │   │   └── Base.lproj/
    │   │       ├── LaunchScreen.storyboard
    │   │       └── Main.storyboard
    │   └── RunnerTests/
    │       └── RunnerTests.swift
    ├── lib/
    │   ├── main.dart
    │   ├── navigation.dart
    │   ├── core/
    │   │   ├── config/
    │   │   │   ├── app_routes.dart
    │   │   │   ├── app_theme.dart
    │   │   │   └── controll_binding.dart
    │   │   ├── constant/
    │   │   │   ├── app_color.dart
    │   │   │   ├── app_constant.dart
    │   │   │   ├── app_images.dart
    │   │   │   ├── app_string.dart
    │   │   │   └── text.dart
    │   │   ├── helper/
    │   │   │   └── interestital_video_ads.dart
    │   │   ├── services/
    │   │   │   ├── auth_service.dart
    │   │   │   └── network_caller.dart
    │   │   ├── utils/
    │   │   │   ├── date_format.dart
    │   │   │   ├── responsive.dart
    │   │   │   ├── url.dart
    │   │   │   └── validator.dart
    │   │   └── widgets/
    │   │       ├── button.dart
    │   │       ├── custom_appbar.dart
    │   │       ├── custom_container_two.dart
    │   │       ├── custom_datapicker.dart
    │   │       ├── custom_elevated_button.dart
    │   │       ├── custom_floatingaction_button.dart
    │   │       ├── custom_list_container.dart
    │   │       ├── custom_password_field.dart
    │   │       ├── custom_text_field.dart
    │   │       ├── custom_text_field_two.dart
    │   │       ├── nav_controller.dart
    │   │       ├── navbottom_controller.dart
    │   │       ├── notification_container.dart
    │   │       ├── search_bar.dart
    │   │       ├── text_field_four.dart
    │   │       └── three.dart
    │   └── feature/
    │       ├── AddProductAndMoney/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── product_and_money.dart
    │       ├── Auth/
    │       │   ├── data/
    │       │   │   └── models/
    │       │   │       └── user_model.dart
    │       │   └── presentation/
    │       │       ├── controllers/
    │       │       │   └── auth_controller.dart
    │       │       ├── screen/
    │       │       │   ├── forget_password_screen.dart
    │       │       │   ├── login_screen.dart
    │       │       │   ├── singup_screen.dart
    │       │       │   ├── splash_screen.dart
    │       │       │   └── verificationcode_screen.dart
    │       │       └── widgets/
    │       │           ├── code_timer.dart
    │       │           ├── social_icons.dart
    │       │           └── splash_screen_details.dart
    │       ├── BuyList/
    │       │   ├── data/
    │       │   │   └── model/
    │       │   │       └── buy_model.dart
    │       │   └── presentaion/
    │       │       └── screen/
    │       │           ├── buy_list.dart
    │       │           └── buy_list_details.dart
    │       ├── Calculator/
    │       │   └── presentation/
    │       │       ├── screen/
    │       │       │   ├── calculator.dart
    │       │       │   └── calculator_screen.dart
    │       │       └── widget/
    │       │           ├── calculator_bottom_container.dart
    │       │           ├── iteam_container.dart
    │       │           └── iteam_container_section.dart
    │       ├── EmployeeList/
    │       │   ├── data/
    │       │   │   └── model/
    │       │   │       └── employee_model.dart
    │       │   └── presentation/
    │       │       └── screen/
    │       │           ├── employee_details.dart
    │       │           └── employee_list.dart
    │       ├── GiveWork/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── give_work.dart
    │       ├── GoldPrice/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── gold_price.dart
    │       ├── HomePage/
    │       │   └── presentation/
    │       │       ├── controller/
    │       │       │   └── calculationa_controller.dart
    │       │       ├── screen/
    │       │       │   └── home_screen.dart
    │       │       └── wiget/
    │       │           ├── app_bar.dart
    │       │           └── grid_iteam.dart
    │       ├── IcomeDashboard/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── icome_dashboard.dart
    │       ├── ListScreen/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── list_screen.dart
    │       ├── MortgageList/
    │       │   ├── data/
    │       │   │   ├── model/
    │       │   │   │   ├── mortgage_model.dart
    │       │   │   │   └── mortgage_pay_model.dart
    │       │   │   └── repository/
    │       │   │       └── mortgage_repository.dart
    │       │   └── presentation/
    │       │       ├── controller/
    │       │       │   ├── mortgage_list_event.dart
    │       │       │   └── mortgage_list_state.dart
    │       │       └── screen/
    │       │           ├── mortgage_list.dart
    │       │           ├── mortgage_list_details.dart
    │       │           └── mortgage_pay_list.dart
    │       ├── New Employee/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── new_employee.dart
    │       ├── NewBuy/
    │       │   └── presentation/
    │       │       └── new_buy.dart
    │       ├── NewMortgage/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── new_mortgage.dart
    │       ├── NewSell/
    │       │   └── presentation/
    │       │       ├── controller/
    │       │       │   └── new_sell_controller.dart
    │       │       ├── screen/
    │       │       │   └── new_sell.dart
    │       │       └── widget/
    │       │           └── product_text_field.dart
    │       ├── Notifications/
    │       │   ├── data/
    │       │   │   ├── model/
    │       │   │   │   └── notification_model.dart
    │       │   │   └── service/
    │       │   │       └── notification_service.dart
    │       │   └── presentation/
    │       │       ├── screen/
    │       │       │   └── notification_screen.dart
    │       │       └── wiget/
    │       │           └── notification_button.dart
    │       ├── OtherCost/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── other_cost.dart
    │       ├── OtherCostList/
    │       │   ├── data/
    │       │   │   └── othercost_model.dart
    │       │   └── presentation/
    │       │       ├── screen/
    │       │       │   ├── other_cost_details.dart
    │       │       │   └── other_cost_list.dart
    │       │       └── widget/
    │       │           └── other_cost_field.dart
    │       ├── Pay/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── new_pay.dart
    │       ├── PayList/
    │       │   ├── data/
    │       │   │   └── pay_model.dart
    │       │   └── presentation/
    │       │       └── screen/
    │       │           ├── pay_list.dart
    │       │           └── pay_list_details.dart
    │       ├── ProductList/
    │       │   ├── data/
    │       │   │   └── model/
    │       │   │       └── product_model.dart
    │       │   └── presentation/
    │       │       └── screen/
    │       │           ├── product_details.dart
    │       │           └── product_list.dart
    │       ├── ProfileDetails/
    │       │   └── presentation/
    │       │       └── screen/
    │       │           └── create_profile.dart
    │       ├── SellList/
    │       │   ├── data/
    │       │   │   └── model/
    │       │   │       └── sell_model.dart
    │       │   └── presentation/
    │       │       ├── screen/
    │       │       │   ├── sell_details_screen.dart
    │       │       │   └── sell_list.dart
    │       │       └── widget/
    │       │           ├── CMakeLists.txt
    │       │           └── print_sell_details.dart
    │       └── workerList/
    │           ├── data/
    │           │   └── model/
    │           │       └── work_model.dart
    │           └── presentation/
    │               └── screen/
    │                   ├── work_list.dart
    │                   └── work_list_details.dart
    ├── linux/
    │   ├── CMakeLists.txt
    │   ├── flutter/
    │   │   ├── CMakeLists.txt
    │   │   ├── generated_plugin_registrant.cc
    │   │   ├── generated_plugin_registrant.h
    │   │   └── generated_plugins.cmake
    │   └── runner/
    │       ├── CMakeLists.txt
    │       ├── main.cc
    │       ├── my_application.cc
    │       └── my_application.h
    ├── macos/
    │   ├── Podfile
    │   ├── Flutter/
    │   │   ├── Flutter-Debug.xcconfig
    │   │   ├── Flutter-Release.xcconfig
    │   │   └── GeneratedPluginRegistrant.swift
    │   ├── Runner/
    │   │   ├── AppDelegate.swift
    │   │   ├── DebugProfile.entitlements
    │   │   ├── Info.plist
    │   │   ├── MainFlutterWindow.swift
    │   │   ├── Release.entitlements
    │   │   ├── Assets.xcassets/
    │   │   │   └── AppIcon.appiconset/
    │   │   │       └── Contents.json
    │   │   ├── Base.lproj/
    │   │   │   └── MainMenu.xib
    │   │   └── Configs/
    │   │       ├── AppInfo.xcconfig
    │   │       ├── Debug.xcconfig
    │   │       ├── Release.xcconfig
    │   │       └── Warnings.xcconfig
    │   └── RunnerTests/
    │       └── RunnerTests.swift
    ├── test/
    │   └── widget_test.dart
    ├── web/
    │   ├── index.html
    │   └── manifest.json
    └── windows/
        ├── CMakeLists.txt
        ├── flutter/
        │   ├── CMakeLists.txt
        │   ├── generated_plugin_registrant.cc
        │   ├── generated_plugin_registrant.h
        │   └── generated_plugins.cmake
        └── runner/
            ├── CMakeLists.txt
            ├── flutter_window.cpp
            ├── flutter_window.h
            ├── main.cpp
            ├── resource.h
            ├── runner.exe.manifest
            ├── Runner.rc
            ├── utils.cpp
            ├── utils.h
            ├── win32_window.cpp
            └── win32_window.h


