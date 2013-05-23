uLogin iOS SDK
===

* Supported OS: **iOS 5.0+**
* Supported devices: **iPhone 3GS+, iPad 1+, iPad mini**
* Supported orientations: **portrait, landscape**

SDK предназначена для интеграции в iOS приложения разработчиками мобильных приложений.<br>
Поддерживаются все социальные сети, реализуемые uLogin.

Представленная HowTo также доступна по адресу http://ulogin.ru/mobile/ios

# HowTo

1. **Скачайте uLogin iOS SDK и тестовое приложение** (https://github.com/ulogin/iOS/archive/master.zip)

2. **Подключите необходимые библиотеки**
  
  Список необходимых библиотек:
    * MapKit
    * ImageIO
    * UIKit
    * Foundation
    * CoreGraphics

3. **Запустите пример из архива**

  В архиве uLogin SDK мы подготовили пример интеграции uLogin по одному из возможных сценариев.<br>
  Посмотрите пример использования нашего API

4. **Подключите uLogin SDK к вашему проекту**

  Скопируйте папку uLoginSDK в свой проект в XCode.<br> 
  Отметьте "Copy items into destination group's folder" и "Add to targets"

5. **В коде вашего проекта подпишитесь на нотификацию kuLoginSuccess …**

  ```objc
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kuLoginLoginSuccess object:nil];
  ```
6. **… и инициализируйте uLogin**

  После тапа пользователя на кнопку логина вызовите код инициализации
  ```objc
  ULDefaultConfigurator *config = [ULDefaultConfigurator new];
  [[uLogin sharedInstance] startLogin:config viewController:self];
  ```

7. **После успешного логина обработайте нотификацию**

  Ваш обработчик loginSuccess получит нотификацию с объектами "profile" и "provider".
  
  **profile: объект ULUserProfileData** содержащий информацию о вашем пользователе<br>
  **provider: объект id<ULProvider>** с информацией об используемом провайдере при входе
  
  Параметры входа пользователя настраиваются с помощью объекта типа ULDefaultConfigurator.<br>
  По умолчанию мы подготовили конфигурацию позволяющую получить возможность входа с использованием всех допустимых провайдеров.<br>
  Конфигуратор ULDefaultConfigurator предоставляет доступ к полям: 
  * first_name
  * last_name
  * nickname
  * email
  * sex
  * country
  * city
  * bdate
  * profile
  * photo_big
  
  Опциональные поля:
  * photo
  * phone
  
  Для использование конфигуратора по-умолчанию используйте код из пункта 6 этого HowTo.<br>
  Для изменения списка параметров или набора необходимых полей создайтей дочерний по отношению к ULDefaultConfigurator и переопределите необходимые методы.
  
  **метод fields:** возвращает набор необходимых полей профиля пользователя<br>
  **метод optional:** возвращает набор опциональных польей профиля пользователя<br>
  **метод providers:** возвращает массив провайдеров для входа пользователя
