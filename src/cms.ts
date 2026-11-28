// Full-Site CMS Schema, Admin CMS Editor & Hotel PMS Marketing Component
// 100% Cloudflare Workers & Node.js compatible (zero Node-only imports)

export interface CmsField {
  key: string
  label: string
  type: 'text' | 'textarea' | 'url' | 'image' | 'toggle'
  defaultVal: string
  help?: string
}

export interface CmsTab {
  id: string
  label: string
  icon: string
  previewPath: string
  description: string
  fields: CmsField[]
}

export function escHtml(str: string | undefined | null): string {
  return String(str ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
}

export function formatMultiline(str: string | undefined | null, fallback: string): string {
  const raw = (str && str.trim()) ? str.trim() : fallback
  return escHtml(raw).replace(/\r?\n/g, '<br/>')
}

export const CMS_TABS: CmsTab[] = [
  {
    id: 'homepage',
    label: 'Homepage',
    icon: 'fa-home',
    previewPath: '/',
    description: 'Manage hero banner, service cards, OTA banner, property management promise, training section, and bottom call-to-action.',
    fields: [
      { key: 'hero_title', label: 'Hero Headline (use Enter for line break)', type: 'textarea', defaultVal: 'Hospitality & Property\nManagement Solutions' },
      { key: 'hero_subtitle', label: 'Hero Subheadline', type: 'textarea', defaultVal: 'Purecrest delivers world-class hotel management, short-let operations, property sales, leasing, and real estate advisory — helping owners maximise returns and guests enjoy exceptional stays.' },
      { key: 'hero_bg_image', label: 'Hero Background Image', type: 'image', defaultVal: '/assets/images/hero_purecrest_residence_1795731930518.jpg', help: 'Recommended landscape photo (1600×900+).' },
      { key: 'hero_cta_1_text', label: 'Primary CTA Button Text', type: 'text', defaultVal: 'Contact Us' },
      { key: 'hero_cta_1_url', label: 'Primary CTA Button Link', type: 'text', defaultVal: '/contact' },
      { key: 'hero_cta_2_text', label: 'Secondary CTA Button Text', type: 'text', defaultVal: 'Our Services' },
      { key: 'hero_cta_2_url', label: 'Secondary CTA Button Link', type: 'text', defaultVal: '/services' },
      { key: 'whatwedo_title', label: 'What We Do — Heading', type: 'textarea', defaultVal: 'Integrated Solutions.\nEndless Possibilities.' },
      { key: 'whatwedo_body', label: 'What We Do — Description', type: 'textarea', defaultVal: 'Purecrest is a dynamic company providing end-to-end solutions in hospitality and real estate. From premium hospitality management to property development and investment advisory, we create spaces and experiences that stand the test of time.' },
      { key: 'service_card_1_title', label: 'Card 1 Title (Hospitality)', type: 'text', defaultVal: 'Purecrest Hospitality' },
      { key: 'service_card_1_desc', label: 'Card 1 Description', type: 'textarea', defaultVal: 'Hotel management, serviced apartments, and short-let operations delivering exceptional guest experiences and maximum owner returns.' },
      { key: 'service_card_2_title', label: 'Card 2 Title (Property)', type: 'text', defaultVal: 'Purecrest Property' },
      { key: 'service_card_2_desc', label: 'Card 2 Description', type: 'textarea', defaultVal: 'Real estate development, property sales, leasing, and investment advisory creating lasting value across Nigeria.' },
      { key: 'service_card_3_title', label: 'Card 3 Title (Technology)', type: 'text', defaultVal: 'Pure Crest Technology' },
      { key: 'service_card_3_desc', label: 'Card 3 Description', type: 'textarea', defaultVal: 'Web development, booking systems, and hospitality software powering modern hospitality and property businesses.' },
      { key: 'service_img_solutions', label: 'Card 3 Image (Pure Crest Technology)', type: 'image', defaultVal: '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png' },
      { key: 'service_card_4_title', label: 'Card 4 Title (Virtual Support)', type: 'text', defaultVal: 'Hospitality Virtual Support' },
      { key: 'service_card_4_desc', label: 'Card 4 Description', type: 'textarea', defaultVal: 'Professional remote management for your hospitality business — 24/7 guest support, reservations, revenue management, and operations coordination.' },
      { key: 'service_img_virtual_support', label: 'Card 4 Image (Virtual Support)', type: 'image', defaultVal: '/assets/aistudio/F1834A2C-2DF3-4AEB-8A69-8229BB53CCAC_9dec0e0c.png' },
      { key: 'ota_banner_image', label: 'OTA Listing Optimization Banner Image', type: 'image', defaultVal: '/static/ota-ad-banner.png' },
      { key: 'manage_section_title', label: 'Property Management Section Heading', type: 'text', defaultVal: 'Let Us Manage Your Property' },
      { key: 'manage_section_body', label: 'Property Management Section Copy', type: 'textarea', defaultVal: 'We are an ethical brand built on transparency, integrity, and results. Whether you own a shortlet apartment, serviced residence, or a hotel — we handle everything from marketing, guest management, maintenance to revenue optimisation. Earn more while we manage for you.' },
      { key: 'training_banner_title', label: 'Training Section Heading', type: 'textarea', defaultVal: 'Elevate Your Team with\nProfessional Training' },
      { key: 'training_banner_body', label: 'Training Section Description', type: 'textarea', defaultVal: 'Purecrest delivers hands-on hospitality training programmes for hotels, serviced apartments, and hospitality businesses — building exceptional service cultures from the front desk to leadership.' },
      { key: 'home_cta_title', label: 'Bottom CTA Headline', type: 'textarea', defaultVal: 'Whether you need property management, OTA optimization, virtual support or real estate services — we are here to help.' },
      { key: 'home_cta_btn_text', label: 'Bottom CTA Button Text', type: 'text', defaultVal: 'Get in Touch' },
    ],
  },
  {
    id: 'pms',
    label: 'Hotel PMS (pchpms.com)',
    icon: 'fa-hotel',
    previewPath: '/#hotel-pms',
    description: 'Promote "Get Your Hotel Property Management System" linking directly to pchpms.com across Homepage, Hospitality, and Technology pages.',
    fields: [
      { key: 'pms_banner_enabled', label: 'Show Hotel PMS Marketing Section on Homepage & Hospitality', type: 'toggle', defaultVal: '1' },
      { key: 'pms_banner_badge', label: 'Eyebrow / Product Label', type: 'text', defaultVal: 'PURECREST HOTEL PMS' },
      { key: 'pms_banner_title', label: 'Marketing Headline', type: 'text', defaultVal: 'Get Your Hotel Property Management System' },
      { key: 'pms_banner_subtitle', label: 'Marketing Description', type: 'textarea', defaultVal: 'Run your hotel, serviced apartments, or short-let portfolio effortlessly from one cloud platform. Automate reservations, front-desk check-ins, housekeeping, billing, OTA channel sync, and real-time revenue reporting.' },
      { key: 'pms_banner_cta_text', label: 'Primary CTA Button Text', type: 'text', defaultVal: 'Launch Hotel PMS at pchpms.com' },
      { key: 'pms_banner_cta_url', label: 'Primary CTA Destination URL', type: 'url', defaultVal: 'https://pchpms.com', help: 'Links directly to your Hotel PMS product website.' },
      { key: 'pms_banner_secondary_text', label: 'Secondary Button Text', type: 'text', defaultVal: 'Request a Guided Demo' },
      { key: 'pms_banner_secondary_url', label: 'Secondary Button Link', type: 'text', defaultVal: '/contact?service=hospitality-software' },
      { key: 'pms_banner_image', label: 'PMS Showcase Image', type: 'image', defaultVal: '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png', help: 'Upload a dashboard screenshot or hotel operations visual.' },
      { key: 'pms_feature_1', label: 'Feature Bullet 1', type: 'text', defaultVal: 'Front Desk, Reservations & Instant Check-In' },
      { key: 'pms_feature_2', label: 'Feature Bullet 2', type: 'text', defaultVal: 'Real-Time OTA Channel & Booking Sync' },
      { key: 'pms_feature_3', label: 'Feature Bullet 3', type: 'text', defaultVal: 'Automated Billing, Folios & Housekeeping' },
      { key: 'pms_feature_4', label: 'Feature Bullet 4', type: 'text', defaultVal: 'Owner Revenue & Occupancy Dashboards' },
    ],
  },
  {
    id: 'hospitality',
    label: 'Hospitality',
    icon: 'fa-concierge-bell',
    previewPath: '/hospitality',
    description: 'Edit headlines and copy for the Hospitality Management page.',
    fields: [
      { key: 'hosp_hero_title', label: 'Hero Headline', type: 'textarea', defaultVal: 'Your Property.\nOur Management.\nBetter Hospitality.' },
      { key: 'hosp_hero_subtitle', label: 'Hero Description', type: 'textarea', defaultVal: 'We partner with hotel owners and property investors to professionally manage, reposition, and grow their hospitality assets — delivering world-class guest experiences and maximising owner returns.' },
      { key: 'hospitality_hero_image', label: 'Hero Background Image', type: 'image', defaultVal: '/assets/images/hero_purecrest_residence_1795731930518.jpg', help: 'Full-width background photo behind "Your Property. Our Management. Better Hospitality."' },
      { key: 'hosp_services_heading', label: 'Services Section Heading', type: 'text', defaultVal: 'Comprehensive Hospitality Management' },
      { key: 'hosp_cta_title', label: 'Bottom CTA Heading', type: 'text', defaultVal: 'Let Purecrest Manage Your Shortlet or Hotel — We Deliver Results with Integrity' },
      { key: 'hosp_cta_subtitle', label: 'Bottom CTA Description', type: 'textarea', defaultVal: 'Transparent reporting, professional management, and maximum revenue — all with zero compromise on standards.' },
    ],
  },
  {
    id: 'ota',
    label: 'OTA Listing',
    icon: 'fa-globe',
    previewPath: '/ota-listing',
    description: 'Edit copy and banner images for the OTA Listing Optimization & Channel Management page.',
    fields: [
      { key: 'ota_hero_title', label: 'Hero Headline', type: 'textarea', defaultVal: 'OTA Listing Optimization\n& Management Services' },
      { key: 'ota_hero_subtitle', label: 'Hero Description', type: 'textarea', defaultVal: "We maximize your property's visibility, bookings, and revenue across Airbnb, Booking.com, Expedia, Vrbo and all major OTAs — through expert listing optimization, dynamic pricing, and full-service channel management." },
      { key: 'ota_hero_image', label: 'Hero Background Image', type: 'image', defaultVal: '/static/service-hospitality.jpg' },
      { key: 'ota_banner_image', label: 'Full-Width Promo Banner Image', type: 'image', defaultVal: '/static/ota-ad-banner.png' },
      { key: 'ota_intro_title', label: 'Intro Section Title', type: 'text', defaultVal: 'Turn Your Property into a High-Performing Listing' },
      { key: 'ota_intro_body', label: 'Intro Section Description', type: 'textarea', defaultVal: 'Most property owners leave significant revenue on the table because their OTA listings are poorly optimized. Our team of hospitality and digital marketing specialists transforms your listings into top-ranking, high-converting assets on every major booking platform.' },
      { key: 'ota_cta_title', label: 'Bottom CTA Heading', type: 'text', defaultVal: 'Ready to Maximize Your Booking Revenue?' },
      { key: 'ota_cta_subtitle', label: 'Bottom CTA Subtext', type: 'textarea', defaultVal: 'Let us audit your current OTA listings for free and show you exactly how much revenue you are leaving behind — and how we can fix it.' },
    ],
  },
  {
    id: 'virtual-support',
    label: 'Virtual Support',
    icon: 'fa-headset',
    previewPath: '/virtual-support',
    description: 'Edit copy and hero image for the Hospitality Virtual Support page.',
    fields: [
      { key: 'vs_hero_title', label: 'Hero Headline', type: 'textarea', defaultVal: 'Hospitality Virtual Support\nProfessional Services' },
      { key: 'vs_hero_subtitle', label: 'Hero Description', type: 'textarea', defaultVal: 'Professional remote hospitality management for property owners. Our dedicated virtual support team handles your guests, bookings, and operations — so you can earn more while doing less.' },
      { key: 'vs_hero_image', label: 'Hero Background Image', type: 'image', defaultVal: '/assets/aistudio/F1834A2C-2DF3-4AEB-8A69-8229BB53CCAC_9dec0e0c.png' },
      { key: 'vs_reach_banner', label: 'Global Reach Strip Text', type: 'text', defaultVal: 'We serve property owners in Nigeria · UK · USA · Canada · Europe · Middle East · Australia · and beyond.' },
      { key: 'vs_intro_title', label: 'Intro Heading', type: 'text', defaultVal: 'For Property Owners Who Want Hands-Free Management' },
      { key: 'vs_intro_body', label: 'Intro Description', type: 'textarea', defaultVal: 'Whether you live abroad, have a busy schedule, or simply want a professional team managing your hospitality business — Purecrest Virtual Support delivers the expertise and dedication of a full management team, remotely.' },
      { key: 'vs_quote', label: 'Pull Quote', type: 'text', defaultVal: 'Your property managed like a business, not a side project.' },
    ],
  },
  {
    id: 'property-services',
    label: 'Property Services',
    icon: 'fa-building',
    previewPath: '/property-services',
    description: 'Edit text for the Real Estate & Property Services page.',
    fields: [
      { key: 'prop_hero_title', label: 'Hero Headline', type: 'textarea', defaultVal: 'Property Sales, Leasing\n& Advisory' },
      { key: 'prop_hero_subtitle', label: 'Hero Description', type: 'textarea', defaultVal: 'We connect buyers, sellers, tenants, and investors with premium residential and commercial properties across Nigeria — with expert advisory at every step.' },
      { key: 'prop_services_heading', label: 'Services Grid Heading', type: 'text', defaultVal: 'From Acquisition to Investment' },
      { key: 'prop_cta_title', label: 'Bottom CTA Heading', type: 'text', defaultVal: 'Looking for a Property?' },
      { key: 'prop_cta_subtitle', label: 'Bottom CTA Subtext', type: 'textarea', defaultVal: 'Browse our curated listings or speak to one of our property experts today.' },
    ],
  },
  {
    id: 'technology',
    label: 'Technology',
    icon: 'fa-laptop-code',
    previewPath: '/technology',
    description: 'Edit copy, hero banner, and Hotel PMS link on the Pure Crest Technology page.',
    fields: [
      { key: 'tech_hero_title', label: 'Hero Headline', type: 'textarea', defaultVal: 'Digital Solutions\nThat Power Modern\nHospitality & Business' },
      { key: 'tech_hero_subtitle', label: 'Hero Description', type: 'textarea', defaultVal: 'We build the web platforms, booking systems, and hospitality software that power Purecrest and our clients — combining deep industry knowledge with modern technology to deliver measurable digital transformation.' },
      { key: 'technology_hero_image', label: 'Hero Background Image', type: 'image', defaultVal: '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png' },
      { key: 'tech_core_heading', label: 'Core Services Heading', type: 'text', defaultVal: 'Our Core Technology Services' },
      { key: 'tech_core_subtitle', label: 'Core Services Subtext', type: 'textarea', defaultVal: 'From custom websites to intelligent booking systems, we engineer the digital backbone of modern hospitality and property businesses.' },
      { key: 'tech_pms_title', label: 'Hotel PMS Section Heading', type: 'text', defaultVal: 'Get Your Hotel Property Management System (PCHPMS)' },
      { key: 'tech_pms_body', label: 'Hotel PMS Description', type: 'textarea', defaultVal: 'Streamline hotel operations, reservations, housekeeping, guest billing, and multi-property analytics with Purecrest Hotel PMS — purpose-built for modern African hospitality operators.' },
      { key: 'tech_pms_url', label: 'Hotel PMS Link URL', type: 'url', defaultVal: 'https://pchpms.com' },
    ],
  },
  {
    id: 'services',
    label: 'Services Overview',
    icon: 'fa-layer-group',
    previewPath: '/services',
    description: 'Edit the main Services overview page copy.',
    fields: [
      { key: 'svc_hero_title', label: 'Hero Title', type: 'text', defaultVal: 'Our Services' },
      { key: 'svc_hero_subtitle', label: 'Hero Description', type: 'textarea', defaultVal: 'Three powerful business lines working together to deliver exceptional value — hospitality management, property services, and hospitality technology.' },
      { key: 'svc_hosp_body', label: 'Hospitality Pillar Summary', type: 'textarea', defaultVal: 'We deliver world-class hospitality management, serviced apartment operations, and short-let management that create memorable guest experiences and maximise property returns.' },
      { key: 'svc_prop_body', label: 'Property Pillar Summary', type: 'textarea', defaultVal: 'We deliver comprehensive real estate services — from property development and sales to leasing, management, and investment advisory — helping clients achieve measurable results.' },
      { key: 'svc_sol_body', label: 'Pure Crest Technology Pillar Summary', type: 'textarea', defaultVal: 'We engineer web platforms, booking engines, and hospitality software — including Purecrest Hotel PMS — that power modern hotels, serviced apartments, and property businesses.' },
    ],
  },
  {
    id: 'about',
    label: 'About Us',
    icon: 'fa-info-circle',
    previewPath: '/about',
    description: 'Edit brand story, leadership photo, mission, and vision on the About Us page.',
    fields: [
      { key: 'about_hero_title', label: 'Hero Headline', type: 'textarea', defaultVal: 'A Commitment to Excellence\nin Hospitality & Property' },
      { key: 'about_hero_subtitle', label: 'Hero Subheadline', type: 'textarea', defaultVal: 'Purecrest is a diversified company delivering world-class hospitality management, real estate development, and innovative business solutions across Nigeria.' },
      { key: 'about_section_image', label: 'About Story Image', type: 'image', defaultVal: '/static/service-property.jpg' },
      { key: 'about_story_title', label: 'Story Heading', type: 'text', defaultVal: "Building Nigeria's Most Trusted Hospitality & Property Company" },
      { key: 'about_story_p1', label: 'Story Paragraph 1', type: 'textarea', defaultVal: 'Founded with a vision to redefine hospitality and real estate in Nigeria, Purecrest brings together industry expertise, innovation, and integrity to deliver exceptional experiences and lasting value.' },
      { key: 'about_story_p2', label: 'Story Paragraph 2', type: 'textarea', defaultVal: 'From managing premium shortlets and serviced apartments across Nigeria to advising investors on real estate development, our team is dedicated to building trust, creating iconic spaces, and elevating every client experience.' },
      { key: 'about_mission', label: 'Our Mission', type: 'textarea', defaultVal: 'To deliver exceptional hospitality experiences and property solutions that inspire trust, create lasting value, and elevate communities across Nigeria and beyond.' },
      { key: 'about_vision', label: 'Our Vision', type: 'textarea', defaultVal: 'To be the leading integrated hospitality and property company in West Africa — known for innovation, integrity, and the enduring quality of our spaces and service.' },
    ],
  },
  {
    id: 'invest',
    label: 'Invest With Us',
    icon: 'fa-chart-line',
    previewPath: '/invest',
    description: 'Edit investment headline, thesis, and page messaging.',
    fields: [
      { key: 'invest_hero_title', label: 'Hero Title', type: 'text', defaultVal: 'Invest With Purecrest' },
      { key: 'invest_hero_subtitle', label: 'Hero Description', type: 'textarea', defaultVal: "Partner with Purecrest to access premium real estate and hospitality investment opportunities in Nigeria's growing market. We offer transparent structures, expert management, and attractive returns." },
      { key: 'invest_why_heading', label: 'Why Invest Section Heading', type: 'text', defaultVal: 'Your Investment, Our Expertise' },
    ],
  },
  {
    id: 'contact',
    label: 'Contact & Footer',
    icon: 'fa-address-book',
    previewPath: '/contact',
    description: 'Edit Contact page copy, WhatsApp, email, social links, and global footer text.',
    fields: [
      { key: 'contact_hero_title', label: 'Contact Page Title', type: 'text', defaultVal: 'Contact Us' },
      { key: 'contact_hero_subtitle', label: 'Contact Page Subtitle', type: 'textarea', defaultVal: "We'd love to hear from you. Reach out for enquiries about our properties, hospitality services, or investment advisory." },
      { key: 'contact_office_intro', label: 'Contact Intro Copy', type: 'textarea', defaultVal: "Call us, chat on WhatsApp, or send a message — we're available to help you navigate your real estate and hospitality journey." },
      { key: 'contact_email', label: 'Public Contact Email', type: 'text', defaultVal: 'hello@purecrest.ng' },
      { key: 'whatsapp_number', label: 'WhatsApp Number', type: 'text', defaultVal: '+2349130403970' },
      { key: 'footer_tagline', label: 'Footer Brand Tagline', type: 'textarea', defaultVal: 'Delivering excellence in hospitality management, real estate solutions, and property technology across Nigeria.' },
      { key: 'facebook_url', label: 'Facebook URL', type: 'url', defaultVal: 'https://facebook.com/purecrestng' },
      { key: 'instagram_url', label: 'Instagram URL', type: 'url', defaultVal: 'https://instagram.com/purecrestng' },
      { key: 'twitter_url', label: 'LinkedIn / X URL', type: 'url', defaultVal: 'https://linkedin.com/company/purecrest' },
    ],
  },
]

// =========================================================================
// HOTEL PMS MARKETING SECTION — links directly to https://pchpms.com
// =========================================================================
export function renderPmsMarketingSection(
  settings: Record<string, string>,
  variant: 'home' | 'hospitality' | 'technology' = 'home'
): string {
  if (variant !== 'technology' && settings.pms_banner_enabled === '0') {
    return ''
  }

  const badge = escHtml(settings.pms_banner_badge || 'PURECREST HOTEL PMS')
  const title = escHtml(settings.pms_banner_title || 'Get Your Hotel Property Management System')
  const subtitle = escHtml(
    settings.pms_banner_subtitle ||
      'Run your hotel, serviced apartments, or short-let portfolio effortlessly from one cloud platform. Automate reservations, front-desk check-ins, housekeeping, billing, OTA channel sync, and real-time revenue reporting.'
  )
  const ctaText = escHtml(settings.pms_banner_cta_text || 'Launch Hotel PMS at pchpms.com')
  const ctaUrl = escHtml(settings.pms_banner_cta_url || 'https://pchpms.com')
  const secondaryText = escHtml(settings.pms_banner_secondary_text || 'Request a Guided Demo')
  const secondaryUrl = escHtml(settings.pms_banner_secondary_url || '/contact?service=hospitality-software')
  const pmsImage = settings.pms_banner_image || '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png'

  const features = [
    settings.pms_feature_1 || 'Front Desk, Reservations & Instant Check-In',
    settings.pms_feature_2 || 'Real-Time OTA Channel & Booking Sync',
    settings.pms_feature_3 || 'Automated Billing, Folios & Housekeeping',
    settings.pms_feature_4 || 'Owner Revenue & Occupancy Dashboards',
  ].filter(Boolean)

  return `
  <!-- HOTEL PROPERTY MANAGEMENT SYSTEM MARKETING (pchpms.com) -->
  <section id="hotel-pms" style="background:linear-gradient(135deg, #071426 0%, #0B1F3A 55%, #051C12 100%); padding:84px 0; position:relative; overflow:hidden; border-top:1px solid rgba(201,168,76,0.22); border-bottom:1px solid rgba(201,168,76,0.22);">
    <div style="position:absolute; inset:0; opacity:0.05; background-image:linear-gradient(rgba(201,168,76,0.9) 1px, transparent 1px), linear-gradient(90deg, rgba(201,168,76,0.9) 1px, transparent 1px); background-size:56px 56px; pointer-events:none;"></div>
    <div style="position:absolute; left:0; top:0; bottom:0; width:4px; background:linear-gradient(to bottom, transparent, var(--gold), transparent);"></div>
    <div class="max-w-7xl mx-auto px-6" style="position:relative; z-index:2;">
      <div style="display:grid; grid-template-columns:1.15fr 0.85fr; gap:52px; align-items:center;" class="pms-promo-grid">
        <div>
          <p style="font-family:'Plus Jakarta Sans',sans-serif; font-size:0.72rem; font-weight:700; letter-spacing:0.2em; text-transform:uppercase; color:var(--gold); margin-bottom:14px;">
            <i class="fas fa-hotel" style="margin-right:8px;"></i>${badge}
          </p>
          <h2 style="font-family:'DM Serif Display',serif; font-size:clamp(2rem,4vw,3.1rem); line-height:1.1; color:#fff; font-weight:400; margin:0 0 18px;">
            ${title}
          </h2>
          <p style="font-family:'Plus Jakarta Sans',sans-serif; font-size:0.96rem; line-height:1.8; color:rgba(255,255,255,0.78); margin:0 0 28px; max-width:580px;">
            ${subtitle}
          </p>
          <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px 20px; margin-bottom:34px;" class="pms-feat-grid">
            ${features
              .map(
                (feat) => `
              <div style="display:flex; align-items:flex-start; gap:10px;">
                <span style="width:20px; height:20px; border-radius:4px; background:rgba(201,168,76,0.18); border:1px solid rgba(201,168,76,0.35); display:flex; align-items:center; justify-content:center; flex-shrink:0; margin-top:2px;">
                  <i class="fas fa-check" style="color:var(--gold); font-size:0.65rem;"></i>
                </span>
                <span style="font-family:'Plus Jakarta Sans',sans-serif; font-size:0.84rem; color:rgba(255,255,255,0.88); line-height:1.5;">${escHtml(feat)}</span>
              </div>`
              )
              .join('')}
          </div>
          <div style="display:flex; gap:14px; flex-wrap:wrap; align-items:center;">
            <a href="${ctaUrl}" target="_blank" rel="noopener noreferrer"
              style="display:inline-flex; align-items:center; gap:10px; padding:14px 28px; background:var(--gold); color:#0B1F3A; border-radius:6px; font-family:'Plus Jakarta Sans',sans-serif; font-size:0.88rem; font-weight:700; text-decoration:none; letter-spacing:0.02em; transition:opacity 0.2s;"
              onmouseover="this.style.opacity='0.9'" onmouseout="this.style.opacity='1'">
              <span>${ctaText}</span>
              <i class="fas fa-arrow-up-right-from-square" style="font-size:0.78rem;"></i>
            </a>
            <a href="${secondaryUrl}"
              style="display:inline-flex; align-items:center; gap:8px; padding:14px 24px; background:transparent; color:#fff; border:1.5px solid rgba(255,255,255,0.35); border-radius:6px; font-family:'Plus Jakarta Sans',sans-serif; font-size:0.86rem; font-weight:600; text-decoration:none; transition:border-color 0.2s;"
              onmouseover="this.style.borderColor='var(--gold)'; this.style.color='var(--gold)'" onmouseout="this.style.borderColor='rgba(255,255,255,0.35)'; this.style.color='#fff'">
              ${secondaryText}
            </a>
          </div>
        </div>

        <!-- Right: Product Card Preview -->
        <div style="background:rgba(255,255,255,0.04); border:1px solid rgba(201,168,76,0.28); border-radius:14px; overflow:hidden;">
          <div style="position:relative; height:220px; overflow:hidden; background:#09182E;">
            <img src="${escHtml(pmsImage)}" alt="PureCrest Hotel Property Management System — pchpms.com" style="width:100%; height:100%; object-fit:cover; display:block;" onerror="this.style.display='none'" />
            <div style="position:absolute; inset:0; background:linear-gradient(to top, rgba(7,20,38,0.92) 0%, rgba(7,20,38,0.18) 65%);"></div>
            <div style="position:absolute; bottom:16px; left:20px; right:20px; display:flex; align-items:center; justify-content:space-between; gap:12px;">
              <div>
                <p style="font-family:'Plus Jakarta Sans',sans-serif; font-size:0.68rem; font-weight:700; letter-spacing:0.14em; text-transform:uppercase; color:var(--gold); margin:0 0 2px;">CLOUD HOSPITALITY PLATFORM</p>
                <p style="font-family:'DM Serif Display',serif; font-size:1.35rem; color:#fff; margin:0;">pchpms.com</p>
              </div>
              <a href="${ctaUrl}" target="_blank" rel="noopener noreferrer" style="padding:8px 14px; background:rgba(201,168,76,0.2); border:1px solid rgba(201,168,76,0.5); color:var(--gold); border-radius:6px; font-family:'Plus Jakarta Sans',sans-serif; font-size:0.75rem; font-weight:700; text-decoration:none; white-space:nowrap;">
                Visit Site <i class="fas fa-arrow-right" style="font-size:0.65rem; margin-left:4px;"></i>
              </a>
            </div>
          </div>
          <div style="padding:20px 22px; display:grid; grid-template-columns:repeat(3,1fr); gap:12px; border-top:1px solid rgba(255,255,255,0.08);">
            <div>
              <p style="font-family:'DM Serif Display',serif; font-size:1.35rem; color:var(--gold); margin:0 0 2px;">24/7</p>
              <p style="font-family:'Plus Jakarta Sans',sans-serif; font-size:0.72rem; color:rgba(255,255,255,0.68); margin:0;">Cloud Access</p>
            </div>
            <div>
              <p style="font-family:'DM Serif Display',serif; font-size:1.35rem; color:#fff; margin:0 0 2px;">All-in-One</p>
              <p style="font-family:'Plus Jakarta Sans',sans-serif; font-size:0.72rem; color:rgba(255,255,255,0.68); margin:0;">PMS + Channel Sync</p>
            </div>
            <div>
              <p style="font-family:'DM Serif Display',serif; font-size:1.35rem; color:#fff; margin:0 0 2px;">Multi-Unit</p>
              <p style="font-family:'Plus Jakarta Sans',sans-serif; font-size:0.72rem; color:rgba(255,255,255,0.68); margin:0;">Hotels &amp; Shortlets</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <style>
    @media (max-width: 960px) { .pms-promo-grid { grid-template-columns: 1fr !important; gap: 32px !important; } }
    @media (max-width: 560px) { .pms-feat-grid { grid-template-columns: 1fr !important; } }
  </style>`
}

// =========================================================================
// FULL-SITE CMS ADMIN EDITOR (/admin/cms)
// =========================================================================
export function renderAdminCmsPage(
  settings: Record<string, string>,
  activeTabId: string,
  saved: boolean,
  adminLayout: (title: string, content: string, activeSection: string) => string
): string {
  const activeTab = CMS_TABS.find((t) => t.id === activeTabId) || CMS_TABS[0]

  const fieldHtml = activeTab.fields
    .map((f) => {
      const val = settings[f.key] !== undefined && settings[f.key] !== '' ? settings[f.key] : f.defaultVal
      const safeVal = escHtml(val)

      if (f.type === 'toggle') {
        const checked = val !== '0'
        return `
        <div class="bg-slate-50 border border-slate-200 rounded-xl p-4 flex items-center justify-between gap-4">
          <div>
            <label for="cms_${f.key}" class="block text-sm font-semibold text-slate-800">${escHtml(f.label)}</label>
            ${f.help ? `<p class="text-xs text-slate-500 mt-0.5">${escHtml(f.help)}</p>` : ''}
          </div>
          <div class="flex items-center gap-2">
            <input type="hidden" name="${f.key}" value="0" />
            <input type="checkbox" id="cms_${f.key}" name="${f.key}" value="1" ${checked ? 'checked' : ''}
              class="w-5 h-5 accent-amber-600 rounded cursor-pointer" />
          </div>
        </div>`
      }

      if (f.type === 'image') {
        return `
        <div class="border border-slate-200 rounded-xl p-4 bg-white">
          <div class="flex flex-col sm:flex-row sm:items-start gap-4">
            <div class="w-full sm:w-44 h-28 rounded-lg overflow-hidden bg-slate-100 border border-slate-200 flex-shrink-0 relative">
              <img id="prev_${f.key}" src="${safeVal}" alt="${escHtml(f.label)}"
                class="w-full h-full object-cover" onerror="this.style.opacity='0.25'" />
            </div>
            <div class="flex-1 min-w-0 space-y-2.5">
              <div class="flex flex-wrap items-center justify-between gap-2">
                <label class="text-sm font-semibold text-slate-800">${escHtml(f.label)}</label>
                <span id="status_${f.key}" class="text-xs font-medium text-slate-400"></span>
              </div>
              <div class="flex flex-wrap items-center gap-2">
                <input type="file" id="file_${f.key}" accept="image/*" class="hidden"
                  onchange="cmsUploadImage(this, '${f.key}')" />
                <button type="button" onclick="document.getElementById('file_${f.key}').click()"
                  class="px-3.5 py-2 rounded-lg text-xs font-semibold text-white flex items-center gap-1.5 whitespace-nowrap"
                  style="background:#0B1F3A;">
                  <i class="fas fa-cloud-upload-alt text-amber-400"></i> Upload New Image
                </button>
                <button type="button" onclick="openCmsMediaPicker('${f.key}')"
                  class="px-3.5 py-2 rounded-lg text-xs font-semibold border border-slate-300 bg-white text-slate-700 hover:bg-slate-50 flex items-center gap-1.5 whitespace-nowrap">
                  <i class="fas fa-photo-video text-amber-600"></i> Choose from Media Library
                </button>
                <span class="text-xs text-slate-400">Auto-optimised &amp; saved immediately</span>
              </div>
              <label for="input_${f.key}" class="block text-xs font-medium text-slate-500">Image URL</label>
              <input type="text" id="input_${f.key}" name="${f.key}" value="${safeVal}"
                oninput="document.getElementById('prev_${f.key}').src=this.value"
                class="w-full px-3 py-2 border border-slate-200 rounded-lg text-xs font-mono text-slate-700 focus:outline-none focus:border-amber-500" />
              ${f.help ? `<p class="text-xs text-slate-500">${escHtml(f.help)}</p>` : ''}
            </div>
          </div>
        </div>`
      }

      if (f.type === 'textarea') {
        return `
        <div>
          <label for="cms_${f.key}" class="block text-sm font-semibold text-slate-700 mb-1.5">${escHtml(f.label)}</label>
          <textarea id="cms_${f.key}" name="${f.key}" rows="3"
            class="w-full px-3.5 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-100">${safeVal}</textarea>
          ${f.help ? `<p class="text-xs text-slate-500 mt-1">${escHtml(f.help)}</p>` : ''}
        </div>`
      }

      return `
      <div>
        <label for="cms_${f.key}" class="block text-sm font-semibold text-slate-700 mb-1.5">${escHtml(f.label)}</label>
        <input type="${f.type === 'url' ? 'url' : 'text'}" id="cms_${f.key}" name="${f.key}" value="${safeVal}"
          class="w-full px-3.5 py-2.5 border border-slate-200 rounded-lg text-sm text-slate-800 focus:outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-100" />
        ${f.help ? `<p class="text-xs text-slate-500 mt-1">${escHtml(f.help)}</p>` : ''}
      </div>`
    })
    .join('')

  const content = `
  <div class="max-w-6xl mx-auto">
    ${
      saved
        ? `<div class="mb-5 bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-xl px-4 py-3 flex items-center justify-between text-sm font-semibold">
             <span><i class="fas fa-check-circle text-emerald-600 mr-2"></i>All changes to "${escHtml(activeTab.label)}" have been saved and published live.</span>
             <a href="${escHtml(activeTab.previewPath)}" target="_blank" class="text-xs underline text-emerald-700 whitespace-nowrap ml-4">Preview Live Page <i class="fas fa-external-link-alt ml-1"></i></a>
           </div>`
        : ''
    }

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
      <!-- Left Page Selector -->
      <div class="lg:col-span-3 bg-white rounded-xl border border-slate-200 overflow-hidden">
        <div class="px-4 py-3.5 border-b border-slate-200" style="background:#0B1F3A;">
          <p class="text-xs font-bold uppercase tracking-wider text-amber-400">Site Pages CMS</p>
          <p class="text-xs text-slate-300 mt-0.5">Edit text &amp; images site-wide</p>
        </div>
        <div class="p-2 space-y-0.5">
          ${CMS_TABS.map(
            (t) => `
          <a href="/admin/cms?tab=${t.id}"
            class="flex items-center gap-2.5 px-3 py-2.5 rounded-lg text-xs font-semibold transition-colors ${
              t.id === activeTab.id
                ? 'bg-amber-50 text-slate-900 border border-amber-200'
                : 'text-slate-600 hover:bg-slate-50 border border-transparent'
            }">
            <i class="fas ${t.icon} w-4 text-center ${t.id === activeTab.id ? 'text-amber-600' : 'text-slate-400'}"></i>
            <span class="truncate">${escHtml(t.label)}</span>
          </a>`
          ).join('')}
        </div>
      </div>

      <!-- Right Editor Form -->
      <div class="lg:col-span-9 bg-white rounded-xl border border-slate-200 overflow-hidden">
        <div class="px-6 py-4 border-b border-slate-200 flex flex-wrap items-center justify-between gap-3 bg-slate-50/70">
          <div>
            <h2 class="text-base font-bold text-slate-900 flex items-center gap-2">
              <i class="fas ${activeTab.icon} text-amber-600"></i> ${escHtml(activeTab.label)}
            </h2>
            <p class="text-xs text-slate-500 mt-0.5">${escHtml(activeTab.description)}</p>
          </div>
          <a href="${escHtml(activeTab.previewPath)}" target="_blank"
            class="px-3.5 py-2 rounded-lg text-xs font-semibold border border-slate-300 bg-white text-slate-700 hover:bg-slate-50 flex items-center gap-1.5 whitespace-nowrap">
            <i class="fas fa-external-link-alt text-amber-600"></i> View Live Page
          </a>
        </div>

        <form method="POST" action="/admin/cms/save" class="p-6 space-y-5">
          <input type="hidden" name="_tab" value="${activeTab.id}" />
          ${fieldHtml}

          <div class="pt-4 border-t border-slate-200 flex items-center justify-between gap-4">
            <p class="text-xs text-slate-400">Changes update the live database immediately upon saving.</p>
            <button type="submit"
              class="btn-gold px-6 py-2.5 rounded-lg text-sm font-semibold flex items-center gap-2 whitespace-nowrap">
              <i class="fas fa-save"></i> Save &amp; Publish ${escHtml(activeTab.label)}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Media Library Picker Modal -->
  <div id="cmsMediaPickerModal" class="hidden fixed inset-0 z-50 flex items-center justify-center p-4" style="background:rgba(5,28,18,0.68);">
    <div class="bg-white rounded-2xl w-full max-w-4xl max-h-[86vh] flex flex-col overflow-hidden shadow-2xl border border-slate-200">
      <div class="px-5 py-4 border-b border-slate-200 flex items-center justify-between" style="background:#0B1F3A;">
        <div>
          <h3 class="text-sm font-bold text-white flex items-center gap-2"><i class="fas fa-images text-amber-400"></i> Choose from Dashboard Media Library</h3>
          <p class="text-xs text-slate-300 mt-0.5">Select any seeded or uploaded site image below</p>
        </div>
        <button type="button" onclick="closeCmsMediaPicker()" class="w-8 h-8 rounded-full bg-white/15 text-white hover:bg-white/25 flex items-center justify-center"><i class="fas fa-times text-xs"></i></button>
      </div>
      <div id="cmsMediaPickerBody" class="p-5 overflow-y-auto grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3 bg-slate-50 flex-1"></div>
    </div>
  </div>

  <script>
    async function compressCmsImage(file, targetBytes) {
      targetBytes = targetBytes || (420 * 1024);
      if (!file || !file.type || !file.type.startsWith('image/') || file.type === 'image/gif' || file.type === 'image/svg+xml') return file;
      if (file.size <= targetBytes) return file;
      return new Promise((resolve) => {
        const img = new Image();
        const url = URL.createObjectURL(file);
        img.onload = async () => {
          URL.revokeObjectURL(url);
          const origW = img.naturalWidth || img.width;
          const origH = img.naturalHeight || img.height;
          if (!origW || !origH) return resolve(file);
          const dims = [1400, 1100, 860, 680];
          const quals = [0.84, 0.72, 0.58, 0.45];
          const outType = file.type === 'image/png' ? 'image/webp' : 'image/jpeg';
          const ext = outType === 'image/webp' ? '.webp' : '.jpg';
          let bestFile = file;
          for (let i = 0; i < dims.length; i++) {
            const maxD = dims[i];
            const scale = Math.min(1, maxD / Math.max(origW, origH));
            const w = Math.max(1, Math.round(origW * scale));
            const h = Math.max(1, Math.round(origH * scale));
            const canvas = document.createElement('canvas');
            canvas.width = w; canvas.height = h;
            const ctx = canvas.getContext('2d');
            if (!ctx) break;
            ctx.drawImage(img, 0, 0, w, h);
            const blob = await new Promise((r) => canvas.toBlob(r, outType, quals[i]));
            if (blob) {
              const candidate = new File([blob], (file.name || 'image').replace(/\\.[^.]+$/, '') + ext, { type: outType });
              if (candidate.size < bestFile.size) bestFile = candidate;
              if (candidate.size <= targetBytes) { resolve(candidate); return; }
            }
          }
          resolve(bestFile);
        };
        img.onerror = () => { URL.revokeObjectURL(url); resolve(file); };
        img.src = url;
      });
    }

    let _cmsPickerKey = null;
    window.openCmsMediaPicker = async function(key) {
      _cmsPickerKey = key;
      const modal = document.getElementById('cmsMediaPickerModal');
      const body = document.getElementById('cmsMediaPickerBody');
      if (!modal || !body) return;
      modal.classList.remove('hidden');
      body.innerHTML = '<div class="col-span-full py-12 text-center text-sm text-slate-500"><i class="fas fa-spinner fa-spin mr-2"></i>Loading media library…</div>';
      try {
        const res = await fetch('/api/media?type=image', { credentials: 'same-origin' });
        const data = await res.json();
        const items = (data && data.items) || [];
        if (!items.length) {
          body.innerHTML = '<div class="col-span-full py-12 text-center text-sm text-slate-400">No images found in Media Library yet.</div>';
          return;
        }
        body.innerHTML = '';
        items.forEach((m) => {
          const src = m.display_url || (m.file_url && (m.file_url.startsWith('/') || m.file_url.startsWith('http')) ? m.file_url : ('/api/media/' + m.id));
          const card = document.createElement('button');
          card.type = 'button';
          card.className = 'group text-left bg-white rounded-xl border border-slate-200 overflow-hidden hover:border-amber-500 hover:shadow-md transition-all focus:outline-none';
          card.onclick = () => pickCmsMedia(src);
          card.innerHTML = '<div class="relative aspect-[4/3] bg-slate-100 overflow-hidden"><img src="' + escAttr(src) + '" class="w-full h-full object-cover" loading="lazy" /></div><div class="p-2"><p class="text-[11px] font-semibold text-slate-700 truncate"></p></div>';
          card.querySelector('p').textContent = m.file_name || ('media-' + m.id);
          body.appendChild(card);
        });
      } catch (_) {
        body.innerHTML = '<div class="col-span-full py-12 text-center text-sm text-red-600">Failed to load Media Library.</div>';
      }
    };
    function escAttr(s) { return String(s || '').replace(/"/g, '&quot;').replace(/</g, '&lt;'); }
    window.closeCmsMediaPicker = function() {
      const modal = document.getElementById('cmsMediaPickerModal');
      if (modal) modal.classList.add('hidden');
      _cmsPickerKey = null;
    };
    window.pickCmsMedia = function(url) {
      if (!_cmsPickerKey) return;
      const inputEl = document.getElementById('input_' + _cmsPickerKey);
      const prevEl = document.getElementById('prev_' + _cmsPickerKey);
      const statusEl = document.getElementById('status_' + _cmsPickerKey);
      if (inputEl) inputEl.value = url;
      if (prevEl) { prevEl.style.opacity = '1'; prevEl.src = url; }
      if (statusEl) { statusEl.className = 'text-xs font-semibold text-amber-700'; statusEl.textContent = 'Selected from library — click Save & Publish'; }
      window.closeCmsMediaPicker();
    };

    window.cmsUploadImage = async function(input, key) {
      const file = input.files && input.files[0];
      if (!file) return;
      const statusEl = document.getElementById('status_' + key);
      const prevEl = document.getElementById('prev_' + key);
      const inputEl = document.getElementById('input_' + key);
      if (statusEl) { statusEl.className = 'text-xs font-semibold text-blue-600'; statusEl.textContent = 'Optimising & uploading...'; }
      try {
        const optimized = await compressCmsImage(file, 420 * 1024);
        const fd = new FormData();
        fd.append('image', optimized);
        fd.append('setting_key', key);
        const res = await fetch('/api/upload-service-image', { method: 'POST', body: fd, credentials: 'same-origin' });
        const data = await res.json();
        if (data.success && data.url) {
          if (inputEl) inputEl.value = data.url;
          if (prevEl) { prevEl.style.opacity = '1'; prevEl.src = data.url; }
          if (statusEl) { statusEl.className = 'text-xs font-semibold text-emerald-600'; statusEl.textContent = 'Uploaded & saved ✓'; }
        } else {
          if (statusEl) { statusEl.className = 'text-xs font-semibold text-red-600'; statusEl.textContent = data.error || 'Upload failed'; }
        }
      } catch (err) {
        if (statusEl) { statusEl.className = 'text-xs font-semibold text-red-600'; statusEl.textContent = 'Network error — try again'; }
      }
      input.value = '';
    };
  </script>`

  return adminLayout('Site Pages CMS', content, 'cms')
}
