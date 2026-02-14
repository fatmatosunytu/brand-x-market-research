# ==============================================================================
# PROJE: SAHA TESTİ - VERİ ANALİZİ VE GÖRSELLEŞTİRME
# HAZIRLAYAN: FATMA TOSUN (Bağımsız Araştırmacı)
# KULLANILAN DİL: R
# ==============================================================================

Sys.setlocale("LC_ALL", "Turkish")

install.packages("wordcloud2")
install.packages("ggwordcloud")
library(ggwordcloud)

# ------------------------------------------------------------------------------
# KÜTÜPHANELERİN YÜKLENMESİ (Eğer yüklü değilse install.packages() ile kurunuz)
# ------------------------------------------------------------------------------
library(tidyverse)   # Veri manipülasyonu ve grafikler (dplyr, ggplot2 vs.)
library(readr)       # CSV dosyasını okumak için
library(tidytext)    # Metin (açık uçlu soru) analizi için
library(wordcloud2)  # Kelime bulutu oluşturmak için
library(RColorBrewer) # Profesyonel renk paletleri

# ------------------------------------------------------------------------------
# VERİNİN YÜKLENMESİ VE SÜTUN İSİMLERİNİN TEMİZLENMESİ
# ------------------------------------------------------------------------------
# Önce bu isimleri teknik ve kısa değişken isimlerine dönüştürüyoruz.

# Dosya adını tam olarak buraya yaz (Çalışma dizininde olduğundan emin ol)
dosya_adi <- "anket verisi.xlsx"
library(readxl) # Eğer yüklü değilse install.packages("readxl") yapmalısın
df_raw <- read_excel("anket verisi.xlsx")

# VERİYİ YÜKLE
df <- read_excel("anket verisi.xlsx")

# TÜM STRATEJİK SÜTUNLARIN İSİMLENDİRİLMESİ
names(df)[2]  <- "sorun_kritikligi"
names(df)[6]  <- "cilt_tipi_gunes"
names(df)[7]  <- "kullanim_sikligi"
names(df)[9]  <- "cilt_dokusu_hissi"
names(df)[12] <- "ust_uste_binme"
names(df)[16] <- "koku_cagrisimi_gunes"
names(df)[17] <- "istenen_koku_gunes"
names(df)[19] <- "satis_kanali_guveni_gunes"
names(df)[20] <- "satinalma_onceligi_gunes"
names(df)[24] <- "kepek_tekrari"
names(df)[27] <- "sertlestirme_etkisi"
names(df)[28] <- "sac_kremi_ihtiyaci"
names(df)[29] <- "yaglanma_hizi"
names(df)[30] <- "koku_cagrisimi_sampuan"
names(df)[31] <- "istenen_koku_sampuan"
names(df)[33] <- "satis_kanali_guveni_sampuan"
names(df)[34] <- "satinalma_onceligi_sampuan"

# SORUN KRİTİKLİĞİNİ SAYISAL (NUMERIC) YAP (Boxplot'un çalışması için şart)
df <- df %>% mutate(sorun_kritikligi = as.numeric(sorun_kritikligi))


# ==============================================================================
# STRATEJIK CAPRAZ ANALIZLER (GUNES KREMI & SAMPUAN)
# ==============================================================================

# Veri Hazirligi: Sorun kritikligini sayisala cevir
df <- df %>% mutate(sorun_kritikligi = as.numeric(sorun_kritikligi))

# ------------------------------------------------------------------------------
# A. CARESIIZLIK VS. BEKLENTI MATRISI (KUTU GRAFIGI + NOKTA DAGILIMI)
# ------------------------------------------------------------------------------

