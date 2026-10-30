# PowerShell Script to generate Pre-Arranged Figma SVG Layouts
param()

$base = "C:\Users\AR\.gemini\antigravity\scratch\hamur-tuan-website"
$figmaDir = "$base\figma-assets"
if (!(Test-Path $figmaDir)) { New-Item -ItemType Directory -Path $figmaDir -Force }

# Read base64 images
$kettleB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$base\assets\images\hero-kettle.png"))
$tubrukB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$base\assets\images\menu\tubruk-susu.jpg"))
$americanoB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$base\assets\images\menu\americano.jpg"))
$shakeratoB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$base\assets\images\menu\shakerato.jpg"))
$friesB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$base\assets\images\menu\french-fries.jpg"))
$platterB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$base\assets\images\menu\mix-platter.jpg"))
$tahuB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$base\assets\images\menu\tahu-bakso.jpg"))

Write-Output "Generating Pre-Arranged Figma Layouts..."

# Common SVG Header & Styles
function Get-SvgHeader($w, $h, $title) {
return @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 $w $h" width="$w" height="$h">
  <defs>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@700;800;900&amp;family=Plus+Jakarta+Sans:wght@400;500;600;700;800&amp;family=Playfair+Display:ital,wght@1,600&amp;display=swap');
      .font-brand { font-family: 'Montserrat', sans-serif; font-weight: 900; }
      .font-heading { font-family: 'Montserrat', sans-serif; font-weight: 800; }
      .font-body { font-family: 'Plus Jakarta Sans', sans-serif; }
      .font-serif { font-family: 'Playfair Display', Georgia, serif; font-style: italic; }
      .shadow-card { filter: drop-shadow(0 10px 25px rgba(60, 21, 12, 0.08)); }
      .shadow-hero { filter: drop-shadow(0 20px 45px rgba(0, 0, 0, 0.5)); }
      .shadow-badge { filter: drop-shadow(0 4px 14px rgba(242, 199, 145, 0.3)); }
    </style>
    <linearGradient id="heroGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#230a05"/>
      <stop offset="45%" stop-color="#3C150C"/>
      <stop offset="80%" stop-color="#542214"/>
      <stop offset="100%" stop-color="#2a0e07"/>
    </linearGradient>
    <linearGradient id="ctaGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#180502"/>
      <stop offset="50%" stop-color="#3C150C"/>
      <stop offset="100%" stop-color="#1e0b06"/>
    </linearGradient>
    <clipPath id="heroKettleClip">
      <rect width="480" height="520" rx="24"/>
    </clipPath>
    <clipPath id="cardImgClip">
      <rect width="285" height="190" rx="16"/>
    </clipPath>
  </defs>
"@
}

