'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "623127d96107e258b6bf1b3b9e724965",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "37984c1259147e705b5fc75a3ca8353a",
"version.json": "d4c1d7b3ce13283faf4a9860753d9952",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"main.dart.js": "b8cb5c7eb241d152f6a009674489c54e",
"index.html": "d174d47f186e2fb98332e2d07e3c1cd1",
"/": "d174d47f186e2fb98332e2d07e3c1cd1",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "6947b94a85929559d4b00b543d8149df",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/u_credit_card/fonts/OCR-A-regular.ttf": "426fbbd15636b132aafe10f83c816e3f",
"assets/packages/u_credit_card/assets/images/visa_logo.png": "8ce71663ec640331057e5b42cacc1994",
"assets/packages/u_credit_card/assets/images/discover.png": "b66abb29035e7fa885cb565c4aedfb30",
"assets/packages/u_credit_card/assets/images/master_card.png": "fe807bce353d0bc60f09a60409236255",
"assets/packages/u_credit_card/assets/images/chip.png": "c7c92244ce8c689f6ac515b9569bb09f",
"assets/packages/u_credit_card/assets/images/amex.png": "78a87e922e4af6db197310737ef9b9fe",
"assets/packages/u_credit_card/assets/images/nfc.png": "d0e0c4bc69cb7005c10ce684f0603468",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "fabe749aa85ba93a2b92f346b611a78b",
"assets/NOTICES": "8ce8824807717e413abf45e406b9ca33",
"assets/AssetManifest.json": "1a1780c5a7bfdd6a2e09f43ddb0940f3",
"assets/AssetManifest.bin": "3a9f201887c6bc317d2e8ea13a6d7eba",
"assets/AssetManifest.bin.json": "c86a20c8200bc669ae20a45f09a5ee53",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/MaterialIcons-Regular.otf": "3acaa4b7206bcc099a76b7ac0e5e2ed8",
"assets/assets/images/img_persion.png": "570d6552dfead9ab200b4c8b084354f7",
"assets/assets/images/img_mock_1.png": "1bdeb9e28fc00dc47d23ec4531831306",
"assets/assets/images/img_card_background.png": "640c81a76a8538dbb464df4df0370924",
"assets/assets/images/img_onboard_backgourd.png": "a3847aad19d937826c413932c3c95c7b",
"assets/assets/images/img_forgot_password.svg": "76e38b30c9d7364457afbd08d081d967",
"assets/assets/images/imag_union.png": "ebdeac6cb5c5e658f02a51d475177ee4",
"assets/assets/images/img_mock_3.png": "c932d351a0cee8975c16c89e5218bb94",
"assets/assets/images/img_mock_2.png": "267aa1ce891be91a921f7aa22173da6f",
"assets/assets/images/product_preview_4.png": "f7fde3d077a65b196f420e6c3f126483",
"assets/assets/images/image_phone.png": "9e46cb02f06ea319f7be8203b07ec80e",
"assets/assets/images/img_mock_4.png": "65737ede391a20f2e3eeeebbc5d05d74",
"assets/assets/images/product_preview_3.png": "a8e298006a61cb9bb41d448d9606f182",
"assets/assets/images/img_splash.png": "b8316129e78e50c869655e2502bda3ba",
"assets/assets/images/product_preview_1.png": "fbf03cf4f8be8dd20124eaca34c54bbb",
"assets/assets/images/product_preview_2.png": "3d00d551c47a78ca334bc462b64677da",
"assets/assets/images/product_detail.png": "9f5733d1d12c2905a21bb25a71462802",
"assets/assets/images/img_union.png": "568c533dcba7c5e21d5afefe23aeb272",
"assets/assets/images/img_title_splash.png": "e070f87142ec59c8f4e323d581fce470",
"assets/assets/translations/vi-VN.json": "a92208952e22e6f892df0c871a8cd8f7",
"assets/assets/translations/en-US.json": "b53e3a0f504d0e54b280307cb5e14e29",
"assets/assets/icons/icon_wallet.svg": "ee13de377842b7ab9e2633ba01362bd8",
"assets/assets/icons/icon_cart.svg": "b7ff0b5483f5b37480350e57c6703225",
"assets/assets/icons/icon_master.png": "9b955ab51c65138cecd0d5e090632fd3",
"assets/assets/icons/icon_modifiy.svg": "c9b4a1b2bbc92b68fae8556c50e2c454",
"assets/assets/icons/icon_filter.svg": "c9ddb0b2d965e25c102a6791c8727548",
"assets/assets/icons/icon_home.svg": "85faa7159576b69a8965c9893577b3e4",
"assets/assets/icons/icon_facebook.svg": "73c5bbd7a7c5d850492a6231d700e336",
"assets/assets/icons/icon_nike_brand.svg": "d574cd9afce202908f8ccfec11a4cd68",
"assets/assets/icons/icon_adidas.svg": "258c6c2010326c1978e510a1f102fb55",
"assets/assets/icons/icon_chevron_down.svg": "f0dab345d0ed2d48a0c083abe1205a94",
"assets/assets/icons/icon_lock.svg": "65c3118b4b78e1a551f958104ba0a5a8",
"assets/assets/icons/icon_logout.svg": "bc4a4ba5fdc8b2cbe526c5837afb1ca7",
"assets/assets/icons/icon_heart.svg": "829bbcc10c613b5e7e16a20995ec0590",
"assets/assets/icons/icon_nike.svg": "ee5e86f4007ff9d550021af14000fb66",
"assets/assets/icons/icon_wishlist.svg": "22a79a217f1d08c12d8758f5cc26be4c",
"assets/assets/icons/icon_chevron_up.svg": "f30a2a739a65506baff6f41c3ef5606e",
"assets/assets/icons/icon_google.svg": "f98f6de9bd3741f0d0c033b631518321",
"assets/assets/icons/icon_edit.svg": "50807be298950519baeb29027aba9fe0",
"assets/assets/icons/icon_bank.png": "6b71eb38233fc213a26ece1e3ca2a4f3",
"assets/assets/icons/icon_mic.svg": "31c3da464662eea7be5ac7221f68693c",
"assets/assets/icons/icon_done.svg": "27c6d77b0bc36c8a63b23a2d0bba6500",
"assets/assets/icons/icon_warring.svg": "5ad0d4cde4f7c20aaba82b164166b781",
"assets/assets/icons/icon_paypal.png": "a92906241f6d04f239f74b3212e5f899",
"assets/assets/icons/icon_setting.svg": "4b35b36fb33d10dfc4ebf3a3f7b7785c",
"assets/assets/icons/icon_twitter.svg": "5c97e5be25ba08fd8cd28b7b1d99c369",
"assets/assets/icons/icon_menu.svg": "7a3a100310b02b5ab172037af475c3e3",
"assets/assets/icons/icon_bag.svg": "527507a04dfdc6585373c570c6458766",
"assets/assets/icons/icon_sun.svg": "1b2de8591c9de7e5af716f4a1afa44a9",
"assets/assets/icons/icon_fila.svg": "12173be7bf1d773e3b5b73818537bee8",
"assets/assets/icons/icon_delete.svg": "9ceea8028cf30bbb8fc725eba25c3f79",
"assets/assets/icons/icon_sort.svg": "ad962d53d52365731f30d7bf7c366ec0",
"assets/assets/icons/icon_search.svg": "4dda9485b84b94db69716cbfaf010ee3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
