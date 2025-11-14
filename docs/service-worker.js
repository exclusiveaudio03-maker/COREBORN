self.addEventListener("install", event => {
  event.waitUntil(
    caches.open("coreborn-cache").then(cache => {
      return cache.addAll([
        "./",
        "index.html",
        "game.pck",
        "game.js",
        "game.wasm",
        "manifest.json"
      ]);
    })
  );
});

self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request);
    })
  );
});