# -------------------------------------------------------------
# 1. SECTION: HERO & NAVBAR (1440 x 860)
# -------------------------------------------------------------
$heroSvg = (Get-SvgHeader 1440 860 "01-Hero-Section") + @"
  <!-- Canvas Background -->
  <rect width="1440" height="860" fill="url(#heroGradient)"/>

  <!-- Subtle Radial Glows -->
  <circle cx="1200" cy="200" r="350" fill="#F2C791" opacity="0.08"/>
  <circle cx="150" cy="700" r="400" fill="#996A3D" opacity="0.12"/>

  <!-- ================= NAVBAR ================= -->
  <g id="Navbar" transform="translate(0, 0)">
    <rect width="1440" height="80" fill="#3C150C" fill-opacity="0.96"/>
    <line x1="0" y1="80" x2="1440" y2="80" stroke="#F2C791" stroke-opacity="0.2" stroke-width="1"/>

    <!-- Brand Logo -->
    <g transform="translate(100, 16)">
      <!-- House Badge -->
      <path d="M 24 3 C 26 3, 28 4.5, 30 6 L 44 18 C 47 20, 48 22, 48 25 L 48 42 C 48 45, 45 48, 42 48 L 6 48 C 3 48, 0 45, 0 42 L 0 25 C 0 22, 1 20, 4 18 L 18 6 C 20 4.5, 22 3, 24 3 Z" fill="#F2C791"/>
      <text x="24" y="23" class="font-brand" font-size="6" fill="#3C150C" text-anchor="middle">HAMUR</text>
      <text x="24" y="36" class="font-brand" font-size="12" fill="#3C150C" text-anchor="middle">H</text>
      <text x="24" y="44" class="font-brand" font-size="7" fill="#3C150C" text-anchor="middle">TUAN</text>

      <text x="62" y="24" class="font-brand" font-size="19" fill="#F2C791" letter-spacing="2.5">HAMUR TUAN</text>
      <text x="62" y="41" class="font-body" font-size="10" font-weight="600" fill="#F2F7FD" letter-spacing="1.5">COFFEESHOP MALANG</text>
    </g>

    <!-- Navigation Links -->
    <g transform="translate(540, 46)">
      <text x="0" y="0" class="font-body" font-size="15" font-weight="700" fill="#F2C791">Home</text>
      <line x1="0" y1="8" x2="42" y2="8" stroke="#F2C791" stroke-width="2.5"/>

      <text x="85" y="0" class="font-body" font-size="15" font-weight="600" fill="#F2F7FD">Pilih Info</text>
      <text x="195" y="0" class="font-body" font-size="15" font-weight="600" fill="#F2F7FD">Menu &amp; Harga</text>
      <text x="340" y="0" class="font-body" font-size="15" font-weight="600" fill="#F2F7FD">Lokasi</text>
      <text x="435" y="0" class="font-body" font-size="15" font-weight="600" fill="#F2F7FD">Tentang Kami</text>
      <text x="580" y="0" class="font-body" font-size="15" font-weight="600" fill="#F2F7FD">Kontak</text>
    </g>

    <!-- Right Action CTAs -->
    <g transform="translate(1220, 18)">
      <rect width="120" height="44" rx="22" fill="#F2C791" class="shadow-badge"/>
      <text x="60" y="27" class="font-body" font-size="13" font-weight="800" fill="#3C150C" text-anchor="middle">Pesan Sekarang</text>
    </g>
  </g>

  <!-- ================= HERO CONTENT ================= -->
  <g id="Hero-Content" transform="translate(100, 150)">
    <!-- Left Column (Typography & Action) -->
    <g transform="translate(0, 20)">
      <!-- Pill Badge -->
      <rect width="320" height="34" rx="17" fill="#F2C791" fill-opacity="0.16" stroke="#F2C791" stroke-opacity="0.4" stroke-width="1.5"/>
      <circle cx="20" cy="17" r="4.5" fill="#F2C791"/>
      <text x="35" y="22" class="font-body" font-size="12" font-weight="800" fill="#F2C791" letter-spacing="1">COFFEESHOP HOMIE &amp; TERJANGKAU MALANG</text>

      <!-- Headline -->
      <text x="0" y="95" class="font-brand" font-size="62" fill="#FFFFFF" letter-spacing="3">HAMUR TUAN</text>
      <text x="0" y="160" class="font-brand" font-size="62" fill="#F2C791" letter-spacing="3">OMAH KOPI</text>

      <!-- Tagline -->
      <text x="0" y="205" class="font-serif" font-size="22" fill="#F2C791">"Start your day with an authentic warmth of coffee."</text>

      <!-- Description Paragraph -->
      <text x="0" y="245" class="font-body" font-size="16" fill="#F2F7FD" fill-opacity="0.9" line-height="1.6">
        <tspan x="0" dy="0">Selamat datang di Hamur Tuan. Terinspirasi dari bahasa walikan khas Malang,</tspan>
        <tspan x="0" dy="26">Hamur berarti Rumah dan Tuan adalah cara kami menghormati setiap tamu</tspan>
        <tspan x="0" dy="26">yang hadir. Nikmati secangkir kopi istimewa, makanan lezat, dan suasana</tspan>
        <tspan x="0" dy="26">hangat bak rumah sendiri dengan harga ramah kantong pelajar &amp; mahasiswa.</tspan>
      </text>

      <!-- CTA Buttons Group -->
      <g transform="translate(0, 360)">
        <!-- Button 1: Menu & Harga -->
        <rect width="210" height="52" rx="26" fill="#F2C791" class="shadow-badge"/>
        <text x="105" y="32" class="font-body" font-size="15" font-weight="800" fill="#3C150C" text-anchor="middle">📜 Lihat Menu &amp; Harga</text>

        <!-- Button 2: Lokasi -->
        <g transform="translate(230, 0)">
          <rect width="200" height="52" rx="26" fill="none" stroke="#F2C791" stroke-opacity="0.6" stroke-width="2"/>
          <text x="100" y="32" class="font-body" font-size="15" font-weight="700" fill="#F2F7FD" text-anchor="middle">📍 Lokasi &amp; Jam Buka</text>
        </g>
      </g>

      <!-- Social Media Strip -->
      <g transform="translate(0, 460)">
        <line x1="0" y1="0" x2="620" y2="0" stroke="#F2C791" stroke-opacity="0.2" stroke-width="1"/>
        <text x="0" y="35" class="font-body" font-size="12" font-weight="700" fill="#F2F7FD" fill-opacity="0.7" letter-spacing="1">IKUTI KAMI:</text>

        <g transform="translate(100, 15)">
          <!-- Instagram Circle -->
          <circle cx="20" cy="20" r="18" fill="#FFFFFF" fill-opacity="0.08" stroke="#F2C791" stroke-opacity="0.3"/>
          <text x="20" y="24" font-size="14" fill="#F2C791" text-anchor="middle">📸</text>

          <!-- TikTok Circle -->
          <circle cx="68" cy="20" r="18" fill="#FFFFFF" fill-opacity="0.08" stroke="#F2C791" stroke-opacity="0.3"/>
          <text x="68" y="24" font-size="14" fill="#F2C791" text-anchor="middle">🎵</text>

          <!-- WhatsApp Circle -->
          <circle cx="116" cy="20" r="18" fill="#FFFFFF" fill-opacity="0.08" stroke="#F2C791" stroke-opacity="0.3"/>
          <text x="116" y="24" font-size="14" fill="#F2C791" text-anchor="middle">💬</text>

          <!-- Email Circle -->
          <circle cx="164" cy="20" r="18" fill="#FFFFFF" fill-opacity="0.08" stroke="#F2C791" stroke-opacity="0.3"/>
          <text x="164" y="24" font-size="14" fill="#F2C791" text-anchor="middle">✉️</text>
        </g>
      </g>
    </g>

    <!-- Right Column: Hero Photo (Kettle Pour Over) -->
    <g transform="translate(740, 20)">
      <rect width="480" height="520" rx="24" fill="#1b0703" class="shadow-hero"/>
      
      <!-- Embedded High-Res Photo -->
      <g clip-path="url(#heroKettleClip)">
        <image xlink:href="data:image/png;base64,$kettleB64" width="480" height="520" preserveAspectRatio="xMidYMid slice"/>
        <!-- Bottom Dark Gradient Overlay -->
        <rect y="320" width="480" height="200" fill="url(#heroGradient)" opacity="0.85"/>
      </g>
      <!-- Border stroke -->
      <rect width="480" height="520" rx="24" fill="none" stroke="#F2C791" stroke-opacity="0.3" stroke-width="1.5"/>

      <!-- Floating Glass Badge -->
      <g transform="translate(24, 420)">
        <rect width="432" height="74" rx="16" fill="#2b0e07" fill-opacity="0.9" stroke="#F2C791" stroke-opacity="0.4" stroke-width="1.5"/>
        <rect x="16" y="15" width="44" height="44" rx="12" fill="#F2C791"/>
        <text x="38" y="44" font-size="22" text-anchor="middle">☕</text>
        <text x="75" y="34" class="font-heading" font-size="15" fill="#FFFFFF">Seduhan Manual &amp; Barista Craft</text>
        <text x="75" y="52" class="font-body" font-size="12" fill="#F2C791">Biji kopi pilihan nusantara dengan aroma kuat &amp; rasa memikat</text>
      </g>
    </g>
  </g>
</svg>
"@

$heroSvg | Out-File -FilePath "$figmaDir\02-Hero-and-Navbar-1440.svg" -Encoding utf8
Write-Output "Created: 02-Hero-and-Navbar-1440.svg"

