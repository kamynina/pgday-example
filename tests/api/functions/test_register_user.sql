CREATE FUNCTION test_iterate() RETURNS SETOF TEXT
LANGUAGE plpgsql AS
$$
BEGIN
    RETURN NEXT register_user('vasya', '123');
END;
$$;