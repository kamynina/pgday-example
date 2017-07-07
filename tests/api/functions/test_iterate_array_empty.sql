CREATE FUNCTION test_iterate_array_empty() RETURNS SETOF TEXT
LANGUAGE plpgsql AS
$$
BEGIN
    RETURN NEXT ok(TRUE);
    PERFORM iterate(ARRAY[]::INT[]);
    PERFORM iterate(ARRAY[1,2]::INT[]);
END;
$$;