# -------------------------------------------------------------
# 2. SECTION: PILIH INFORMASI (1440 x 680)
# -------------------------------------------------------------
$pilihSvg = (Get-SvgHeader 1440 680 "03-Pilih-Informasi-Hub") + @"
  <rect width="1440" height="680" fill="#FFFFFF"/>

  <!-- Section Header -->
  <g transform="translate(720, 60)" text-anchor="middle">
    <rect x="-80" y="0" width="160" height="30" rx="15" fill="#F2C791" fill-opacity="0.25"/>
    <text x="0" y="20" class="font-body" font-size="12" font-weight="800" fill="#3C150C" letter-spacing="1.5">PANDUAN KUNJUNGAN</text>
    <text x="0" y="65" class="font-brand" font-size="38" fill="#3C150C" letter-spacing="1">PILIH INFORMASI</text>
    <text x="0" y="95" class="font-body" font-size="15" fill="#695E59">Sesuai alur kunjungan Anda, pilih salah satu informasi utama yang ingin Anda jelajahi di Hamur Tuan Coffeeshop:</text>
  </g>

  <!-- 3 Big Cards Grid -->
  <g transform="translate(100, 190)">
    <!-- Card 1: Menu -->
    <g transform="translate(0, 0)">
      <rect width="395" height="420" rx="20" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1" stroke-width="1.5" class="shadow-card"/>
      <rect width="395" height="6" rx="3" fill="#3C150C"/>
      
      <rect x="32" y="35" width="60" height="60" rx="16" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="62" y="74" font-size="28" text-anchor="middle">📜</text>

      <text x="32" y="130" class="font-brand" font-size="21" fill="#3C150C">DAFTAR MENU &amp; HARGA</text>
      <text x="32" y="160" class="font-body" font-size="14" fill="#695E59">
        <tspan x="32" dy="0">Jelajahi seluruh varian minuman kopi,</tspan>
        <tspan x="32" dy="22">racikan signature, teh buah segar,</tspan>
        <tspan x="32" dy="22">aneka snack, dan makanan berat.</tspan>
      </text>

      <!-- Checkpoints -->
      <g transform="translate(32, 235)">
        <circle cx="6" cy="6" r="4" fill="#996A3D"/>
        <text x="18" y="10" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Lihat daftar menu lengkap &amp; harga resmi</text>
        
        <circle cx="6" cy="34" r="4" fill="#996A3D"/>
        <text x="18" y="38" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Lihat detail komposisi &amp; profil rasa</text>

        <circle cx="6" cy="62" r="4" fill="#996A3D"/>
        <text x="18" y="66" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Pesan langsung via WhatsApp &amp; Estimator</text>
      </g>

      <!-- Bottom Button -->
      <g transform="translate(32, 345)">
        <rect width="331" height="46" rx="12" fill="#3C150C"/>
        <text x="165" y="28" class="font-body" font-size="14" font-weight="800" fill="#F2C791" text-anchor="middle">Buka Menu Lengkap →</text>
      </g>
    </g>

    <!-- Card 2: Lokasi -->
    <g transform="translate(422, 0)">
      <rect width="395" height="420" rx="20" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1" stroke-width="1.5" class="shadow-card"/>
      <rect width="395" height="6" rx="3" fill="#996A3D"/>
      
      <rect x="32" y="35" width="60" height="60" rx="16" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="62" y="74" font-size="28" text-anchor="middle">📍</text>

      <text x="32" y="130" class="font-brand" font-size="21" fill="#3C150C">LOKASI &amp; JAM BUKA</text>
      <text x="32" y="160" class="font-body" font-size="14" fill="#695E59">
        <tspan x="32" dy="0">Temukan alamat lengkap kami di Blimbing</tspan>
        <tspan x="32" dy="22">Malang, cek status operasional live,</tspan>
        <tspan x="32" dy="22">peta rute, dan fasilitas coffeeshop.</tspan>
      </text>

      <!-- Checkpoints -->
      <g transform="translate(32, 235)">
        <circle cx="6" cy="6" r="4" fill="#996A3D"/>
        <text x="18" y="10" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Alamat lengkap di Jl. Letjen S. Parman</text>
        
        <circle cx="6" cy="34" r="4" fill="#996A3D"/>
        <text x="18" y="38" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Peta interaktif &amp; petunjuk arah Google Maps</text>

        <circle cx="6" cy="62" r="4" fill="#996A3D"/>
        <text x="18" y="66" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Jam buka &amp; status live Buka / Tutup</text>
      </g>

      <!-- Bottom Button -->
      <g transform="translate(32, 345)">
        <rect width="331" height="46" rx="12" fill="#3C150C"/>
        <text x="165" y="28" class="font-body" font-size="14" font-weight="800" fill="#F2C791" text-anchor="middle">Buka Informasi Lokasi →</text>
      </g>
    </g>

    <!-- Card 3: Tentang Kami -->
    <g transform="translate(845, 0)">
      <rect width="395" height="420" rx="20" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1" stroke-width="1.5" class="shadow-card"/>
      <rect width="395" height="6" rx="3" fill="#F2C791"/>
      
      <rect x="32" y="35" width="60" height="60" rx="16" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="62" y="74" font-size="28" text-anchor="middle">☕</text>

      <text x="32" y="130" class="font-brand" font-size="21" fill="#3C150C">TENTANG HAMUR TUAN</text>
      <text x="32" y="160" class="font-body" font-size="14" fill="#695E59">
        <tspan x="32" dy="0">Kisah di balik berdirinya coffeeshop sejak</tspan>
        <tspan x="32" dy="22">Mei 2020, filosofi bahasa walikan khas</tspan>
        <tspan x="32" dy="22">Malang, visi misi, &amp; visual GSM.</tspan>
      </text>

      <!-- Checkpoints -->
      <g transform="translate(32, 235)">
        <circle cx="6" cy="6" r="4" fill="#996A3D"/>
        <text x="18" y="10" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Cerita berdirinya Hamur Tuan Mei 2020</text>
        
        <circle cx="6" cy="34" r="4" fill="#996A3D"/>
        <text x="18" y="38" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Filosofi "Hamur" &amp; penghormatan "Tuan"</text>

        <circle cx="6" cy="62" r="4" fill="#996A3D"/>
        <text x="18" y="66" class="font-body" font-size="13" font-weight="700" fill="#3C150C">Visi, misi &amp; standar mutu pelayanan</text>
      </g>

      <!-- Bottom Button -->
      <g transform="translate(32, 345)">
        <rect width="331" height="46" rx="12" fill="#3C150C"/>
        <text x="165" y="28" class="font-body" font-size="14" font-weight="800" fill="#F2C791" text-anchor="middle">Baca Cerita Kami →</text>
      </g>
    </g>
  </g>
</svg>
"@

$pilihSvg | Out-File -FilePath "$figmaDir\03-Pilih-Informasi-Hub-1440.svg" -Encoding utf8
Write-Output "Created: 03-Pilih-Informasi-Hub-1440.svg"

