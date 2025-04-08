# Pomodoro Timer App

## Proje Hakkında

Pomodoro Tekniği, zaman yönetimini iyileştirmeye yönelik bir yöntemdir. Bu uygulama, kullanıcıların **odaklanma sürelerini** ve **dinlenme sürelerini** düzenleyerek bu tekniği daha verimli bir şekilde kullanmalarına olanak tanır. Uygulama, kullanıcı dostu bir arayüz ve etkileşimli özelliklerle geliştirilmiştir.

## Proje Amacı

Bu projenin amacı, kullanıcıların **Pomodoro Tekniği** ile odaklanma sürelerini optimize etmelerine yardımcı olmak, ayrıca dinlenme sürelerini verimli bir şekilde yönetmelerine olanak tanımaktır. Uygulama, **odaklanma** ve **dinlenme sürelerini** kişiselleştirerek kullanıcının verimliliğini artırmayı hedefler.

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

Bu projede, login bilgilerini saklamak için **`SharedPreferences`** yöntemini kullanılmamıştır.

---

##  Grup Üyelerinin Projeye Katkısı

- **Huda**: Proje fikri, **UI tasarımı**, ve **Tum Proje Sayfalari**'in geliştirilmesi.

### **Teknik Detaylar**:
- **Dart ve Flutter** kullanılarak geliştirilmiştir.
- **Global Değişkenler**: Kullanıcı adı gibi veriler, global değişkenler ile saklanır ve sayfalar arasında paylaşılır.
- **State Management**: Basit state management yaklaşımıyla sayfalar arasında veri paylaşımı sağlanır. Kullanıcı adı ve ayar bilgileri global değişkenlerde saklanır.
- **Timer İşlevi**: Hem Focus hem de Rest sayfalarında geri sayım işlevi bulunmaktadır. Bu sayede kullanıcılar odaklanma ve dinlenme sürelerini kontrol edebilir.
- **Drawer Menü**: Uygulama genelinde navigasyonu sağlamak için bir **Drawer** menüsü kullanılır.

### **Öne Çıkan Özellikler**:
- **Basit Arayüz**: Kullanıcılar, odaklanma ve dinlenme sürelerini kişiselleştirebilecekleri kullanım dostu bir arayüze sahip.
- **Kullanıcı Girişi ve Saklama**: Kullanıcı adı **global değişkenler** kullanılarak saklanır ve uygulamanın her yerinde kullanılabilir.
