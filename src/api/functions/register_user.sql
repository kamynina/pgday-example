CREATE FUNCTION register_user(_login TEXT, _password TEXT) RETURNS BIGINT
LANGUAGE plpgsql AS
$$
DECLARE
    _id BIGINT;
BEGIN
    IF length(_password) < 3 THEN
        RAISE EXCEPTION 'password is too short';
    END IF;
    INSERT INTO public.users (login, password)
    VALUES (_login, _password)
    RETURNING id
    INTO _id;
    RETURN _id;
END;
$$;