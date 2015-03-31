%% replace these defines with your data

-define(DB_HOSTNAME, "127.0.0.1").
-define(DB_PORT, 5984).
-define(DB_HOST, {?DB_HOSTNAME, ?DB_PORT}).

% %%
%  Database and views definitions
%  values are (in couch DB notation): DB_HOST/DB_POSTS_DATABASE/_design/DB_POSTS_DOCUMENT_CLASS/_view/DB_ALL_POSTS_VIEW_CLASS
% %%

% databases
-define(DB_POSTS_DATABASE, "erlblog-posts").

% documents
-define (DB_POSTS_DOCUMENT_CLASS, "all_posts").

% database views
-define(DB_ALL_POSTS_VIEW, "all").
