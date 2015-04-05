-module (router).
-export ([urls/0]).
-compile(export_all).

urls() -> [
  {"^posts/?$", posts_handler },
  {"^posts/(.+?)/?$", posts_handler } % url: /posts/:post_id
].
