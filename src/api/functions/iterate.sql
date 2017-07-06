CREATE FUNCTION iterate(_items ANYARRAY) RETURNS SETOF ANYELEMENT
LANGUAGE plpgsql VOLATILE
AS
$$
DECLARE
    _array_min_index    integer := ARRAY_LOWER(_items, 1);
    _array_max_index    integer := ARRAY_UPPER(_items, 1);
    _loop_index         integer;
BEGIN
    IF _array_min_index is null
    THEN
        RETURN;
    END IF;

    for _loop_index in _array_min_index .. _array_max_index LOOP
        IF _items [_loop_index] is not null
        THEN
            RETURN next _items [_loop_index];
        END IF;
    END LOOP;
END;
$$;