# -------------------------------------------------------------
# 3. SECTION: MENU KATALOG GRID (1440 x 1220)
# -------------------------------------------------------------
$menuSvg = (Get-SvgHeader 1440 1220 "04-Menu-Katalog-Grid") + @"
  <rect width="1440" height="1220" fill="#FBF8F3"/>

  <!-- Section Header -->
  <g transform="translate(720, 50)" text-anchor="middle">
    <rect x="-85" y="0" width="170" height="30" rx="15" fill="#F2C791" fill-opacity="0.25"/>
    <text x="0" y="20" class="font-body" font-size="12" font-weight="800" fill="#3C150C" letter-spacing="1.5">BUKU MENU HAMUR TUAN</text>
    <text x="0" y="65" class="font-brand" font-size="38" fill="#3C150C" letter-spacing="1">DAFTAR MENU &amp; HARGA</text>
    <text x="0" y="95" class="font-body" font-size="15" fill="#695E59">Disajikan segar setiap hari dengan bahan baku bermutu tinggi dan racikan barista berpengalaman.</text>
  </g>

  <!-- Filter & Search Toolbar (1240 x 100) -->
  <g transform="translate(100, 180)">
    <rect width="1240" height="105" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>

    <!-- Search Input Box -->
    <g transform="translate(24, 15)">
      <rect width="380" height="40" rx="20" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.15"/>
      <text x="18" y="25" font-size="14">🔍</text>
      <text x="45" y="25" class="font-body" font-size="13" fill="#695E59">Cari menu favorit Anda...</text>
    </g>
    <text x="1216" y="40" class="font-body" font-size="13" font-weight="700" fill="#996A3D" text-anchor="end">Menampilkan 24 menu pilihan</text>

    <!-- Category Pills Row -->
    <g transform="translate(24, 68)">
      <!-- All Active -->
      <rect width="125" height="30" rx="15" fill="#3C150C"/>
      <text x="62" y="20" class="font-body" font-size="12" font-weight="800" fill="#F2C791" text-anchor="middle">✨ Semua Menu</text>

      <g transform="translate(135, 0)">
        <rect width="115" height="30" rx="15" fill="#FBF8F3"/>
        <text x="57" y="20" class="font-body" font-size="12" font-weight="700" fill="#695E59" text-anchor="middle">☕ Coffee Bar</text>
      </g>

      <g transform="translate(260, 0)">
        <rect width="135" height="30" rx="15" fill="#FBF8F3"/>
        <text x="67" y="20" class="font-body" font-size="12" font-weight="700" fill="#695E59" text-anchor="middle">🍹 Mix Signature</text>
      </g>

      <g transform="translate(405, 0)">
        <rect width="115" height="30" rx="15" fill="#FBF8F3"/>
        <text x="57" y="20" class="font-body" font-size="12" font-weight="700" fill="#695E59" text-anchor="middle">🍵 Artisan Tea</text>
      </g>

      <g transform="translate(530, 0)">
        <rect width="125" height="30" rx="15" fill="#FBF8F3"/>
        <text x="62" y="20" class="font-body" font-size="12" font-weight="700" fill="#695E59" text-anchor="middle">🥛 Specialty Milk</text>
      </g>

      <g transform="translate(665, 0)">
        <rect width="125" height="30" rx="15" fill="#FBF8F3"/>
        <text x="62" y="20" class="font-body" font-size="12" font-weight="700" fill="#695E59" text-anchor="middle">🍟 Snack &amp; Bites</text>
      </g>

      <g transform="translate(800, 0)">
        <rect width="145" height="30" rx="15" fill="#FBF8F3"/>
        <text x="72" y="20" class="font-body" font-size="12" font-weight="700" fill="#695E59" text-anchor="middle">🍛 Main Course Food</text>
      </g>
    </g>
  </g>

  <!-- ================= 8 MENU ITEM CARDS (2 ROWS X 4 COLUMNS) ================= -->
  <!-- ROW 1 -->
  <g transform="translate(100, 310)">
    <!-- CARD 1: Kokuto Latte -->
    <g transform="translate(0, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$tubrukB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="85" height="24" rx="12" fill="#3C150C"/>
      <text x="54" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">BEST SELLER</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">COFFEE BAR</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">Kokuto Latte Aren</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">Kopi susu aren ala Jepang,</tspan>
        <tspan x="18" dy="18">smoky legit wangi kelapa alami.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="17" fill="#3C150C">Rp 18.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>

    <!-- CARD 2: Americano -->
    <g transform="translate(318, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$americanoB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="95" height="24" rx="12" fill="#3C150C"/>
      <text x="59" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">REKOMENDASI</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">COFFEE BAR</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">Americano</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">Double shot espresso kaya crema</tspan>
        <tspan x="18" dy="18">bersih, segar dan nikmat.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="16" fill="#3C150C">Rp 13.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>

    <!-- CARD 3: Shakerato Fruity -->
    <g transform="translate(636, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$shakeratoB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="85" height="24" rx="12" fill="#3C150C"/>
      <text x="54" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">BEST SELLER</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">SIGNATURE MIX</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">Shakerato Fruity</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">Espresso shake dengan leci, peach,</tspan>
        <tspan x="18" dy="18">&amp; bulir jeruk dingin berbusa.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="17" fill="#3C150C">Rp 18.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>

    <!-- CARD 4: Kopi Tubruk Susu -->
    <g transform="translate(954, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$tubrukB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="75" height="24" rx="12" fill="#3C150C"/>
      <text x="49" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">FAVORIT</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">COFFEE BAR</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">Kopi Tubruk Susu</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">Kopi tubruk klasik Jawa dipadu</tspan>
        <tspan x="18" dy="18">kental manis legit hangat.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="17" fill="#3C150C">Rp 10.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>
  </g>

  <!-- ROW 2 -->
  <g transform="translate(100, 740)">
    <!-- CARD 5: Mix Platter -->
    <g transform="translate(0, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$platterB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="85" height="24" rx="12" fill="#3C150C"/>
      <text x="54" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">BEST SELLER</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">SNACK &amp; BITES</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">Mix Platter Hamur</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">French Fries, Sosis mekar, &amp;</tspan>
        <tspan x="18" dy="18">Nugget ayam krispi komplit.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="17" fill="#3C150C">Rp 20.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>

    <!-- CARD 6: French Fries -->
    <g transform="translate(318, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$friesB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="75" height="24" rx="12" fill="#3C150C"/>
      <text x="49" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">CRISPY</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">SNACK &amp; BITES</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">French Fries</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">Kentang goreng renyah bumbu</tspan>
        <tspan x="18" dy="18">rempah gurih cocol saus sambal.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="16" fill="#3C150C">Rp 15.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>

    <!-- CARD 7: Tahu Bakso -->
    <g transform="translate(636, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$tahuB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="85" height="24" rx="12" fill="#3C150C"/>
      <text x="54" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">KHAS MALANG</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">SNACK &amp; BITES</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">Tahu Bakso Goreng</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">Tahu pong goreng renyah isi</tspan>
        <tspan x="18" dy="18">bakso sapi padat &amp; saus cabai.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="17" fill="#3C150C">Rp 15.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>

    <!-- CARD 8: Mie Hamur Tuan -->
    <g transform="translate(954, 0)">
      <rect width="285" height="410" rx="18" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
      <g clip-path="url(#cardImgClip)">
        <image xlink:href="data:image/jpeg;base64,$platterB64" width="285" height="190" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <rect x="12" y="12" width="85" height="24" rx="12" fill="#3C150C"/>
      <text x="54" y="28" class="font-brand" font-size="9" fill="#F2C791" text-anchor="middle">SIGNATURE</text>

      <text x="18" y="220" class="font-body" font-size="11" font-weight="700" fill="#996A3D">MAIN COURSE FOOD</text>
      <text x="18" y="244" class="font-brand" font-size="17" fill="#3C150C">Mie Hamur Tuan</text>
      <text x="18" y="266" class="font-body" font-size="12" fill="#695E59">
        <tspan x="18" dy="0">Mie kenyal chili oil aromatik,</tspan>
        <tspan x="18" dy="18">ayam suwir, telur &amp; pangsit krispi.</tspan>
      </text>

      <line x1="18" y1="315" x2="267" y2="315" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="18" y="348" class="font-brand" font-size="17" fill="#3C150C">Rp 18.000</text>
      
      <rect x="150" y="328" width="55" height="32" rx="8" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.2"/>
      <text x="177" y="349" class="font-body" font-size="11" font-weight="700" fill="#3C150C" text-anchor="middle">Detail</text>

      <rect x="212" y="328" width="55" height="32" rx="8" fill="#3C150C"/>
      <text x="239" y="349" class="font-body" font-size="11" font-weight="800" fill="#F2C791" text-anchor="middle">+ Pesan</text>
    </g>
  </g>
