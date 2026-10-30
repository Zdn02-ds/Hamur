# PANDUAN LENGKAP STRUKTUR & PEMBAGIAN FIGMA (UI/UX HANDOVER)
## Project: Hamur Tuan Coffeeshop Website
**Basis Desain:** Flowchart Brief, Graphic Standard Manual (GSM), & Wireframe Contoh.jpg

---

## 1. STRUKTUR HALAMAN FIGMA (PAGES HIERARCHY)
Di panel kiri Figma (Pages), buatlah struktur halaman berikut agar file tertata rapi standar industri:

```
📁 HAMUR TUAN — WEBSITE PROJECT
├── 00 📌 Cover & Project Brief
├── 01 🎨 Design Tokens & Style Guide (Colors & Typography)
├── 02 🧩 UI Kit & Master Components
├── 03 📐 Wireframe (Flowchart Low-Fi)
├── 04 💻 Desktop UI (1440px)
├── 05 📱 Mobile UI (390px)
└── 06 ⚡ Interactive Prototype Flows
```

---

## 2. DESIGN TOKENS (STYLES DI FIGMA)

### A. Color Styles (Fill Tokens)
Tambahkan ke **Local Styles -> Color**:
| Nama Style di Figma | HEX Code | RGB | Opacity | Keterangan & Penggunaan |
| :--- | :--- | :--- | :--- | :--- |
| `Brand/Primary Brown` | `#3C150C` | 60, 21, 12 | 100% | Warna utama GSM: Navbar, Heading, Background Dark, Tombol Primer Dark |
| `Brand/Caramel Brown` | `#996A3D` | 153, 106, 61 | 100% | Warna sekunder: Subtitle, Garis aksen, Hover button, Ikon |
| `Brand/Peach Orange` | `#F2C791` | 242, 199, 145 | 100% | Aksen utama: Highlight teks, Logo emblem, Badge latar, Tombol CTA |
| `Neutral/Dark Charcoal` | `#050203` | 5, 2, 3 | 100% | Teks gelap, Footer background pekat |
| `Neutral/Soft White` | `#F2F7FD` | 242, 247, 253 | 100% | Teks terang di atas dark background |
| `Surface/Cream Background` | `#FBF8F3` | 251, 248, 243 | 100% | Latar belakang kanvas website umum |
| `Surface/Card White` | `#FFFFFF` | 255, 255, 255 | 100% | Kartu menu, form, modal dialog |
| `Feedback/Open Green` | `#22C55E` | 34, 197, 94 | 100% | Status Cafe Buka |
| `Feedback/Closed Red` | `#EF4444` | 239, 68, 68 | 100% | Status Cafe Tutup |
| `Social/WhatsApp Green` | `#25D366` | 37, 211, 102 | 100% | Tombol WhatsApp Checkout |

### B. Typography Styles
Tambahkan ke **Local Styles -> Typography**:
| Nama Text Style di Figma | Font Family | Weight | Size | Line Height | Letter Spacing |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `Display/Hero H1 (Desktop)` | Montserrat / Lemon Milk | Black (900) | 64px | 110% (70px) | +3px (Uppercase) |
| `Display/Hero H1 (Mobile)` | Montserrat / Lemon Milk | Black (900) | 40px | 115% (46px) | +2px (Uppercase) |
| `Heading/H2 Section` | Montserrat | Black (900) | 40px | 120% (48px) | +1px (Uppercase) |
| `Heading/H3 Card` | Montserrat | ExtraBold (800) | 22px | 130% (28px) | 0px |
| `Heading/H4 Subtitle` | Playfair Display | SemiBold Italic | 20px | 140% (28px) | 0px |
| `Body/Lead` | Plus Jakarta Sans | Medium (500) | 18px | 160% (28px) | 0px |
| `Body/Regular` | Plus Jakarta Sans | Regular (400) | 16px | 160% (26px) | 0px |
| `Body/Small` | Plus Jakarta Sans | Regular (400) | 14px | 150% (21px) | 0px |
| `UI/Button Bold` | Plus Jakarta Sans | ExtraBold (800) | 15px | 100% | +0.5px |
| `UI/Badge Tag` | Montserrat | ExtraBold (800) | 12px | 100% | +1px (Uppercase) |

---

## 3. MASTER COMPONENTS & VARIANTS (UI KIT)

Di Page `02 🧩 UI Kit & Master Components`, buat komponen-komponen Auto Layout berikut:

### 1. `Component: Navbar`
- **Auto Layout**: Horizontal, `Width: Fixed (1440px)` atau `Hug/Fill`, `Height: 80px`.
- **Padding**: `L: 80px, R: 80px, T: 0, B: 0`. Space between: `Auto`.
- **Fill**: `#3C150C` (opacity 94%), Effect: Background Blur 12px.
- **Children**:
  - `Brand Logo Lockup`: Frame Horizontal (Gap: 12px) -> Logo SVG (44x44) + Text Stack (Title 18px #F2C791 + Subtitle 10px #F2F7FD).
  - `Nav Links Group`: Frame Horizontal (Gap: 32px) -> Home, Pilih Info, Menu & Harga, Lokasi, Tentang Kami, Kontak.
  - `Nav Actions Group`: Frame Horizontal (Gap: 14px) -> Cart Icon Button (44x44 circle) + CTA Button "Pesan Sekarang".

### 2. `Component: Button`
Buat Component Set dengan Variants:
- **Properties**: `Variant` (Primary, Dark, Outline, WhatsApp), `Size` (SM, MD, LG).
- **Auto Layout**: Horizontal, Center, Center.
  - MD: `Padding: X: 24px, Y: 12px`, Corner Radius: `999px` (Pill).
  - Fill: Sesuai style (`Primary` = `#F2C791`, `Dark` = `#3C150C`, `WhatsApp` = `#25D366`).

### 3. `Component: Pilih Informasi Card (Branch Node)`
- **Auto Layout**: Vertical, `Width: 380px`, `Height: Hug`.
- **Padding**: `T: 36px, B: 36px, L: 30px, R: 30px`, `Gap: 20px`.
- **Corner Radius**: `20px`, **Fill**: `#FFFFFF`, **Stroke**: `1px #3C150C` (10% opacity).
- **Children**:
  - `Icon Box`: Frame 56x56, Radius 16px, Fill `#F4EFEA`, Emoji/Icon 24px.
  - `Title`: Montserrat 800, 20px `#3C150C`.
  - `Description`: Plus Jakarta Sans 400, 14px `#695E59`.
  - `Bullet List`: Frame Vertical (Gap: 8px) dengan bullet titik `#996A3D`.
  - `Action Button`: Width Fill Container, Button Dark dengan teks `Buka Info ->`.

### 4. `Component: Menu Item Card`
- **Auto Layout**: Vertical, `Width: 280px - 320px`, `Height: Hug`.
- **Corner Radius**: `20px`, **Fill**: `#FFFFFF`, **Clip content: ON**.
- **Children**:
  - `Card Image`: Width: Fill Container, Height: `200px`, Scale/Fill crop foto menu.
    - Inside Image: Frame absolute untuk `Badge (Pill #3C150C)` di kiri atas dan `Star Fav` di kanan atas.
  - `Card Body`: Frame Vertical, Padding `20px`, Gap `10px`:
    - `Category`: 11px Bold Uppercase `#996A3D`.
    - `Title`: 18px ExtraBold `#3C150C`.
    - `Short Desc`: 13px Regular `#695E59` (2 lines truncate).
    - `Card Footer`: Frame Horizontal, Space between:
      - `Price`: 18px Black `#3C150C` (e.g. "Rp 18.000").
      - `Actions Group`: Tombol "Detail" + Tombol "+ Pesan".

### 5. `Component: Product Detail Modal (Overlay)`
- **Backdrop Frame**: `Width: 1440px, Height: 1024px`, Fill: `#050203` (70% opacity).
- **Dialog Box (Auto Layout Horizontal)**:
  - `Width: 760px, Height: 480px`, Corner Radius: `24px`, Fill: `#FFFFFF`, Clip content: ON.
  - `Left Col (Image)`: Width: `320px`, Fill foto menu vertikal.
  - `Right Col (Content)`: Width: Fill, Padding `36px`, Gap `16px`:
    - Title & Price header.
    - Full Description & Tasting Notes pills.
    - Temperature Toggle: Frame Horizontal (Ice / Hot buttons).
    - Action Buttons: "Pesan via WhatsApp" + "+ Keranjang".

### 6. `Component: Cart Slide-out Drawer`
- **Frame**: `Width: 420px, Height: 100% (1024px)`, Fill: `#FFFFFF`, Shadow: `-10px 0 35px rgba(0,0,0,0.2)`.
- **Header**: `#3C150C` dengan teks "Keranjang Pesanan" + Tombol Close (X).
- **Body**: List item pesanan, kontrol kuantitas (+ / -), subtotal.
- **Footer**: Total Harga + Tombol Checkout hijau WhatsApp.

---

## 4. PEMBAGIAN FRAME HALAMAN (DESKTOP 1440px)
Di Page `04 💻 Desktop UI (1440px)`, susun frame berurutan dari atas ke bawah:

```
[ FRAME: Desktop - 1440 x 5400 ]
├── 1. Frame: Header / Navbar (Sticky)
├── 2. Frame: Section / 01_Home_Hero (Min-Height: 800px)
│   ├── Left Column: Title HAMUR TUAN, Tagline, CTAs, Social Icons
│   └── Right Column: Kettle Leher Angsa Image Card & Floating Badge
├── 3. Frame: Section / Value_Pillars (Height: 180px)
│   └── 4 Columns: Homie, Ramah Mahasiswa, WFC Friendly, Rasa Otentik
├── 4. Frame: Section / 02_Pilih_Informasi (Height: 640px)  <-- [PILIH INFORMASI HUB]
│   ├── Section Header: PILIH INFORMASI
│   └── 3 Branch Cards: Menu & Harga | Lokasi & Jam Buka | Tentang Kami
├── 5. Frame: Section / 03_Branch_Menu (Height: 1200px)    <-- [CABANG 1]
│   ├── Search Bar & Category Pills (Coffee, Mix, Tea, Milk, Snack, Food)
│   └── 3x3 Grid Menu Item Cards
├── 6. Frame: Section / 04_Branch_Lokasi (Height: 850px)   <-- [CABANG 2]
│   ├── Left Column: Alamat, Jam Buka Table, Live Status Badge (Sedang Buka)
│   ├── Right Column: Google Maps Interactive Frame
│   └── Bottom Row: 4 Facility Cards (Wi-Fi, Stopkontak, Indoor AC, Gitar)
├── 7. Frame: Section / 05_Branch_Tentang_Kami (Height: 950px) <-- [CABANG 3]
│   ├── Story Grid: Foto Barista + Cerita Mei 2020 + Filosofi Walikan Hamur & Tuan
│   ├── Visi & Misi Cards
│   ├── GSM Identity Box: Warna & Makna Logo
│   └── Banner "PILIH HALAMAN LAIN": Tombol Kembali ke Menu & Lokasi
├── 8. Frame: Section / 06_Global_CTA (Height: 420px)      <-- [CTA STEP]
│   └── Banner Ajakan Pesan, Tombol WA Kasir, Tombol Rute Maps
└── 9. Frame: Section / 07_Footer (Height: 380px)          <-- [END STEP]
    └── Logo, Alamat, Kategori Menu, Kontak, Copyright & Credits
```

---

## 5. MATRIKS INTERAKSI PROTOTIPE (FIGMA PROTOTYPING)
Di tab **Prototype** Figma, hubungkan frame-frame sesuai alur brief:

| Dari Elemen (Source) | Aksi (Trigger) | Tujuan (Destination) | Tipe Transisi / Animasi |
| :--- | :--- | :--- | :--- |
| Tombol `Lihat Menu` di Hero | **On click** | Scroll to `Section / 03_Branch_Menu` | Animate: Smart Animate (Ease out 400ms) |
| Tombol `Lokasi` di Hero | **On click** | Scroll to `Section / 04_Branch_Lokasi` | Animate: Smart Animate (Ease out 400ms) |
| Card `Daftar Menu & Harga` (Pilih Info) | **On click** | Scroll to `Section / 03_Branch_Menu` | Animate: Smart Animate (Ease out 500ms) |
| Card `Lokasi & Jam Buka` (Pilih Info) | **On click** | Scroll to `Section / 04_Branch_Lokasi` | Animate: Smart Animate (Ease out 500ms) |
| Card `Tentang Hamur Tuan` (Pilih Info) | **On click** | Scroll to `Section / 05_Branch_Tentang_Kami` | Animate: Smart Animate (Ease out 500ms) |
| Tombol `Detail` pada Kartu Menu | **On click** | Open Overlay -> `Component: Product Detail Modal` | Overlay: Center, Dissolve / Move In |
| Tombol `Close (X)` di Modal | **On click** | Close Overlay | Instant |
| Tombol `+ Pesan / Keranjang` | **On click** | Open Overlay -> `Component: Cart Drawer` | Overlay: Top-Right, Move in from right |
| Tombol `Pilih Halaman Lain` di Tentang Kami | **On click** | Scroll to `Section / 02_Pilih_Informasi` atau Menu | Animate: Smart Animate (Loop Back) |
| Tombol `Chat WhatsApp` (CTA) | **On click** | Open Link -> `https://wa.me/6288989538573` | New Tab |

---

## 6. CARA INSTAN MEMASUKKAN KE FIGMA

### Metode A: Drag & Drop Vektor (Langsung Jadi)
1. Buka Figma di browser atau desktop app.
2. Buka folder proyek Anda di:
   `C:\Users\AR\.gemini\antigravity\scratch\hamur-tuan-website\figma-assets\`
3. Tarik (*drag & drop*) file berikut langsung ke kanvas Figma:
   - `figma-color-tokens.svg` &rarr; Menghasilkan papan token warna & tipografi.
   - `figma-components-kit.svg` &rarr; Menghasilkan Navbar, kartu menu, tombol, modal siap pakai.
   - `figma-flowchart-user-journey.svg` &rarr; Menghasilkan diagram alur interaksi.
   - `../assets/images/logo.svg` &rarr; Menghasilkan logo vektor resmi Hamur Tuan.

### Metode B: Menggunakan Plugin "html.to.design" (1-Click Full Frame)
1. Di Figma, buka **Plugins** -> Cari **html.to.design**.
2. Jalankan plugin.
3. Masukkan file `index.html` dari folder `hamur-tuan-website` atau jalankan live server lokal (`http://localhost:3000`).
4. Plugin akan secara otomatis merender seluruh website menjadi frame Figma lengkap dengan teks yang bisa diedit (*editable text*), gambar asli, dan Auto Layout otomatis!