# A1. GUNES KREMI 
grafik_A_gunes <- df %>%
  filter(!is.na(satinalma_onceligi_gunes) & !is.na(sorun_kritikligi)) %>%
  ggplot(aes(x = satinalma_onceligi_gunes, y = sorun_kritikligi, fill = satinalma_onceligi_gunes)) +
  geom_boxplot(alpha = 0.5, outlier.shape = NA) +
  geom_jitter(width = 0.2, height = 0, size = 3, alpha = 0.8, color = "#2c3e50") +
  scale_y_continuous(limits = c(1, 10), breaks = 1:10) +
  
  # STRATEJİK MÜDAHALE: Paragrafları 20 karakterde bir alt satıra kır
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 20)) +
  
  theme_minimal() +
  labs(
    title = "Güneş Kremi: Çaresizlik vs Beklenti",
    subtitle = "Güneş koruma ihtiyacının şiddeti (1-10) ile satın alma motivasyonunun kesişmesi",
    x = "Satın Alma İçin Yeterli Görülen Sonuç",
    y = "Sorun Kritikliği (1 = Düşük, 10 = Acil)"
  ) +
  
  # AÇI MÜDAHALESİ: keskin 45 derece ve hizalama (hjust = 1)
  theme(
    legend.position = "none", 
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, lineheight = 0.8)
  )

print(grafik_A_gunes)
ggsave("A1_Gunes_Caresizlik_Beklenti_Duzeltilmis.png", plot = grafik_A_gunes, width = 15, height = 10, bg = "white", type = "cairo")


# A2. SAMPUAN
grafik_A_sampuan <- df %>%
  filter(!is.na(satinalma_onceligi_sampuan) & !is.na(sorun_kritikligi)) %>%
  ggplot(aes(x = satinalma_onceligi_sampuan, y = sorun_kritikligi, fill = satinalma_onceligi_sampuan)) +
  geom_boxplot(alpha = 0.5, outlier.shape = NA) +
  geom_jitter(width = 0.2, height = 0, size = 3, alpha = 0.8, color = "#c0392b") +
  scale_y_continuous(limits = c(1, 10), breaks = 1:10) +
  
  # STRATEJİK MÜDAHALE: Paragrafları 20 karakterde bir alt satıra kır
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 20)) +
  
  theme_minimal() +
  labs(
    title = "Şampuan: Çaresizlik vs Beklenti",
    subtitle = "Kepek sorununun şiddeti (1-10) ile satın alma motivasyonunun kesişmesi",
    x = "Satın Alma İçin Yeterli Görülen Sonuç",
    y = "Sorun Kritikliği (1 = Düşük, 10 = Acil)"
  ) +
  
  # AÇI MÜDAHALESİ: 15 değil, keskin 45 derece ve hizalama (hjust = 1)
  theme(
    legend.position = "none", 
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, lineheight = 0.8)
  )

print(grafik_A_sampuan)
ggsave("A2_Sampuan_Caresizlik_Beklenti_Duzeltilmis.png", plot = grafik_A_sampuan, width = 15, height = 10, bg = "white", type = "cairo")

# ------------------------------------------------------------------------------
# B. MARKA KONUMLANDIRMA VE ALGI UYUSMAZLIGI (YIGILMIS CUBUK)
# ------------------------------------------------------------------------------

