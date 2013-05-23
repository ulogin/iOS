uLogin iOS SDK
===

Supported OS: iOS 5.0+
Supported devices: iPhone 3GS+, iPad 1+, iPad mini
Supported orientations: portrait, landscape

SDK предназначена для интеграции в iOS приложения разработчиками мобильных приложений.
Поддерживаются все социальные сети, реализуемые uLogin.

Представленная HowTo также доступна по адресу http://ulogin.ru/mobile/ios

HowTo
===
0. Скачать uLogin iOS SDK и тестовое приложение (https://github.com/ulogin/iOS/archive/master.zip)

1. Подключить необходимые библиотеки. 

Список необходимых библиотек:
MapKit
ImageIO
UIKit
Foundation
CoreGraphics

2. Запустите пример из архива

В архиве uLogin SDK мы подготовили пример интеграции uLogin по одному из возможных сценариев. Посмотрите пример использования нашего API

3. Подключите uLogin SDK к вашему проекту.
Скопируйте папку uLoginSDK в свой проект в XCode. Отметье "Copy items into destination group's folder" и "Add to targets"

4. В коде вашего проекта подпишитесь на нотификацию kuLoginSuccess … 
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kuLoginLoginSuccess object:nil];

5. … и инициализируйте uLogin

После тапа пользователя на кнопку логина вызовите код инициализации
ULDefaultConfigurator *config = [ULDefaultConfigurator new];
[[uLogin sharedInstance] startLogin:config viewController:self];

6. После успешного логина обработайте нотификацию

Ваш обработчик loginSuccess получит нотификацию с объектами "profile" и "provider".

profile: объект ULUserProfileData содержащий информацию о вашем пользователе
provider: объект id<ULProvider> с информацией об используемом провайдере при входе

Параметры входа пользователя настраиваются с помощью объекта типа ULDefaultConfigurator.
По умолчанию мы подготовили конфигурацию позволяющую получить возможность входа с использованием всех допустимых провайдеров. 
Конфигуратор ULDefaultConfigurator предоставляет доступ к полям: 
first_name
last_name
nickname
email
sex
country
city
bdate
profile
photo_big

Опциональные поля:
email
photo

Для использование конфигуратора по-умолчанию используйте код из пункта 6 этого HowTo.
Для изменения списка параметров или набора необходимых полей создайтей дочерний по отношению к ULDefaultConfigurator и переопределите необходимые методы.

метод fields: возвращает набор необходимых полей профиля пользователя
метод optional: возвращает набор опциональных польей профиля пользователя
метод providers: возвращает массив провайдеров для входа пользователя
