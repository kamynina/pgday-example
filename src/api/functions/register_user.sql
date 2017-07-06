CREATE FUNCTION register_user(_login TEXT, _password TEXT) RETURNS INT
LANGUAGE plpgsql AS
$$
DECLARE
    _id INT;
BEGIN
    INSERT INTO public.users (login, password)
    VALUES (_login, _password)
    RETURNING id
    INTO _id;
END;
$$;