</svg>
"@

$menuSvg | Out-File -FilePath "$figmaDir\04-Menu-Katalog-Grid-1440.svg" -Encoding utf8
Write-Output "Created: 04-Menu-Katalog-Grid-1440.svg"

# -------------------------------------------------------------
# 4. SECTION: LOKASI & JAM OPERASIONAL (1440 x 860)
# -------------------------------------------------------------
$lokasiSvg = (Get-SvgHeader 1440 860 "05-Lokasi-dan-Peta") + @"
  <rect width="1440" height="860" fill="#FFFFFF"/>

  <!-- Section Header -->
  <g transform="translate(720, 50)" text-anchor="middle">
    <rect x="-70" y="0" width="140" height="30" rx="15" fill="#F2C791" fill-opacity="0.25"/>
    <text x="0" y="20" class="font-body" font-size="12" font-weight="800" fill="#3C150C" letter-spacing="1.5">KUNJUNGI KAMI</text>
    <text x="0" y="65" class="font-brand" font-size="38" fill="#3C150C" letter-spacing="1">LOKASI &amp; JAM OPERASIONAL</text>
    <text x="0" y="95" class="font-body" font-size="15" fill="#695E59">Singgah dan nikmati suasana hangat coffeeshop kami yang strategis di kawasan Blimbing, Kota Malang.</text>
  </g>

  <g transform="translate(100, 180)">
    <!-- Left Column: Address & Hours Cards -->
    <g transform="translate(0, 0)">
      <!-- Address Card -->
      <g transform="translate(0, 0)">
        <rect width="580" height="210" rx="18" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
        <rect x="24" y="24" width="44" height="44" rx="12" fill="#3C150C"/>
        <text x="46" y="52" font-size="20" fill="#F2C791" text-anchor="middle">📍</text>

        <text x="80" y="52" class="font-brand" font-size="18" fill="#3C150C">ALAMAT COFFEESHOP</text>
        <text x="24" y="95" class="font-body" font-size="15" font-weight="700" fill="#3C150C">Hamur Tuan Coffeeshop</text>
        <text x="24" y="118" class="font-body" font-size="14" fill="#695E59">Jl. Letjen S. Parman No. 56, Kel. Purwantoro, Kec. Blimbing, Kota Malang</text>

        <rect x="24" y="145" width="270" height="42" rx="21" fill="#3C150C"/>
        <text x="159" y="171" class="font-body" font-size="13" font-weight="800" fill="#F2C791" text-anchor="middle">Buka Petunjuk Arah di Maps →</text>
      </g>

      <!-- Operational Hours Card with Live Status -->
      <g transform="translate(0, 230)">
        <rect width="580" height="230" rx="18" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1" class="shadow-card"/>
        <rect x="24" y="24" width="44" height="44" rx="12" fill="#3C150C"/>
        <text x="46" y="52" font-size="20" fill="#F2C791" text-anchor="middle">⏰</text>

        <text x="80" y="52" class="font-brand" font-size="18" fill="#3C150C">JAM OPERASIONAL</text>

        <!-- Hours Table -->
        <g transform="translate(24, 90)">
          <text x="0" y="0" class="font-body" font-size="14" font-weight="700" fill="#3C150C">Senin – Kamis</text>
          <text x="532" y="0" class="font-body" font-size="14" font-weight="600" fill="#695E59" text-anchor="end">10:00 – 23:00 WIB</text>
          
          <line x1="0" y1="12" x2="532" y2="12" stroke="#3C150C" stroke-opacity="0.08"/>

          <text x="0" y="32" class="font-body" font-size="14" font-weight="700" fill="#3C150C">Jumat</text>
          <text x="532" y="32" class="font-body" font-size="14" font-weight="600" fill="#695E59" text-anchor="end">13:00 – 00:00 WIB</text>
          
          <line x1="0" y1="44" x2="532" y2="44" stroke="#3C150C" stroke-opacity="0.08"/>

          <text x="0" y="64" class="font-body" font-size="14" font-weight="700" fill="#3C150C">Sabtu – Minggu</text>
          <text x="532" y="64" class="font-body" font-size="14" font-weight="600" fill="#695E59" text-anchor="end">10:00 – 00:00 WIB</text>
        </g>

        <!-- Live Status Pill -->
        <g transform="translate(24, 180)">
          <rect width="532" height="34" rx="8" fill="#FFFFFF" stroke="#3C150C" stroke-opacity="0.1"/>
          <circle cx="20" cy="17" r="5" fill="#22C55E"/>
          <text x="32" y="21" class="font-body" font-size="12" font-weight="800" fill="#16A34A">SEDANG BUKA</text>
          <text x="515" y="21" class="font-body" font-size="12" font-weight="700" fill="#3C150C" text-anchor="end">Tutup pukul 23:00 WIB</text>
        </g>
      </g>
    </g>

    <!-- Right Column: Interactive Map Frame -->
    <g transform="translate(620, 0)">
      <rect width="620" height="460" rx="20" fill="#e8ecef" stroke="#3C150C" stroke-opacity="0.15" class="shadow-card"/>
      
      <!-- Mock Map Roads & Graphics -->
      <path d="M 0 140 Q 200 160 400 110 T 620 180" stroke="#FFFFFF" stroke-width="24" fill="none"/>
      <path d="M 0 140 Q 200 160 400 110 T 620 180" stroke="#FFC107" stroke-width="4" stroke-dasharray="10,8" fill="none"/>
      <path d="M 320 0 L 320 460" stroke="#FFFFFF" stroke-width="20" fill="none"/>
      <path d="M 120 0 L 120 460" stroke="#FFFFFF" stroke-width="12" fill="none"/>
      <path d="M 480 0 L 480 460" stroke="#FFFFFF" stroke-width="14" fill="none"/>
      <rect x="180" y="200" width="120" height="90" rx="8" fill="#d2d8de"/>
      <rect x="350" y="220" width="100" height="70" rx="8" fill="#d2d8de"/>

      <!-- Map Pin Marker for Hamur Tuan -->
      <g transform="translate(320, 120)">
        <ellipse cx="0" cy="40" rx="18" ry="6" fill="#000000" opacity="0.25"/>
        <path d="M 0 0 C -22 0, -35 15, -35 32 C -35 52, 0 80, 0 80 C 0 80, 35 52, 35 32 C 35 15, 22 0, 0 0 Z" fill="#3C150C"/>
        <circle cx="0" cy="30" r="14" fill="#F2C791"/>
        <text x="0" y="35" class="font-brand" font-size="12" fill="#3C150C" text-anchor="middle">H</text>

        <!-- Callout Pin Card -->
        <rect x="-100" y="-55" width="200" height="44" rx="10" fill="#FFFFFF" stroke="#3C150C" stroke-width="1" class="shadow-card"/>
        <text x="0" y="-35" class="font-brand" font-size="12" fill="#3C150C" text-anchor="middle">HAMUR TUAN BLIMBING</text>
        <text x="0" y="-20" class="font-body" font-size="10" fill="#996A3D" text-anchor="middle">Jl. Letjen S. Parman 56</text>
      </g>
    </g>
  </g>

  <!-- 4 Facilities Row (Bottom) -->
  <g transform="translate(100, 680)">
    <!-- Facility 1 -->
    <g transform="translate(0, 0)">
      <rect width="290" height="110" rx="16" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="24" y="45" font-size="28">📶</text>
      <text x="65" y="40" class="font-heading" font-size="14" fill="#3C150C">Free High-Speed Wi-Fi</text>
      <text x="65" y="60" class="font-body" font-size="11" fill="#695E59">Koneksi cepat untuk nugas &amp; kerja WFC.</text>
    </g>

    <!-- Facility 2 -->
    <g transform="translate(316, 0)">
      <rect width="290" height="110" rx="16" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="24" y="45" font-size="28">🔌</text>
      <text x="65" y="40" class="font-heading" font-size="14" fill="#3C150C">Stopkontak Tiap Meja</text>
      <text x="65" y="60" class="font-body" font-size="11" fill="#695E59">Daya laptop &amp; smartphone selalu terjamin.</text>
    </g>

    <!-- Facility 3 -->
    <g transform="translate(632, 0)">
      <rect width="290" height="110" rx="16" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="24" y="45" font-size="28">🍃</text>
      <text x="65" y="40" class="font-heading" font-size="14" fill="#3C150C">Indoor AC &amp; Semi-Outdoor</text>
      <text x="65" y="60" class="font-body" font-size="11" fill="#695E59">Area sejuk ber-AC &amp; smoking area santai.</text>
    </g>

    <!-- Facility 4 -->
    <g transform="translate(948, 0)">
      <rect width="292" height="110" rx="16" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1"/>
      <text x="24" y="45" font-size="28">🎸</text>
      <text x="65" y="40" class="font-heading" font-size="14" fill="#3C150C">Gitar Akustik &amp; Games</text>
      <text x="65" y="60" class="font-body" font-size="11" fill="#695E59">Kartu &amp; gitar untuk kumpul seru teman.</text>
    </g>
  </g>
