# Pomodoro Timer App

Bu uygulama, Pomodoro tekniği ile zaman yönetimini destekleyen bir uygulamadır. Kullanıcılar, belirli bir süre çalışarak odaklanabilir ve ardından kısa bir ara (rest) vererek verimliliklerini artırabilirler. Bu proje, Flutter ile geliştirilmiştir ve temel özelliklere sahip bir Pomodoro zamanlayıcısı sunmaktadır.

---

##  Projedeki Sayfaların Görevleri ve İçerikleri

### 1. **Home Page**
- **Görev**: Kullanıcıların geri sayım başlatıp durdurabileceği, **Focus Time** ve **Rest Time**'ı takip edebileceği ana sayfa.
- **İçerik**:
  - **Geri sayım ekranı**: Kullanıcıların **Focus Time** veya **Rest Time**'ı takip edebileceği bir geri sayım sayacı.
  - **Start/Stop Timer** butonları: Timer'ı başlatmak veya durdurmak için butonlar.
  - **Settings butonu**: Kullanıcıları **Settings Page**'e yönlendiren buton.

### 2. **Settings Page**
- **Görev**: Kullanıcıların **Focus Time** ve **Rest Time** değerlerini değiştirmelerine olanak tanır.
- **İçerik**:
  - **Focus Time**: Kullanıcıların odaklanmak istedikleri süreyi girmeleri için bir giriş alanı.
  - **Rest Time**: Kullanıcıların dinlenmek istedikleri süreyi girmeleri için bir giriş alanı.
  - **Save Settings** butonu: Kullanıcı ayarlarını kaydeder ve **Home Page**'e geri gönderir.

### 3. **Drawer Menü**
- **Görev**: Kullanıcıların uygulama içinde gezinmesini kolaylaştıran yan menü.
- **İçerik**:
  - **Home**: Ana sayfaya gitmek için bir seçenek.
  - **Settings**: Ayarlar sayfasına gitmek için bir seçenek.
  - **Log out**: Kullanıcıyı çıkış yapmaya yönlendiren bir seçenek.

---

##  Drawer Menüde Kullandığınız Logoya Ait API Bilgileri

Uygulama, **Cloudinary**'den alınan bir logo görselini kullanmaktadır. Bu logo görseli, kullanıcıya uygulamanın marka kimliğini göstermek amacıyla **Drawer** menüsünde gösterilmektedir.

- **Logo URL**: [Logo Görseli](https://res.cloudinary.com/dcho616lp/image/upload/v1744061032/logo-MinkTick.png)

---

##  Login Bilgilerini Nasıl Sakladığınız

Bu projede, login bilgilerini saklamak için herhangi bir veri saklama yöntemi kullanılmamıştır. Ancak, ilerleyen versiyonlarda kullanıcının giriş bilgilerini saklamak için **`SharedPreferences`** veya bir **backend** servisi ile saklama yöntemleri kullanılabilir.

**Not**: Şu anki sürümde kullanıcı sadece ayarları (focus time ve rest time) kaydedebilmektedir, ancak login bilgileri için herhangi bir saklama işlemi yapılmamıştır.

---

##  Grup Üyelerinin Projeye Katkısı

- **Huda**: Proje fikri, **UI tasarımı**, ve **Tum Proje Sayfalari**'in geliştirilmesi.
