# Brand-x Phase-0: Consumer Insight & Product-Market Fit Analysis 📊

**Bağımsız Araştırmacı:** Fatma Tosun  
**Kapsam:** Brand-X Face Sunscreen SPF50 ve Anti-Dandruff Şampuan  
**Teknoloji Stoku:** R (ggplot2, tidytext, stringr, stringi, ggwordcloud)

## 📌 Proje Özeti (Executive Summary)
Bu proje, Brand-X dermokozmetik markasının güneş kremi ve şampuan formülasyonlarına yönelik Faz-0 saha performansını, kozmetik toleransını ve marka konumlandırmasını inceleyen stratejik bir pilot veri analizidir. 

Çalışmanın amacı evrene genellenebilir istatistiksel sonuçlar üretmek değil; tüketici psikolojisindeki "baskın ticari sinyalleri" yakalamak, metin madenciliği ile ürün-pazar uyumunu (Product-Market Fit) test etmek ve Faz-1 klinik denemeleri öncesi AR-GE ekibine rasyonel optimizasyon verileri sunmaktır.

---

## 🛠 Metodoloji ve Veri İşleme
Anket yoluyla elde edilen karmaşık ve yapılandırılmamış (unstructured) tüketici verileri **R programlama dili** kullanılarak işlenmiştir:
* **Veri Temizliği (Data Wrangling):** `dplyr` ve `stringr` ile çöp veriler, çapraz tutarsızlıklar ve test harici yanıtlar filtrelenmiştir. Dağınık açık uçlu yanıtlar stratejik kategoriler altında konsolide edilmiştir.
* **Metin Madenciliği (Text Mining):** `tidytext` kullanılarak Türkçe doğal dil işleme (NLP) limitasyonları baypas edilmiş, stop-words (bağlaç) temizliği ve kök frekans analizi ile tüketici zihnindeki "meta-temalar" çıkarılmıştır.
* **Veri Görselleştirme:** Verideki 100% yığılma illüzyonları (stacked bar illusions) kırılarak, gerçek N değerlerini gösteren "CEO-Ready" (karar alıcıya hazır) `ggplot2` grafikleri üretilmiştir.

---

## 💡 Temel Stratejik İçgörüler (Actionable Insights)

### 1. Marka Kimliği ve Fiyatlama: "FMCG Tuzağı"
Tüketiciler, formülün kokusunu "Premium" veya "İlaç" olarak algıladıklarında ürünü şaşmaz bir şekilde **Eczane** rafında görmek istemektedir. Ancak koku "Yaz/Plaj" hissi verdiğinde ürünün algılanan değeri düşmekte ve süpermarket (FMCG) beklentisi doğmaktadır.
*(Dermokozmetik kâr marjını korumak için plaj kokularından acilen uzaklaşılmalıdır.)*

<img width="4500" height="3000" alt="A1_Gunes_Caresizlik_Beklenti_Duzeltilmis" src="https://github.com/user-attachments/assets/c937878f-42be-4e5d-96f2-b6ff3d46deaf" />


### 2. Tüketici Psikolojisi: Medikal Kuruluk vs. Kozmetik Tatmin
Kepek sorununu 10/10 şiddetinde (en çaresiz seviyede) yaşayan hastalar dahi, satın alma kararı için sadece klinik tedavi değil; "saçta yarattığı hacim ve parlaklık" gibi kozmetik tatminler aramaktadır. 

<img width="4500" height="3000" alt="A2_Sampuan_Caresizlik_Beklenti_Duzeltilmis" src="https://github.com/user-attachments/assets/378fce32-b8c0-4dab-a8ca-bbde762c3081" />


### 3. AR-GE Toleransı ve Çapraz Satış (Cross-Sell) Fırsatı
* **Başarı:** Güneş kreminde yüksek kullanım frekansında dahi üst üste binme (pilling) ve kusma yaşanmamıştır. Polimer bariyer teknolojisi pazar için rekabetçi bir avantajdır.
* **Kriz ve Fırsat:** Şampuanın kepek çözümü saç tellerini kurutmakta ve tüketiciyi rakip markaların saç kremlerine itmektedir. Brand-X markalı tamamlayıcı bir saç kremi/serumu derhal AR-GE hattına alınmalıdır.

<img width="963" height="791" alt="Rplot01" src="https://github.com/user-attachments/assets/47a2e64e-0c0f-4bc8-9f0d-cf13aac00235" />


### 4. Metin Madenciliği: Kararı "Duyu" Verir
Açık uçlu tüketici beyanlarından oluşturulan kelime bulutunda kimyasal içerikler değil; **"KOKU, ECZANE, PARFÜM, GÜNLÜK, HAFİF"** kelimeleri merkeze oturmuştur. Tüketici eczanenin klinik otoritesini istemekte, ancak ürünü kullanırken kendisini "hasta" gibi hissettirmeyecek ferah bir duyusal deneyim satın almaktadır.

<img width="3000" height="2100" alt="Grafik5_Kelime_Bulutu_Turkce_Final" src="https://github.com/user-attachments/assets/d92445c5-3ac5-44bc-a4ca-ff0b5dd8a144" />


---
*Disclaimer: Bu repository'deki veri setleri ve marka bilgileri gizlilik (NDA) kapsamında anonimleştirilmiş veya temsilidir. Yalnızca analitik metodolojiyi sergilemek amacıyla paylaşılmıştır.*

# brand-x-market-research
Phase-0 consumer insight, text mining, and product-market fit analysis for Brand-X dermocosmetics using R. Strategic R&amp;D evaluation.
