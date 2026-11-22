-- Migration 0012: Full-Site CMS defaults & Hotel PMS (pchpms.com) Marketing settings

INSERT OR IGNORE INTO site_settings (key, value) VALUES
-- Homepage Hero & Sections
('hero_title', 'Hospitality & Property
Management Solutions'),
('hero_subtitle', 'Purecrest delivers world-class hotel management, short-let operations, property sales, leasing, and real estate advisory — helping owners maximise returns and guests enjoy exceptional stays.'),
('hero_cta_1_text', 'Contact Us'),
('hero_cta_1_url', '/contact'),
('hero_cta_2_text', 'Our Services'),
('hero_cta_2_url', '/services'),
('hero_bg_image', '/static/hero-bg.jpg'),
('whatwedo_title', 'Integrated Solutions.
Endless Possibilities.'),
('whatwedo_body', 'Purecrest is a dynamic company providing end-to-end solutions in hospitality and real estate. From premium hospitality management to property development and investment advisory, we create spaces and experiences that stand the test of time.'),
('service_card_1_title', 'Purecrest Hospitality'),
('service_card_1_desc', 'Hotel management, serviced apartments, and short-let operations delivering exceptional guest experiences and maximum owner returns.'),
('service_img_hospitality', '/static/service-hospitality.jpg'),
('service_card_2_title', 'Purecrest Property'),
('service_card_2_desc', 'Real estate development, property sales, leasing, and investment advisory creating lasting value across Nigeria.'),
('service_img_property', '/static/service-property.jpg'),
('service_card_3_title', 'Pure Crest Technology'),
('service_card_3_desc', 'Web development, booking systems, and hospitality software powering modern hospitality and property businesses.'),
('service_img_solutions', '/static/service-solutions.jpg'),
('service_card_4_title', 'Hospitality Virtual Support'),
('service_card_4_desc', 'Professional remote management for your hospitality business — 24/7 guest support, reservations, revenue management, and operations coordination.'),
('ota_banner_image', '/static/ota-ad-banner.png'),
('manage_section_title', 'Let Us Manage Your Property'),
('manage_section_body', 'We are an ethical brand built on transparency, integrity, and results. Whether you own a shortlet apartment, serviced residence, or a hotel — we handle everything from marketing, guest management, maintenance to revenue optimisation. Earn more while we manage for you.'),
('training_banner_title', 'Elevate Your Team with
Professional Training'),
('training_banner_body', 'Purecrest delivers hands-on hospitality training programmes for hotels, serviced apartments, and hospitality businesses — building exceptional service cultures from the front desk to leadership.'),
('home_cta_title', 'Whether you need property management, OTA optimization, virtual support or real estate services — we are here to help.'),
('home_cta_btn_text', 'Get in Touch'),

-- Hotel PMS Marketing Section (pchpms.com)
('pms_banner_enabled', '1'),
('pms_banner_badge', 'PURECREST HOTEL PMS'),
('pms_banner_title', 'Get Your Hotel Property Management System'),
('pms_banner_subtitle', 'Run your hotel, serviced apartments, or short-let portfolio effortlessly from one cloud platform. Automate reservations, front-desk check-ins, housekeeping, billing, OTA channel sync, and real-time revenue reporting.'),
('pms_banner_cta_text', 'Launch Hotel PMS at pchpms.com'),
('pms_banner_cta_url', 'https://pchpms.com'),
('pms_banner_secondary_text', 'Request a Guided Demo'),
('pms_banner_secondary_url', '/contact?service=hospitality-software'),
('pms_banner_image', '/static/service-solutions.jpg'),
('pms_feature_1', 'Front Desk, Reservations & Instant Check-In'),
('pms_feature_2', 'Real-Time OTA Channel & Booking Sync'),
('pms_feature_3', 'Automated Billing, Folios & Housekeeping'),
('pms_feature_4', 'Owner Revenue & Occupancy Dashboards'),

-- Hospitality Page
('hosp_hero_title', 'Your Property.
Our Management.
Better Hospitality.'),
('hosp_hero_subtitle', 'We partner with hotel owners and property investors to professionally manage, reposition, and grow their hospitality assets — delivering world-class guest experiences and maximising owner returns.'),
('hosp_services_heading', 'Comprehensive Hospitality Management'),
('hosp_cta_title', 'Let Purecrest Manage Your Shortlet or Hotel — We Deliver Results with Integrity'),
('hosp_cta_subtitle', 'Transparent reporting, professional management, and maximum revenue — all with zero compromise on standards.'),

-- OTA Listing Page
('ota_hero_title', 'OTA Listing Optimization
& Management Services'),
('ota_hero_subtitle', 'We maximize your property''s visibility, bookings, and revenue across Airbnb, Booking.com, Expedia, Vrbo and all major OTAs — through expert listing optimization, dynamic pricing, and full-service channel management.'),
('ota_hero_image', '/static/service-hospitality.jpg'),
('ota_intro_title', 'Turn Your Property into a High-Performing Listing'),
('ota_intro_body', 'Most property owners leave significant revenue on the table because their OTA listings are poorly optimized. Our team of hospitality and digital marketing specialists transforms your listings into top-ranking, high-converting assets on every major booking platform.'),
('ota_cta_title', 'Ready to Maximize Your Booking Revenue?'),
('ota_cta_subtitle', 'Let us audit your current OTA listings for free and show you exactly how much revenue you are leaving behind — and how we can fix it.'),

-- Virtual Support Page
('vs_hero_title', 'Hospitality Virtual Support
Professional Services'),
('vs_hero_subtitle', 'Professional remote hospitality management for property owners. Our dedicated virtual support team handles your guests, bookings, and operations — so you can earn more while doing less.'),
('vs_hero_image', '/static/service-hospitality.jpg'),
('vs_reach_banner', 'We serve property owners in Nigeria · UK · USA · Canada · Europe · Middle East · Australia · and beyond.'),
('vs_intro_title', 'For Property Owners Who Want Hands-Free Management'),
('vs_intro_body', 'Whether you live abroad, have a busy schedule, or simply want a professional team managing your hospitality business — Purecrest Virtual Support delivers the expertise and dedication of a full management team, remotely.'),
('vs_quote', 'Your property managed like a business, not a side project.'),

-- Property Services Page
('prop_hero_title', 'Real Estate Solutions
That Create Value'),
('prop_hero_subtitle', 'We connect buyers, sellers, tenants, and investors with premium residential and commercial properties across Nigeria — with expert advisory at every step.'),
('property_hero_image', '/static/service-property.jpg'),
('prop_services_heading', 'From Acquisition to Investment'),
('prop_cta_title', 'Looking for a Property?'),
('prop_cta_subtitle', 'Browse our curated listings or speak to one of our property experts today.'),

-- Technology Page
('tech_hero_title', 'Digital Solutions
That Power Modern
Hospitality & Business'),
('tech_hero_subtitle', 'We build the web platforms, booking systems, and hospitality software that power Purecrest and our clients — combining deep industry knowledge with modern technology to deliver measurable digital transformation.'),
('technology_hero_image', '/static/service-solutions.jpg'),
('tech_core_heading', 'Our Core Technology Services'),
('tech_core_subtitle', 'From custom websites to intelligent booking systems, we engineer the digital backbone of modern hospitality and property businesses.'),
('tech_pms_title', 'Get Your Hotel Property Management System (PCHPMS)'),
('tech_pms_body', 'Streamline hotel operations, reservations, housekeeping, guest billing, and multi-property analytics with Purecrest Hotel PMS — purpose-built for modern African hospitality operators.'),
('tech_pms_url', 'https://pchpms.com'),

-- Solutions Page
('sol_hero_title', 'Grow Your Business
with Purecrest Solutions'),
('sol_hero_subtitle', 'We help businesses, startups, and investors achieve clarity, visibility, and growth through strategic branding, digital marketing, web development, and business consulting.'),
('solutions_hero_image', '/static/service-solutions.jpg'),
('sol_cta_title', 'Ready to Grow Your Business?'),
('sol_cta_subtitle', 'Let''s talk about how Purecrest Solutions can help you achieve your business goals.'),

-- Services Overview Page
('svc_hero_title', 'Our Services'),
('svc_hero_subtitle', 'Three powerful business lines working together to deliver exceptional value — hospitality management, real estate solutions, and business advisory.'),
('svc_hosp_body', 'We deliver world-class hospitality management, serviced apartment operations, and short-let management that create memorable guest experiences and maximise property returns.'),
('svc_prop_body', 'We deliver comprehensive real estate services — from property development and sales to leasing, management, and investment advisory — helping clients achieve measurable results.'),
('svc_sol_body', 'We help businesses grow through strategic branding, digital marketing, and powerful technology — including web development, booking systems, and hospitality software that power our wider operations.'),

-- About Page
('about_hero_title', 'A Commitment to Excellence
in Hospitality & Property'),
('about_hero_subtitle', 'Purecrest is a diversified company delivering world-class hospitality management, real estate development, and innovative business solutions across Nigeria.'),
('about_section_image', '/static/service-property.jpg'),
('about_story_title', 'Building Nigeria''s Most Trusted Hospitality & Property Company'),
('about_story_p1', 'Founded with a vision to redefine hospitality and real estate in Nigeria, Purecrest brings together industry expertise, innovation, and integrity to deliver exceptional experiences and lasting value.'),
('about_story_p2', 'From managing premium shortlets and serviced apartments across Nigeria to advising investors on real estate development, our team is dedicated to building trust, creating iconic spaces, and elevating every client experience.'),
('about_mission', 'To deliver exceptional hospitality experiences and property solutions that inspire trust, create lasting value, and elevate communities across Nigeria and beyond.'),
('about_vision', 'To be the leading integrated hospitality and property company in West Africa — known for innovation, integrity, and the enduring quality of our spaces and service.'),

-- Invest Page
('invest_hero_title', 'Invest With Purecrest'),
('invest_hero_subtitle', 'Partner with Purecrest to access premium real estate and hospitality investment opportunities in Nigeria''s growing market. We offer transparent structures, expert management, and attractive returns.'),
('invest_why_heading', 'Your Investment, Our Expertise'),

-- Contact Page
('contact_hero_title', 'Contact Us'),
('contact_hero_subtitle', 'We''d love to hear from you. Reach out for enquiries about our properties, hospitality services, or investment advisory.'),
('contact_office_intro', 'Visit us, call us, or send a message — we''re available to help you navigate your real estate and hospitality journey.'),
('office_address', 'Abuja, Federal Capital Territory, Nigeria');
