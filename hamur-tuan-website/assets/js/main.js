/**
 * Hamur Tuan Coffeeshop - Interactive Website Engine
 */

document.addEventListener('DOMContentLoaded', () => {
  // ==========================================
  // 1. STATE MANAGEMENT
  // ==========================================
  let currentCategory = 'all';
  let searchQuery = '';
  let activeModalItem = null;
  let activeModalTemp = 'ice';
  let activeModalQty = 1;
  let cart = [];

  // DOM Elements
  const menuGrid = document.getElementById('menuItemsGrid');
  const searchInput = document.getElementById('menuSearchInput');
  const categoryTabs = document.querySelectorAll('.tab-pill-btn');
  const menuCountEl = document.getElementById('menuResultsCount');
  
  // Modal Elements
  const modalBackdrop = document.getElementById('productModalBackdrop');
  const modalCloseBtn = document.getElementById('modalCloseBtn');
  const modalPhoto = document.getElementById('modalPhoto');
  const modalCategoryTag = document.getElementById('modalCategoryTag');
  const modalBadge = document.getElementById('modalBadge');
  const modalTitle = document.getElementById('modalTitle');
  const modalPrice = document.getElementById('modalPrice');
  const modalDesc = document.getElementById('modalDesc');
  const modalTastingTags = document.getElementById('modalTastingTags');
  const modalIngredients = document.getElementById('modalIngredients');
  const modalTempGroup = document.getElementById('modalTempGroup');
  const modalBtnHot = document.getElementById('modalBtnHot');
  const modalBtnIce = document.getElementById('modalBtnIce');
  const modalBtnWa = document.getElementById('modalBtnWa');
  const modalBtnAddCart = document.getElementById('modalBtnAddCart');

  // Cart Elements
  const cartToggleBtn = document.getElementById('cartToggleBtn');
  const cartDrawerBackdrop = document.getElementById('cartDrawerBackdrop');
  const cartDrawerClose = document.getElementById('cartDrawerClose');
  const cartItemsList = document.getElementById('cartItemsList');
  const cartSubtotalEl = document.getElementById('cartSubtotal');
  const cartCountBadges = document.querySelectorAll('.cart-counter');
  const cartCheckoutWaBtn = document.getElementById('cartCheckoutWaBtn');

  // Nav & Mobile Menu
  const siteHeader = document.querySelector('.site-header');
  const mobileMenuBtn = document.getElementById('mobileMenuBtn');
  const navMenu = document.querySelector('.nav-menu');

  // WhatsApp Contact (From Hamur Tuan GSM Contact)
  const WA_PHONE_NUMBER = "6288989538573";

  // ==========================================
  // 2. HEADER SCROLL & MOBILE MENU
  // ==========================================
  window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
      siteHeader.classList.add('scrolled');
    } else {
      siteHeader.classList.remove('scrolled');
    }
  });

  if (mobileMenuBtn && navMenu) {
    mobileMenuBtn.addEventListener('click', () => {
      const isVisible = navMenu.style.display === 'flex';
      navMenu.style.display = isVisible ? 'none' : 'flex';
      if (!isVisible) {
        navMenu.style.flexDirection = 'column';
        navMenu.style.position = 'absolute';
        navMenu.style.top = '80px';
        navMenu.style.left = '0';
        navMenu.style.width = '100%';
        navMenu.style.background = '#280e08';
        navMenu.style.padding = '24px';
        navMenu.style.gap = '18px';
      }
    });

    document.querySelectorAll('.nav-link').forEach(link => {
      link.addEventListener('click', () => {
        if (window.innerWidth <= 768) {
          navMenu.style.display = 'none';
        }
      });
    });
  }

  // ==========================================
  // 3. RENDER MENU ITEMS
  // ==========================================
  function renderMenu() {
    if (!menuGrid) return;

    let items = MENU_DATA;

    // Filter Category
    if (currentCategory !== 'all') {
      items = items.filter(item => item.category === currentCategory);
    }

    // Filter Search
    if (searchQuery.trim() !== '') {
      const query = searchQuery.toLowerCase();
      items = items.filter(item => 
        item.name.toLowerCase().includes(query) ||
        item.shortDesc.toLowerCase().includes(query) ||
        item.category.toLowerCase().includes(query)
      );
    }

    if (menuCountEl) {
      menuCountEl.textContent = `Menampilkan ${items.length} menu pilihan`;
    }

    if (items.length === 0) {
      menuGrid.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px; background: #fff; border-radius: 16px; border: 1px dashed var(--c-border);">
          <div style="font-size: 3rem; margin-bottom: 12px;">☕</div>
          <h3 style="color: var(--c-primary-brown); margin-bottom: 8px;">Menu tidak ditemukan</h3>
          <p style="color: var(--c-text-muted);">Coba gunakan kata kunci pencarian lain atau pilih kategori Semua.</p>
        </div>
      `;
      return;
    }

    menuGrid.innerHTML = items.map(item => {
      const categoryLabel = {
        coffee: 'Coffee Bar',
        mix: 'Signature Mix',
        tea: 'Artisan Tea',
        milk: 'Specialty Milk',
        snack: 'Snack & Bites',
        food: 'Main Course'
      }[item.category] || item.category;

      return `
        <div class="menu-card" data-id="${item.id}">
          <div class="menu-card-img-wrap">
            <img src="${item.image}" alt="${item.name}" class="menu-card-photo" loading="lazy" onerror="this.src='assets/images/menu/tubruk-susu.jpg'"/>
            ${item.badge ? `<span class="menu-card-badge">${item.badge}</span>` : ''}
            ${item.isRecommended ? `<span class="menu-card-fav" title="Menu Rekomendasi">★</span>` : ''}
          </div>
          <div class="menu-card-body">
            <span class="menu-card-category">${categoryLabel}</span>
            <h3 class="menu-card-title">${item.name}</h3>
            <p class="menu-card-desc">${item.shortDesc}</p>
            <div class="menu-card-footer">
              <span class="menu-card-price">${item.priceDisplay}</span>
              <div class="menu-card-actions">
                <button class="btn-menu-detail" onclick="openProductDetail('${item.id}')">Detail</button>
                <button class="btn-menu-add" onclick="quickAddToCart('${item.id}')" title="Tambah ke keranjang">+ Pesan</button>
              </div>
            </div>
          </div>
        </div>
      `;
    }).join('');
  }

  // Category Filter clicks
  categoryTabs.forEach(tab => {
    tab.addEventListener('click', () => {
      categoryTabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      currentCategory = tab.dataset.category || 'all';
      renderMenu();
    });
  });

  // Search Input live typing
  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      searchQuery = e.target.value;
      renderMenu();
    });
  }

  // ==========================================
  // 4. PRODUCT DETAIL MODAL (Lihat Detail Produk)
  // ==========================================
  window.openProductDetail = function(id) {
    const item = getMenuById(id);
    if (!item) return;

    activeModalItem = item;
    activeModalQty = 1;
    activeModalTemp = item.defaultTemp || 'ice';

    modalPhoto.src = item.image;
    modalPhoto.alt = item.name;
    modalTitle.textContent = item.name;
    modalDesc.textContent = item.fullDesc;
    modalCategoryTag.textContent = item.category.toUpperCase();
    modalBadge.textContent = item.badge || 'Hamur Tuan Specialty';
    modalIngredients.textContent = item.ingredients || 'Bahan pilihan berkualitas standar Hamur Tuan.';

    // Tasting Notes
    if (item.tastingNotes && item.tastingNotes.length > 0) {
      modalTastingTags.innerHTML = item.tastingNotes.map(t => `<span class="tasting-pill">${t}</span>`).join('');
    } else {
      modalTastingTags.innerHTML = `<span class="tasting-pill">Cita Rasa Otentik</span>`;
    }

    // Hot/Ice Selector
    if (item.prices.ice && item.prices.hot) {
      modalTempGroup.style.display = 'block';
      updateModalTempButtons();
    } else {
      modalTempGroup.style.display = 'none';
      if (item.prices.ice) activeModalTemp = 'ice';
      else if (item.prices.hot) activeModalTemp = 'hot';
      else activeModalTemp = 'standard';
    }

    updateModalPriceDisplay();

    // Show modal
    modalBackdrop.classList.add('active');
    document.body.style.overflow = 'hidden';
  };

  function updateModalTempButtons() {
    if (activeModalTemp === 'ice') {
      modalBtnIce.classList.add('active');
      modalBtnHot.classList.remove('active');
    } else {
      modalBtnHot.classList.add('active');
      modalBtnIce.classList.remove('active');
    }
  }

  function updateModalPriceDisplay() {
    if (!activeModalItem) return;
    const price = activeModalItem.prices[activeModalTemp] || activeModalItem.prices.standard || 15000;
    modalPrice.textContent = `Rp ${price.toLocaleString('id-ID')}`;
  }

  if (modalBtnIce) {
    modalBtnIce.addEventListener('click', () => {
      activeModalTemp = 'ice';
      updateModalTempButtons();
      updateModalPriceDisplay();
    });
  }

  if (modalBtnHot) {
    modalBtnHot.addEventListener('click', () => {
      activeModalTemp = 'hot';
      updateModalTempButtons();
      updateModalPriceDisplay();
    });
  }

  function closeModal() {
    modalBackdrop.classList.remove('active');
    document.body.style.overflow = '';
  }

  if (modalCloseBtn) modalCloseBtn.addEventListener('click', closeModal);
  if (modalBackdrop) {
    modalBackdrop.addEventListener('click', (e) => {
      if (e.target === modalBackdrop) closeModal();
    });
  }

  // Direct WhatsApp Button inside Modal
  if (modalBtnWa) {
    modalBtnWa.addEventListener('click', () => {
      if (!activeModalItem) return;
      const price = activeModalItem.prices[activeModalTemp] || activeModalItem.prices.standard || 15000;
      const tempLabel = activeModalTemp === 'ice' ? 'Dingin (Ice)' : (activeModalTemp === 'hot' ? 'Panas (Hot)' : '');
      const message = `Halo Hamur Tuan!%0ASaya ingin memesan menu ini:%0A- 1x *${activeModalItem.name}* ${tempLabel ? `(${tempLabel})` : ''} - Rp ${price.toLocaleString('id-ID')}%0A%0AMohon konfirmasi ketersediaan meja / takeaway ya. Terima kasih!`;
      window.open(`https://wa.me/${WA_PHONE_NUMBER}?text=${message}`, '_blank');
    });
  }

  // Add to Cart from Modal
  if (modalBtnAddCart) {
    modalBtnAddCart.addEventListener('click', () => {
      if (!activeModalItem) return;
      addToCart(activeModalItem, activeModalTemp, 1);
      closeModal();
      openCartDrawer();
    });
  }

  // ==========================================
  // 5. CART & ORDER SYSTEM
  // ==========================================
  window.quickAddToCart = function(id) {
    const item = getMenuById(id);
    if (!item) return;
    const temp = item.defaultTemp || 'standard';
    addToCart(item, temp, 1);
    openCartDrawer();
  };

  function addToCart(item, temp, qty = 1) {
    const price = item.prices[temp] || item.prices.standard || 15000;
    const existingIndex = cart.findIndex(c => c.id === item.id && c.temp === temp);

    if (existingIndex > -1) {
      cart[existingIndex].qty += qty;
    } else {
      cart.push({
        id: item.id,
        name: item.name,
        temp: temp,
        price: price,
        qty: qty
      });
    }
    updateCartUI();
  }

  function updateCartUI() {
    const totalCount = cart.reduce((sum, item) => sum + item.qty, 0);
    cartCountBadges.forEach(badge => {
      badge.textContent = totalCount;
    });

    if (!cartItemsList) return;

    if (cart.length === 0) {
      cartItemsList.innerHTML = `
        <div class="cart-empty-message">
          <div class="cart-empty-icon">🛒</div>
          <h4>Keranjang Anda Kosong</h4>
          <p>Pilih menu favorit Anda untuk memulai pesanan.</p>
        </div>
      `;
      cartSubtotalEl.textContent = 'Rp 0';
      return;
    }

    let subtotal = 0;
    cartItemsList.innerHTML = cart.map((item, index) => {
      const itemSub = item.price * item.qty;
      subtotal += itemSub;
      const tempLabel = item.temp === 'ice' ? 'Ice' : (item.temp === 'hot' ? 'Hot' : '');

      return `
        <div class="cart-item-row">
          <div class="cart-item-info">
            <div class="cart-item-name">${item.name}</div>
            ${tempLabel ? `<div class="cart-item-variant">Varian: ${tempLabel}</div>` : ''}
            <div class="cart-item-price">Rp ${item.price.toLocaleString('id-ID')}</div>
          </div>
          <div class="cart-qty-controls">
            <button class="cart-qty-btn" onclick="changeCartQty(${index}, -1)">-</button>
            <span class="cart-qty-num">${item.qty}</span>
            <button class="cart-qty-btn" onclick="changeCartQty(${index}, 1)">+</button>
          </div>
        </div>
      `;
    }).join('');

    cartSubtotalEl.textContent = `Rp ${subtotal.toLocaleString('id-ID')}`;
  }

  window.changeCartQty = function(index, delta) {
    if (!cart[index]) return;
    cart[index].qty += delta;
    if (cart[index].qty <= 0) {
      cart.splice(index, 1);
    }
    updateCartUI();
  };

  function openCartDrawer() {
    cartDrawerBackdrop.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeCartDrawer() {
    cartDrawerBackdrop.classList.remove('active');
    document.body.style.overflow = '';
  }

  if (cartToggleBtn) cartToggleBtn.addEventListener('click', openCartDrawer);
  if (cartDrawerClose) cartDrawerClose.addEventListener('click', closeCartDrawer);
  if (cartDrawerBackdrop) {
    cartDrawerBackdrop.addEventListener('click', (e) => {
      if (e.target === cartDrawerBackdrop) closeCartDrawer();
    });
  }

  // Checkout via WhatsApp
  if (cartCheckoutWaBtn) {
    cartCheckoutWaBtn.addEventListener('click', () => {
      if (cart.length === 0) {
        alert('Keranjang Anda masih kosong. Silakan pilih menu terlebih dahulu!');
        return;
      }

      let subtotal = 0;
      let orderItemsText = cart.map((item, i) => {
        const itemSub = item.price * item.qty;
        subtotal += itemSub;
        const tempText = item.temp === 'ice' ? ' [Ice]' : (item.temp === 'hot' ? ' [Hot]' : '');
        return `${i + 1}. *${item.name}*${tempText} x${item.qty} = Rp ${itemSub.toLocaleString('id-ID')}`;
      }).join('%0A');

      const text = `Halo Hamur Tuan!%0ASaya ingin memesan via website:%0A%0A${orderItemsText}%0A%0A*Total Pesanan: Rp ${subtotal.toLocaleString('id-ID')}*%0A%0ATipe: Dine In / Takeaway%0ANama Pemesan: %0ANotes / No Meja: %0A%0AMohon diproses ya. Terima kasih!`;
      window.open(`https://wa.me/${WA_PHONE_NUMBER}?text=${text}`, '_blank');
    });
  }

  // ==========================================
  // 6. REAL-TIME CAFE OPERATING HOURS (MALANG TIME)
  // ==========================================
  function checkCafeStatus() {
    const statusBadge = document.getElementById('cafeLiveStatus');
    const statusNote = document.getElementById('cafeStatusNote');
    if (!statusBadge) return;

    // Current date & time in WIB (UTC+7)
    const now = new Date();
    const utc = now.getTime() + (now.getTimezoneOffset() * 60000);
    const wibDate = new Date(utc + (3600000 * 7));
    
    const day = wibDate.getDay(); // 0: Minggu, 1: Senin, ..., 5: Jumat, 6: Sabtu
    const hour = wibDate.getHours();
    const minute = wibDate.getMinutes();
    const currentTimeVal = hour * 60 + minute;

    let isOpen = false;
    let openTimeStr = "10:00";
    let closeTimeStr = "23:00";

    if (day >= 1 && day <= 4) {
      // Senin - Kamis: 10:00 - 23:00 (600 - 1380 mins)
      isOpen = (currentTimeVal >= 10 * 60 && currentTimeVal < 23 * 60);
      closeTimeStr = "23:00 WIB";
    } else if (day === 5) {
      // Jumat: 13:00 - 00:00 (780 - 1440 mins)
      isOpen = (currentTimeVal >= 13 * 60);
      openTimeStr = "13:00";
      closeTimeStr = "00:00 WIB";
    } else {
      // Sabtu - Minggu: 10:00 - 00:00 (600 - 1440 mins)
      isOpen = (currentTimeVal >= 10 * 60);
      closeTimeStr = "00:00 WIB";
    }

    if (isOpen) {
      statusBadge.className = 'live-badge open';
      statusBadge.innerHTML = '<span class="circle"></span> Sedang Buka';
      if (statusNote) statusNote.textContent = `Tutup pukul ${closeTimeStr}`;
    } else {
      statusBadge.className = 'live-badge closed';
      statusBadge.innerHTML = '<span class="circle"></span> Sedang Tutup';
      if (statusNote) statusNote.textContent = `Buka kembali pukul ${openTimeStr} WIB`;
    }
  }

  // Initial calls
  renderMenu();
  checkCafeStatus();
  setInterval(checkCafeStatus, 60000); // Check every minute
});
