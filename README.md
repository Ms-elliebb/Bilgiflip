# BilgiFlip: Kişiselleştirilebilir ve Modern Bir Çalışma Kartı Platformu 🚀

BilgiFlip, istediğiniz her konuda kendi çalışma setlerinizi oluşturmanıza olanak tanıyan, modern ve konu bağımsız bir Flutter çalışma kartı (flashcard) uygulamasıdır. İster tarih, ister yazılım, ister yabancı dil çalışın; BilgiFlip'in esnek yapısı sayesinde tüm içeriği kolayca yönetebilirsiniz.

Bu proje, Flutter ile ne kadar şık, performanslı ve kolayca genişletilebilir uygulamalar yapılabileceğinin canlı bir kanıtıdır.

---

## ✨ Ekran Görüntüleri

*Not: Aşağıdaki ekran görüntülerinde yer alan "Flutter" içeriği sadece bir örnektir. Uygulamanın gücü, bu içeriği kendi istediğiniz herhangi bir konuyla değiştirebilmenizdir.*

| Kategori Listesi | Konu Listesi | Çalışma Kartı | Sonuç Ekranı |
| :---: | :---: | :---: | :---: |
| <img src="assets/images/Simulator Screenshot - iPhone 16 Pro Max - 2025-09-11 at 11.46.28.png" width="200"> | <img src="assets/images/Simulator Screenshot - iPhone 16 Pro Max - 2025-09-11 at 11.46.31.png" width="200"> | <img src="assets/images/Simulator Screenshot - iPhone 16 Pro Max - 2025-09-11 at 11.46.34.png" width="200"> | <img src="assets/images/Simulator Screenshot - iPhone 16 Pro Max - 2025-09-11 at 11.46.41.png" width="200"> |

---

## 🎥 Ekran Kaydı

Uygulamanın akıcı animasyonlarını ve genel kullanımını gösteren kısa bir video:

---

## 🌟 Platformun Yetenekleri

- **✅ %100 Kişiselleştirilebilir İçerik:** Tüm kategoriler, konular ve kartlar basit bir JSON dosyası üzerinden yönetilir. Kod yazmadan kendi derslerinizi ekleyin!
- **🧠 Aktif Öğrenme:** Kartları "Biliyorum" veya "Tekrar Et" olarak işaretleyerek öğrenme sürecinizi aktif olarak yönetin.
- **📈 İlerleme Takibi ve Raporlama:** Uygulama, hangi kartları bildiğinizi hatırlar (`shared_preferences` ile) ve her konudaki başarı yüzdenizi gösterir. Konu sonunda sunulan dairesel grafik ile performansınızı anında görün.
- **💻 Kod ve Formül Desteği:** Cevaplarınızda, `flutter_syntax_highlighter` ile güzelce renklendirilmiş kod blokları, formüller veya özel formatlı metinler kullanabilirsiniz.
- **🎨 Modern ve Akıcı Arayüz:**
  - Kaydırıldıkça küçülen dinamik başlıklar (`SliverAppBar`).
  - Uygulama genelinde kullanılan şık "Kozmik Gece" teması ve gradyanlar.
  - Akıcı kart çevirme ve liste giriş animasyonları.
- **🏗️ Temiz ve Ölçeklenebilir Mimari:** `Riverpod` ile inşa edilmiş, anlaşılması ve geliştirilmesi kolay bir kod tabanı.

---

## 💡 Kendi İçeriğinizi Nasıl Eklersiniz?

Bu uygulamanın en güzel yanı, kendi çalışma setlerinizi eklemenin inanılmaz kolay olmasıdır.

1.  Projedeki `assets/data.json` dosyasını açın.
2.  Aşağıdaki yapıyı kullanarak kendi kategorilerinizi, konularınızı ve kartlarınızı ekleyin:

    ```json
    [
      {
        "id": "tarih_osmanli",
        "name": "Osmanlı Tarihi",
        "icon_code": 59711, // Material Icon Kodu (history)
        "topics": [
          {
            "id": "kurulus_donemi",
            "name": "Kuruluş Dönemi",
            "flashcards": [
              {
                "question": "Osmanlı Devleti'nin ilk başkenti neresidir?",
                "answer": "Söğüt ve çevresidir. Daha sonra Bursa, Edirne ve son olarak İstanbul başkent olmuştur."
              },
              {
                "question": "Ankara Savaşı hangi padişah döneminde ve kiminle yapılmıştır?",
                "answer": "1402 yılında, Yıldırım Bayezid döneminde Timur ile yapılmıştır. Bu savaş sonrası Fetret Devri başlamıştır."
              }
            ]
          }
        ]
      },
      {
        "id": "yabanci_dil_ingilizce",
        "name": "İngilizce Kelimeler",
        "icon_code": 60980, // Material Icon Kodu (translate)
        "topics": [
          {
            "id": "sifatlar_a1",
            "name": "A1 Seviyesi Sıfatlar",
            "flashcards": [
              {
                "question": "Beautiful",
                "answer": "Güzel"
              },
              {
                "question": "Important",
                "answer": "Önemli"
              }
            ]
          }
        ]
      }
    ]
    ```

3.  Uygulamayı yeniden başlatın. Yeni içeriğiniz otomatik olarak yüklenecektir!

---

## 🛠️ Kullanılan Teknolojiler ve Paketler

- **Çatı (Framework):** `Flutter`
- **State Management:** `flutter_riverpod`
- **Veri Kalıcılığı (Persistence):** `shared_preferences`
- **UI & Animasyon:** `flip_card`, `pie_chart`, `flutter_animate`, `google_fonts`
- **Kod Formatlama:** `flutter_syntax_highlighter`

---

## 🚀 Projeyi Çalıştırma

1.  **Depoyu Klonlayın:**
    ```sh
    git clone https://github.com/kullanici-adiniz/bilgi_flip.git
    cd bilgi_flip
    ```
2.  **Bağımlılıkları Yükleyin:**
    ```sh
    flutter pub get
    ```
3.  **Uygulamayı Başlatın:**
    ```sh
    flutter run
    ```

---

## 🎯 Gelecek Geliştirmeler

- **Uygulama İçi Deste Oluşturucu:** Kullanıcıların JSON düzenlemeden, doğrudan arayüz üzerinden kendi kartlarını oluşturması.
- **Firebase Entegrasyonu:** İçerik ve kullanıcı ilerlemesini bulutta saklayarak cihazlar arası senkronizasyon sağlamak.
- **Aralıklı Tekrarlama Algoritması (Spaced Repetition):** Öğrenmeyi optimize etmek için kartları belirli aralıklarla otomatik olarak tekrar sunmak.
