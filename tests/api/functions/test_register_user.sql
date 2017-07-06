CREATE FUNCTION test_register_user() RETURNS SETOF TEXT
LANGUAGE plpgsql AS
$$
DECLARE
    _test_user_id BIGINT;
BEGIN
    _test_user_id := register_user('Wasya', '123');
    RETURN QUERY SELECT is(
        users.*,
        ROW(
            _test_user_id,
            'Wasya',
            '123',
            CURRENT_TIMESTAMP
        )::users,
        'Check row user is correct'
    )
    FROM users
    WHERE id = _test_user_id;
    RETURN NEXT cmp_ok(_test_user_id, '=', currval('users_id_seq'), 'Return result equals users_id_seq' );
END;
$$;