# B1. GUNES KREMI: Koku Algisi ve Satis Kanali 
grafik_B_gunes <- df %>%
  filter(!is.na(koku_cagrisimi_gunes) & !is.na(satis_kanali_guveni_gunes)) %>%
  
  # ÇÖP VERİ FİLTRESİ: Analizi bozan "Emin değilim" vb. yanıtları temizle
  filter(
    !str_detect(str_to_lower(koku_cagrisimi_gunes), "tester|kullanmadım") &
      !str_detect(str_to_lower(satis_kanali_guveni_gunes), "tester|kullanmadım|emin değilim")
  ) %>%
  
  # STRATEJİK KONSOLİDASYON: Birbirinin aynısı olan yanıtları tek çatı altında topla
  mutate(
    satis_kanali_guveni_gunes = case_when(
      str_detect(str_to_lower(satis_kanali_guveni_gunes), "eczane") ~ "Eczane (Konsolide)",
      str_detect(str_to_lower(satis_kanali_guveni_gunes), "medikal") ~ "Medikal / Klinik (Konsolide)",
      TRUE ~ satis_kanali_guveni_gunes # Kalanları (Örn: "İkisi de olabilir") orijinal bırak
    )
  ) %>%
  
  ggplot(aes(x = koku_cagrisimi_gunes, fill = satis_kanali_guveni_gunes)) +
  geom_bar(position = "fill", alpha = 0.9) +
  
  # İLLÜZYON YIKICI: Sütunların içine gerçek kişi sayısını (N) yaz
  geom_text(stat = "count", aes(label = after_stat(count)), position = position_fill(vjust = 0.5), color = "white", fontface = "bold", size = 5) +
  
  scale_y_continuous(labels = scales::percent_format()) +
  
  # METİN KAYDIRMA (WRAP): Uzun cümleleri kırarak grafiğin ezilmesini engelle
  scale_fill_brewer(palette = "Paired", labels = function(x) stringr::str_wrap(x, width = 30)) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 20)) +
  
  theme_minimal() +
  labs(
    title = "Güneş Kremi: Koku Algısı ve Güvenilir Satış Kanalı",
    subtitle = "Formulasyon algisi ile pazarlama kanalinin bilissel uyumu (Konsolide Veri)",
    x = "Kokunun Tüketici Zihnindeki Çağrışımı",
    y = "Oransal Dağılım",
    fill = "Güven Duyulan Satış Kanalı"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, lineheight = 0.8),
    legend.position = "right"
  )

print(grafik_B_gunes)

ggsave("B1_Gunes_Koku_Kanal_Konsolide.png", plot = grafik_B_gunes, width = 11, height = 7, bg = "white", type = "cairo")


# B2. SAMPUAN: Koku Algisi ve Satis Kanali (KONSOLİDE EDİLMİŞ VERİ)
grafik_B_sampuan <- df %>%
  filter(!is.na(koku_cagrisimi_sampuan) & !is.na(satis_kanali_guveni_sampuan)) %>%
  
  # ÇÖP VERİ FİLTRESİ: Analizi bozan yanıtları temizle
  filter(
    !str_detect(str_to_lower(koku_cagrisimi_sampuan), "tester|kullanmadım") &
      !str_detect(str_to_lower(satis_kanali_guveni_sampuan), "tester|kullanmadım")
  ) %>%
  
  # STRATEJİK KONSOLİDASYON: İçinde "eczane" geçen tüm dağınık yanıtları TEK TİP yap.
  mutate(
    satis_kanali_guveni_sampuan = case_when(
      str_detect(str_to_lower(satis_kanali_guveni_sampuan), "eczane") ~ "Eczane (Konsolide)",
      TRUE ~ satis_kanali_guveni_sampuan # Eczane geçmeyenleri (örn: "İçeriğine göre") orijinal haliyle bırak
    )
  ) %>%
  
  # GRAFİK ÇİZİMİ
  ggplot(aes(x = koku_cagrisimi_sampuan, fill = satis_kanali_guveni_sampuan)) +
  geom_bar(position = "fill", alpha = 0.9) +
  # Çubukların içine KİŞİ SAYISINI (n) yazar. İllüzyonu yıkar.
  geom_text(stat = "count", aes(label = after_stat(count)), position = position_fill(vjust = 0.5), color = "white", fontface = "bold", size = 5) +
  scale_y_continuous(labels = scales::percent_format()) +
  
  # Lejantı ve renkleri yeniden düzenle 
  scale_fill_brewer(palette = "Set1", labels = function(x) stringr::str_wrap(x, width = 30)) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 20)) +
  
  theme_minimal() +
  labs(
    title = "Şampuan: Koku Algısı ve Güvenilir Satış Kanalı İişkisi",
    subtitle = "Formulasyon algısı ile pazarlama kanalının bilişsel uyumu (Konsolide Veri)",
    x = "Kokunun Tüketici Zihnindeki Çağrışımı",
    y = "Oransal Dağılım",
    fill = "Güven Duyulan Satış Kanalı"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, lineheight = 0.8),
    legend.position = "right"
  )

print(grafik_B_sampuan)