</svg>
"@

$lokasiSvg | Out-File -FilePath "$figmaDir\05-Lokasi-dan-Jam-Buka-1440.svg" -Encoding utf8
Write-Output "Created: 05-Lokasi-dan-Jam-Buka-1440.svg"

# -------------------------------------------------------------
# 5. SECTION: TENTANG KAMI & LOOP BACK (1440 x 950)
# -------------------------------------------------------------
$tentangSvg = (Get-SvgHeader 1440 950 "06-Tentang-Kami-Filosofi") + @"
  <rect width="1440" height="950" fill="#FFFFFF"/>

  <!-- Section Header -->
  <g transform="translate(720, 50)" text-anchor="middle">
    <rect x="-80" y="0" width="160" height="30" rx="15" fill="#F2C791" fill-opacity="0.25"/>
    <text x="0" y="20" class="font-body" font-size="12" font-weight="800" fill="#3C150C" letter-spacing="1.5">CERITA BRAND KAMI</text>
    <text x="0" y="65" class="font-brand" font-size="38" fill="#3C150C" letter-spacing="1">TENTANG HAMUR TUAN</text>
    <text x="0" y="95" class="font-body" font-size="15" fill="#695E59">Kisah tentang persahabatan, kecintaan pada kopi, dan rasa hangat seperti di rumah sendiri.</text>
  </g>

  <!-- Content Grid -->
  <g transform="translate(100, 180)">
    <!-- Left Column: Photo Card -->
    <g transform="translate(0, 0)">
      <rect width="580" height="360" rx="20" fill="#1b0703" class="shadow-card"/>
      <g clip-path="url(#heroKettleClip)">
        <image xlink:href="data:image/png;base64,$kettleB64" width="580" height="360" preserveAspectRatio="xMidYMid slice"/>
      </g>
      <!-- Floating Badge -->
      <g transform="translate(380, 260)">
        <rect width="175" height="75" rx="16" fill="#3C150C" class="shadow-badge"/>
        <text x="87" y="32" class="font-brand" font-size="20" fill="#F2C791" text-anchor="middle">Est. 2020</text>
        <text x="87" y="52" class="font-body" font-size="11" font-weight="700" fill="#FFFFFF" text-anchor="middle">Didirikan di Malang</text>
      </g>
    </g>

    <!-- Right Column: Story Text & Philosophy -->
    <g transform="translate(620, 0)">
      <text x="0" y="25" class="font-serif" font-size="20" fill="#996A3D">Sejarah &amp; Profil Singkat</text>
      <text x="0" y="60" class="font-body" font-size="15" font-weight="700" fill="#3C150C">
        <tspan x="0" dy="0">Awal berdirinya Hamur Tuan dimulai pada bulan Mei tahun 2020.</tspan>
        <tspan x="0" dy="24">Diprakarsai 4 sahabat dengan keahlian divisi kerja masing-masing.</tspan>
      </text>

      <text x="0" y="125" class="font-body" font-size="14" fill="#695E59">
        <tspan x="0" dy="0">Hamur Tuan hadir dengan visi menawarkan konsep baru coffeeshop yang dapat</tspan>
        <tspan x="0" dy="22">dinikmati semua kalangan. Suasana homie, harga ramah kantong, serta</tspan>
        <tspan x="0" dy="22">kualitas produk konsisten menjadi daya tarik utama bagi pelajar &amp; mahasiswa.</tspan>
      </text>

      <!-- 2 Philosophy Cards -->
      <g transform="translate(0, 205)">
        <rect width="295" height="155" rx="14" fill="#FBF8F3" stroke="#3C150C" stroke-width="1" stroke-opacity="0.1"/>
        <rect width="6" height="155" rx="3" fill="#3C150C"/>
        <text x="20" y="32" class="font-brand" font-size="16" fill="#3C150C">Makna "HAMUR"</text>
        <text x="20" y="60" class="font-body" font-size="12" fill="#695E59">
          <tspan x="20" dy="0">Bahasa walikan khas Malangan</tspan>
          <tspan x="20" dy="18">(Osob Kiwalan), di mana kata RUMAH</tspan>
          <tspan x="20" dy="18">dibalik menjadi HAMUR. Ruang</tspan>
          <tspan x="20" dy="18">nyaman bak di rumah sendiri.</tspan>
        </text>

        <g transform="translate(315, 0)">
          <rect width="295" height="155" rx="14" fill="#FBF8F3" stroke="#3C150C" stroke-width="1" stroke-opacity="0.1"/>
          <rect width="6" height="155" rx="3" fill="#996A3D"/>
          <text x="20" y="32" class="font-brand" font-size="16" fill="#3C150C">Makna "TUAN"</text>
          <text x="20" y="60" class="font-body" font-size="12" fill="#695E59">
            <tspan x="20" dy="0">Bentuk penghormatan &amp; etika</tspan>
            <tspan x="20" dy="18">santun kami menyambut tamu</tspan>
            <tspan x="20" dy="18">yang datang selayaknya tuan &amp;</tspan>
            <tspan x="20" dy="18">nyonya yang sangat dihargai.</tspan>
          </text>
        </g>
      </g>
    </g>
  </g>

  <!-- Visi & Misi Cards (2 Columns) -->
  <g transform="translate(100, 580)">
    <!-- Visi Card -->
    <g transform="translate(0, 0)">
      <rect width="600" height="150" rx="18" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1"/>
      <rect x="24" y="24" width="70" height="26" rx="13" fill="#3C150C"/>
      <text x="59" y="41" class="font-brand" font-size="10" fill="#F2C791" text-anchor="middle">VISI</text>
      <text x="105" y="44" class="font-brand" font-size="17" fill="#3C150C">Visi Hamur Tuan</text>
      <text x="24" y="80" class="font-body" font-size="14" fill="#695E59">
        <tspan x="24" dy="0">"Menawarkan konsep baru coffeeshop dengan tujuan dapat dinikmati</tspan>
        <tspan x="24" dy="22">secara nyaman oleh semua kalangan masyarakat, pelajar, hingga mahasiswa."</tspan>
      </text>
    </g>

    <!-- Misi Card -->
    <g transform="translate(640, 0)">
      <rect width="600" height="150" rx="18" fill="#FBF8F3" stroke="#3C150C" stroke-opacity="0.1"/>
      <rect x="24" y="24" width="70" height="26" rx="13" fill="#3C150C"/>
      <text x="59" y="41" class="font-brand" font-size="10" fill="#F2C791" text-anchor="middle">MISI</text>
      <text x="105" y="44" class="font-brand" font-size="17" fill="#3C150C">Misi Pelayanan</text>
      
      <g transform="translate(24, 75)">
        <text x="0" y="0" class="font-body" font-size="12" fill="#3C150C">✔ Cocok untuk semua usia &amp; kalangan</text>
        <text x="290" y="0" class="font-body" font-size="12" fill="#3C150C">✔ Senantiasa nyaman bak rumah sendiri</text>
        <text x="0" y="24" class="font-body" font-size="12" fill="#3C150C">✔ Harga terjangkau mutu terbaik</text>
        <text x="290" y="24" class="font-body" font-size="12" fill="#3C150C">✔ Menjaga kualitas produk standar baik</text>
      </g>
    </g>
  </g>

  <!-- FLOWCHART REQUIREMENT: PILIH HALAMAN LAIN (Loop Back Banner) -->
  <g transform="translate(100, 765)">
    <rect width="1240" height="120" rx="20" fill="#3C150C" class="shadow-card"/>
    <text x="40" y="52" class="font-brand" font-size="22" fill="#F2C791">PILIH HALAMAN LAIN (SESUAI FLOWCHART)</text>
    <text x="40" y="80" class="font-body" font-size="14" fill="#F2F7FD">Lanjutkan alur Anda: buka katalog menu harga atau cek rute lokasi cafe:</text>

    <g transform="translate(850, 40)">
      <!-- Button to Menu -->
      <rect width="170" height="44" rx="22" fill="#F2C791"/>
      <text x="85" y="27" class="font-body" font-size="13" font-weight="800" fill="#3C150C" text-anchor="middle">Buka Menu &amp; Harga</text>

      <!-- Button to Lokasi -->
      <g transform="translate(185, 0)">
        <rect width="170" height="44" rx="22" fill="none" stroke="#F2C791" stroke-width="1.5"/>
        <text x="85" y="27" class="font-body" font-size="13" font-weight="700" fill="#F2F7FD" text-anchor="middle">Cek Lokasi &amp; Peta</text>
      </g>
    </g>
  </g>
