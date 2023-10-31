// service worker
self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open("static").then((cache) => {
      return cache.addAll(["./"]);
    })
  );
});

// self.addEventListener("fetch", (e) => {
//   e.respondWith(
//     caches.match(e.request).then((response) => {
//       return response || fetch(e.request);
//     })
//   );
// });

self.addEventListener('fetch', function (event) {
  event.respondWith(
    cache.match(event.request).then(function (response) {
      if (response) {
        // 检查 ETag
        var etag = response.headers.get('ETag');
        if (etag) {
          // 如果 ETag 存在，将其添加到请求头中
          var headers = new Headers(event.request.headers);
          headers.append('If-None-Match', etag);
          event.request.headers = headers;
        }
      }
      // 发送请求
      return fetch(event.request).then(function (networkResponse) {
        // 如果响应状态是 304（Not Modified），则返回缓存的响应
        if (networkResponse.status === 304) {
          return response;
        }
        // 否则，更新缓存并返回新的响应
        cache.put(event.request, networkResponse.clone());
        return networkResponse;
      });
    })
  );
});