ggsave("B2_Sampuan_Koku_Kanal_Konsolide.png", plot = grafik_B_sampuan, width = 10, height = 6, bg = "white", type = "cairo")


# ------------------------------------------------------------------------------
# C. RUTIN VE TOLERANS ANALIZI (FACET WRAP)
# ------------------------------------------------------------------------------

# C1. GUNES KREMI (Kullanim Sikligi vs. Ciltte Agirlik/Puturlesme)
grafik_C_gunes <- df %>%
  filter(!is.na(kullanim_sikligi) & !is.na(ust_uste_binme)) %>%
  ggplot(aes(x = ust_uste_binme, fill = ust_uste_binme)) +
  geom_bar(show.legend = FALSE) +
  facet_wrap(~kullanim_sikligi) +
  scale_fill_viridis_d() +
  theme_minimal() +
  labs(
    title = "Güneş Kremi: Kullanım Rutini ve Formule Tolerans",
    subtitle = "Ürünü tazeleme sıklığına göre ciltte ağırlık/pütürleşme reaksiyonları",
    x = "Üst üste Binme / Ağırlıkk Hissi Reaksiyonu",
    y = "Kişi Sayısı"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(grafik_C_gunes)

ggsave("C1_Gunes_Rutin_Tolerans.png", plot = grafik_C_gunes, width = 9, height = 6, bg = "white", type = "cairo")


# C2. ŞAMPUAN (Yağlanma Hızı vs. Saç Kremi İhtiyacı) - CROSS SELL KANITI
grafik_C_sampuan <- df %>%
  # TEMİZLİK: NA değerleri ele
  filter(!is.na(yaglanma_hizi) & !is.na(sac_kremi_ihtiyaci)) %>%
  
  # "Tester", "Kullanmadım", "Bilmiyorum" gibi yanıtları grafikten at
  filter(!str_detect(str_to_lower(sac_kremi_ihtiyaci, locale = "tr"), "tester|kullanmadım|bilmiyorum")) %>%
  filter(!str_detect(str_to_lower(yaglanma_hizi, locale = "tr"), "tester|kullanmadım|bilmiyorum")) %>%
  
  ggplot(aes(x = sac_kremi_ihtiyaci, fill = sac_kremi_ihtiyaci)) +
  geom_bar(show.legend = FALSE) +
  facet_wrap(~yaglanma_hizi) +
  scale_fill_viridis_d(option = "magma") +
  
  # ESTETİK MÜDAHALE: Paragrafları 15 karakterde bir alt satıra kır (İllüzyonu yok et)
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 15)) +
  
  theme_minimal() +
  labs(
    title = "Şampuan: Yağlanma Hızı ve Saç Kremi İhtiyacı",
    subtitle = "Kullanım frekansına göre tamamlayıcı ürün (cross-sell) gereksinimi",
    x = "Saç Kremi İhtiyacı (Kuruluk/Sertlik Reaksiyonu)",
    y = "Kişi Sayısı"
  ) +
  theme(
    # Metinler kırıldığı için açıyı 45 derecede tutmak artık çok daha şık ve okunabilir duracak
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, lineheight = 0.8, size = 9),
    # Facet (Kategori) başlıklarını kalınlaştırarak hiyerarşiyi vurgula
    strip.text = element_text(face = "bold", size = 10)
  )

print(grafik_C_sampuan)

ggsave("C2_Sampuan_Rutin_Tolerans.png", plot = grafik_C_sampuan, width = 12, height = 8, bg = "white", type = "cairo")

# ------------------------------------------------------------------------------
# D. NITEL VERI ANALIZI: METIN MADENCILIGI VE KELIME BULUTU
# ------------------------------------------------------------------------------

# RSTUDIO'NUN BEYNİNİ TÜRKÇEYE ZORLA (Kırmızı hataları bitirir)

library(tidytext)
library(ggwordcloud)
library(stringr)

# Hafıza Temizliği
if(exists("metin_verisi")) rm(metin_verisi)
if(exists("grafik_kelime")) rm(grafik_kelime)

