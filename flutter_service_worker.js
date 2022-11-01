'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "db999ec541af78b758488edb34e4cecf",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"index.html": "96842d0810347c3110a7564311c949d4",
"/": "96842d0810347c3110a7564311c949d4",
"manifest.json": "12f5e74b5d1506527a9eaf99f7995f0a",
"main.dart.js": "fe7187a3d1a5187a276c56c7b1e50742",
"logo.png": "8d2a8f238c40eb0950f15416cdc7c71c",
"assets/AssetManifest.json": "28e94bb56b0e897228b0ba13494b4ed0",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "d3c50d2e651845db3d1e1b41e1da4a95",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/animations/loading.json": "48a926b294d84e140cf24358135680cf",
"assets/assets/logos/melior_rounded_logo.png": "449adc6cec3619a4a6b38f5b923a988d",
"assets/assets/logos/melior_text_logo.png": "d3f73c85caf1f7dfed5166ac90c0ddce",
"assets/assets/logos/melior_logo.png": "565f451ba1367d17e0230d69e494567a",
"assets/assets/logos/supabase.png": "99c3730cf068618b13172a053f12abd9",
"assets/assets/translations/en.json": "3438df97cb442d401453298f973f66f8",
"assets/assets/translations/vi.json": "40f5a2b982f471e7d78b5d6cc8f72145",
"assets/assets/icons/auth/login/ic_apple.svg": "05497ef7b427f9ea408a268ae3d72be8",
"assets/assets/icons/auth/login/ic_google.svg": "4a3a59e7a5ae2159dab85bec7a92c919",
"assets/assets/icons/auth/login/ic_facebook.svg": "6aa5ae14c1d36144fb20349160df960d",
"assets/assets/icons/auth/ic_hide_content.svg": "3a5087b54534b30fbbf942b1b7e5b52e",
"assets/assets/icons/auth/ic_remove_rounded.svg": "f112b215a0755f926f81a16daf037d05",
"assets/assets/icons/auth/ic_show_content.svg": "50738cfe75bddc076879d758db7cb01d",
"assets/assets/icons/friends/ic_user_circle.svg": "d1f48ae5b70cf17361f4d257a7a1494d",
"assets/assets/icons/friends/ic_select_all.svg": "dbd32aa96fffe222c25a886950c96386",
"assets/assets/icons/friends/ic_search.svg": "f8fb6401c118183c1487a8e07ca54d1e",
"assets/assets/icons/friends/ic_menu.svg": "b413998a257a7133197031543508d9dd",
"assets/assets/icons/friends/ic_trash.svg": "f3b674948e223dd366a55a93d6698aa5",
"assets/assets/icons/friends/ic_share.svg": "0ee7be84a1b4e533d8389bf379e50bff",
"assets/assets/icons/friends/ic_add_friend.svg": "bebcefe3d2d67b7f2719407b3c30ce37",
"assets/assets/icons/friends/ic_close.svg": "b52dc4c5706bb52aac34c102358646ed",
"assets/assets/icons/friends/ic_tag.svg": "8423891c012ac11515f3107753cf626c",
"assets/assets/icons/library/ic_clock.svg": "e4a2add4dc42b66d5f0a460319393abc",
"assets/assets/icons/library/ic_customed_line.png": "ea1b57bb6effda278dece8cd4e97fba2",
"assets/assets/icons/tabbar/ic_home@512x.png": "38a777896bb8f26dea7f818f9c02023b",
"assets/assets/icons/tabbar/ic_library@512x.png": "4915393f6f3c48a377d5ea7949e940e9",
"assets/assets/icons/tabbar/ic_setting@512x.png": "ab9db9c88930909ff2d8868e527d9285",
"assets/assets/icons/tabbar/ic_searching@512x.png": "ed5cb60cb1dcb9a297b5b7efa893f720",
"assets/assets/icons/accounts/ic_selected.svg": "319d7b8c9c8e47d02e9fc756e2391f13",
"assets/assets/icons/accounts/ic_back.svg": "d62d5e6ccbdbedce8923d9bed35cab31",
"assets/assets/icons/accounts/ic_dark_mode.svg": "9b70989eaad655bcf355c8bcf7ca606a",
"assets/assets/icons/accounts/ic_language.svg": "af9c20e33c1d3c6890ec547ba464786b",
"assets/assets/icons/accounts/ic_key.svg": "42bca340999f38463efe472cfdb29131",
"assets/assets/icons/accounts/ic_logout.svg": "c6abb6f23f4007c62a8386c56df09b0f",
"assets/assets/icons/accounts/ic_editting.svg": "0c97abd1a82dbe01414183249cf71dd2",
"assets/assets/icons/accounts/ic_light_mode.svg": "c7f7294ae4ce3b0fa45ce8c0ad68d5da",
"assets/assets/icons/player/ic_shuffle.svg": "078bf200c55cc664f2c8049802239d08",
"assets/assets/icons/player/ic_play.svg": "f8a778d11843fd4d41c81950cd1b82b7",
"assets/assets/icons/player/ic_pause.svg": "75fe21727043ab9606582fb57165e50b",
"assets/assets/icons/player/ic_replay_10.svg": "0778f772e3483d5386deaf523789a5f8",
"assets/assets/icons/player/ic_previous.svg": "9eb2bd9b6f003322ac480fc2895558e0",
"assets/assets/icons/player/ic_next.svg": "65ddc9e2e1b38503a40d170ce3e62f2f",
"assets/assets/icons/player/ic_forward_10.svg": "a7b09679dd0e70bd2b6a78e0bc346298",
"assets/assets/icons/player/ic_loop.svg": "6ec3f41d25e75eb24fa00791cee5eeec",
"assets/assets/icons/home/ic_hello_custom_vi.svg": "7f567485c684d8d5db5f8aae5ce12deb",
"assets/assets/icons/home/ic_adding_friend.svg": "e81a3db6d0c317034edbd9e6299ed6b8",
"assets/assets/icons/home/ic_explain.svg": "903c8d385677629df98a519746f8c22f",
"assets/assets/icons/home/ic_hello_custom_en.svg": "4c509a0b4675462bbf1ea9b202ec5542",
"assets/assets/icons/home/ic_user_info.svg": "d1f48ae5b70cf17361f4d257a7a1494d",
"assets/assets/icons/home/ic_customed_line.png": "ea1b57bb6effda278dece8cd4e97fba2",
"assets/assets/icons/home/ic_user.svg": "1c40f9c25b1d6ee76c07e71ef409e457",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/easy_localization/i18n/en.json": "5f5fda8715e8bf5116f77f469c5cf493",
"assets/packages/easy_localization/i18n/ar-DZ.json": "acc0a8eebb2fcee312764600f7cc41ec",
"assets/packages/easy_localization/i18n/en-US.json": "5f5fda8715e8bf5116f77f469c5cf493",
"assets/packages/easy_localization/i18n/ar.json": "acc0a8eebb2fcee312764600f7cc41ec",
"assets/shaders/ink_sparkle.frag": "ae6304797c013e3fdd9df7ef0c543a62",
"icons/512.png": "0664d142b46cb434d269db296cb8a7f6",
"icons/196.png": "d480f6cf0b340f89afe062640531d31f",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