</svg>
"@

$tentangSvg | Out-File -FilePath "$figmaDir\06-Tentang-Kami-Filosofi-1440.svg" -Encoding utf8
Write-Output "Created: 06-Tentang-Kami-Filosofi-1440.svg"

# -------------------------------------------------------------
# 6. SECTION: CTA BANNER & FOOTER (1440 x 720)
# -------------------------------------------------------------
$ctaSvg = (Get-SvgHeader 1440 720 "07-CTA-dan-Footer") + @"
  <!-- CTA Banner -->
  <g transform="translate(0, 0)">
    <rect width="1440" height="380" fill="url(#ctaGradient)"/>
    <g transform="translate(720, 60)" text-anchor="middle">
      <rect x="-75" y="0" width="150" height="28" rx="14" fill="#F2C791" fill-opacity="0.2"/>
      <text x="0" y="19" class="font-body" font-size="11" font-weight="800" fill="#F2C791" letter-spacing="1">MARI MAMPIR HARI INI</text>
      
      <text x="0" y="65" class="font-brand" font-size="34" fill="#FFFFFF" letter-spacing="1">SEGERA NIKMATI SECANGKIR KEHANGATAN</text>
      <text x="0" y="105" class="font-brand" font-size="34" fill="#F2C791" letter-spacing="1">DI HAMUR TUAN</text>

      <text x="0" y="145" class="font-body" font-size="15" fill="#F2F7FD" fill-opacity="0.85">Pintu rumah kami selalu terbuka. Pesan langsung untuk takeaway atau reservasi tempat sekarang:</text>

      <!-- Action Buttons -->
      <g transform="translate(0, 185)">
        <!-- WhatsApp -->
        <g transform="translate(-230, 0)">
          <rect width="215" height="52" rx="26" fill="#25D366" class="shadow-hero"/>
          <text x="107" y="32" class="font-body" font-size="14" font-weight="800" fill="#FFFFFF">💬 Chat WhatsApp Kasir</text>
        </g>
        <!-- Maps -->
        <g transform="translate(15, 0)">
          <rect width="215" height="52" rx="26" fill="#F2C791" class="shadow-badge"/>
          <text x="107" y="32" class="font-body" font-size="14" font-weight="800" fill="#3C150C">📍 Petunjuk Rute Lokasi</text>
        </g>
      </g>
    </g>
  </g>

  <!-- Site Footer -->
  <g transform="translate(0, 380)">
    <rect width="1440" height="340" fill="#120402"/>
    <line x1="0" y1="0" x2="1440" y2="0" stroke="#F2C791" stroke-opacity="0.15" stroke-width="1"/>

    <g transform="translate(100, 50)">
      <!-- Col 1: Brand -->
      <g transform="translate(0, 0)">
        <text x="0" y="24" class="font-brand" font-size="22" fill="#F2C791" letter-spacing="2">HAMUR TUAN</text>
        <text x="0" y="55" class="font-body" font-size="13" fill="#F2F7FD" fill-opacity="0.7">
          <tspan x="0" dy="0">Coffeeshop berkonsep rumahan di Kota Malang.</tspan>
          <tspan x="0" dy="20">Menghadirkan kenyamanan, kehangatan,</tspan>
          <tspan x="0" dy="20">&amp; seduhan kopi nikmat harga ramah kantong.</tspan>
        </text>
      </g>

      <!-- Col 2: Navigasi -->
      <g transform="translate(360, 0)">
        <text x="0" y="20" class="font-brand" font-size="14" fill="#FFFFFF" letter-spacing="1">NAVIGASI ALUR</text>
        <text x="0" y="50" class="font-body" font-size="13" fill="#F2F7FD" fill-opacity="0.7">
          <tspan x="0" dy="0">Home Page</tspan>
          <tspan x="0" dy="22">Pilih Informasi</tspan>
          <tspan x="0" dy="22">Daftar Menu &amp; Harga</tspan>
          <tspan x="0" dy="22">Lokasi &amp; Jam Buka</tspan>
          <tspan x="0" dy="22">Tentang Hamur Tuan</tspan>
        </text>
      </g>

      <!-- Col 3: Menu Andalan -->
      <g transform="translate(620, 0)">
        <text x="0" y="20" class="font-brand" font-size="14" fill="#FFFFFF" letter-spacing="1">MENU ANDALAN</text>
        <text x="0" y="50" class="font-body" font-size="13" fill="#F2F7FD" fill-opacity="0.7">
          <tspan x="0" dy="0">Kokuto Latte Aren</tspan>
          <tspan x="0" dy="22">Americano Double Shot</tspan>
          <tspan x="0" dy="22">Shakerato Fruity</tspan>
          <tspan x="0" dy="22">Mie Hamur Tuan</tspan>
          <tspan x="0" dy="22">Mix Platter Hamur</tspan>
        </text>
      </g>

      <!-- Col 4: Kontak -->
      <g transform="translate(880, 0)">
        <text x="0" y="20" class="font-brand" font-size="14" fill="#FFFFFF" letter-spacing="1">KONTAK &amp; ALAMAT</text>
        <text x="0" y="50" class="font-body" font-size="13" fill="#F2F7FD" fill-opacity="0.7">
          <tspan x="0" dy="0">📍 Jl. Letjen S. Parman 56 Blimbing, Malang</tspan>
          <tspan x="0" dy="22">📞 +62 889-8953-8573</tspan>
          <tspan x="0" dy="22">✉️ ekawidiprasetia@gmail.com</tspan>
          <tspan x="0" dy="22">⏰ Buka Setiap Hari (10:00 / 13:00)</tspan>
        </text>
      </g>

      <!-- Bottom Bar -->
      <g transform="translate(0, 220)">
        <line x1="0" y1="0" x2="1240" y2="0" stroke="#FFFFFF" stroke-opacity="0.08" stroke-width="1"/>
        <text x="0" y="30" class="font-body" font-size="12" fill="#F2F7FD" fill-opacity="0.6">© 2026 Hamur Tuan Coffeeshop. All rights reserved.</text>
        <text x="1240" y="30" class="font-body" font-size="12" fill="#F2C791" text-anchor="end">Owner: Bapak Ilyas Shaso Pratama | Visual Identity: Ekawidi Prasetia</text>
      </g>
    </g>
  </g>