# KESİN RED LİSTESİ (TÜRKÇE KARAKTERLERLE)
copluk_kelimeler <- c(
  "için", "çok", "daha", "gibi", "ile", "ama", "göre", 
  "kadar", "olan", "yok", "olsa", "olurdu", "evet", "hayır", 
  "kullanmadım", "ben", "bana", "beni", "benim", "bnim", 
  "şey", "sadece", "gerekir", "gerek", "olması", "ise", 
  "diye", "olarak", "ürün", "ürünü", "ürünün", "değilim",
  "krem", "kremi", "şampuan", "şampuanı", "saç", "saçlarımı", 
  "geldi", "tester", "verilmedi", "iyi", "kötü", "yeterli", "ederim", 
  "olur", "kullanırım", "verir", "yapar", "hiç", "birdeyerde", 
  "tabi", "her", "çağrıştırduı", "tamamen", "kesinlikle", "gitti", 
  "içeriği", "bir", "olmasi", "düşünüyorum", "birde", "kenarında", "hepsi", "hissettim",
  "verdiği", "gelmesi", "bitmesi", "olabilir", "denemek", "değil", 
  "hayatta", "çünkü", "belli", "tercih", "kenarıda", "veya", "hissettiğimi", "çağrıştırdı", "his", "ürününü",
  "kokusu", "kokuları", "problemim"
)

# METİN İŞLEME VE FİLTRELEME
acik_uclu_sutunlar <- c(15, 16, 17, 18, 19, 20, 25, 26, 30, 31, 32, 33, 34)

metin_verisi <- df %>%
  select(all_of(acik_uclu_sutunlar)) %>%
  mutate(across(everything(), as.character)) %>%
  pivot_longer(cols = everything(), values_to = "yorum") %>%
  # Hayır/Yok gibi kısa cevapları acımasızca ele
  filter(!is.na(yorum) & !str_detect(str_to_lower(yorum, locale = "tr"), "^hayır$|^yok$|^kullanmadım$")) %>%
  
  # R'ın kafasına göre değil, kesin Türkçe küçültme yapıyoruz (İ -> i, I -> ı)
  mutate(yorum = str_to_lower(yorum, locale = "tr")) %>%
  
  unnest_tokens(word, yorum, to_lower = FALSE) %>%
  
  # 2 harf ve daha kısa tüm bağlaçları (ve, de, da, bu, şu, ne, mi) otomatik yok et
  filter(nchar(word) > 2) %>%
  
  # Çöplük listesindekileri filtrele
  filter(!word %in% copluk_kelimeler) %>%
  
  count(word, sort = TRUE) %>%
  filter(n > 1) 

# KELİME BULUTU ÇİZİMİ
if(nrow(metin_verisi) > 0) {
  grafik_kelime <- ggplot(metin_verisi, aes(label = word, size = n, color = n)) +
    geom_text_wordcloud_area(shape = "circle", rm_outside = TRUE, show.legend = TRUE) +
    scale_size_area(max_size = 40, guide = "none") + 
    scale_color_gradient(low = "#34495e", high = "#c0392b", name = "Tekrar Sayısı") + 
    theme_minimal() +
    labs(
      title = "Tüketici Beklentileri ve Marka Algısı: Meta-Temalar",
      subtitle = "Açık uçlu yanıtların (N=13) rafine metin madenciliği analizi",
      caption = "Not: Sadece birden fazla tekrar eden anahtar kelimeler gorsellestirilmistir."
    ) +
    theme(legend.position = "right")
  
  print(grafik_kelime)
  # DOSYAYA KAYDET (Masaüstündeki bu dosyayı aç, RStudio'daki küçük ekrana aldanma)
  ggsave("Grafik5_Kelime_Bulutu_Turkce_Final.png", plot = grafik_kelime, width = 10, height = 7, bg = "white", type = "cairo")
  message("Grafik başarıyla 'Grafik5_Kelime_Bulutu_Turkce_Final.png' adıyla kaydedildi.")
} else {
  message("BRUTAL UYARI: Filtrelemelerden sonra ortak kelime kalmadi.")
}
