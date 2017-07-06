BEGIN;
CREATE SCHEMA api AUTHORIZATION example;
GRANT ALL ON SCHEMA api TO example;
SET search_path = api, public;

\ir types/user_role.sql

\ir views/users.sql

\ir functions/iterate.sql
\ir functions/register_user.sql
COMMIT;