</svg>
"@

$ctaSvg | Out-File -FilePath "$figmaDir\07-CTA-dan-Footer-1440.svg" -Encoding utf8
Write-Output "Created: 07-CTA-dan-Footer-1440.svg"

# -------------------------------------------------------------
# 7. ASSEMBLE FULL LANDING PAGE (1440 x 5400)
# -------------------------------------------------------------
Write-Output "Assembling Full Landing Page (1440 x 5400)..."

$fullSvg = (Get-SvgHeader 1440 5400 "01-Full-Landing-Page-1440") + @"
  <!-- ================= SECTION 1: HERO & NAVBAR ================= -->
  <g id="Section-01-Hero" transform="translate(0, 0)">
    $($heroSvg.Substring($heroSvg.IndexOf('<rect width="1440" height="860"'), $heroSvg.LastIndexOf('</svg>') - $heroSvg.IndexOf('<rect width="1440" height="860"')))
  </g>

  <!-- ================= SECTION 2: PILIH INFORMASI HUB ================= -->
  <g id="Section-02-Pilih-Informasi" transform="translate(0, 860)">
    $($pilihSvg.Substring($pilihSvg.IndexOf('<rect width="1440" height="680"'), $pilihSvg.LastIndexOf('</svg>') - $pilihSvg.IndexOf('<rect width="1440" height="680"')))
  </g>

  <!-- ================= SECTION 3: MENU KATALOG GRID ================= -->
  <g id="Section-03-Menu-Katalog" transform="translate(0, 1540)">
    $($menuSvg.Substring($menuSvg.IndexOf('<rect width="1440" height="1220"'), $menuSvg.LastIndexOf('</svg>') - $menuSvg.IndexOf('<rect width="1440" height="1220"')))
  </g>

  <!-- ================= SECTION 4: LOKASI & JAM OPERASIONAL ================= -->
  <g id="Section-04-Lokasi-Jam-Buka" transform="translate(0, 2760)">
    $($lokasiSvg.Substring($lokasiSvg.IndexOf('<rect width="1440" height="860"'), $lokasiSvg.LastIndexOf('</svg>') - $lokasiSvg.IndexOf('<rect width="1440" height="860"')))
  </g>

  <!-- ================= SECTION 5: TENTANG KAMI & LOOP BACK ================= -->
  <g id="Section-05-Tentang-Kami" transform="translate(0, 3620)">
    $($tentangSvg.Substring($tentangSvg.IndexOf('<rect width="1440" height="950"'), $tentangSvg.LastIndexOf('</svg>') - $tentangSvg.IndexOf('<rect width="1440" height="950"')))
  </g>

  <!-- ================= SECTION 6: CTA & FOOTER ================= -->
  <g id="Section-06-CTA-and-Footer" transform="translate(0, 4570)">
    $($ctaSvg.Substring($ctaSvg.IndexOf('<!-- CTA Banner -->'), $ctaSvg.LastIndexOf('</svg>') - $ctaSvg.IndexOf('<!-- CTA Banner -->')))
  </g>
</svg>
"@

$fullSvg | Out-File -FilePath "$figmaDir\01-Full-Landing-Page-1440.svg" -Encoding utf8
Write-Output "Created: 01-Full-Landing-Page-1440.svg"

Get-ChildItem $figmaDir | Select-Object Name, Length
