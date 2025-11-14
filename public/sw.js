self.addEventListener("install", (event) => {
  self.skipWaiting();
  event.waitUntil(
    caches.open("coreborn-cache").then((cache) => {
      return cache.addAll([
        "/",
        "/index.html",
        "/coreborn.js",
        "/coreborn.pck",
        "/coreborn.wasm",
        "/manifest.webmanifest"
      ]);
    })
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});
