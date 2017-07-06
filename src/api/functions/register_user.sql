CREATE FUNCTION register_user(_login TEXT, _password TEXT) RETURNS BIGINT
LANGUAGE plpgsql AS
$$
DECLARE
    _id BIGINT;
BEGIN
    INSERT INTO public.users (login, password)
    VALUES (_login, _password)
    RETURNING id
    INTO _id;
    RETURN _id;
END;
$$;