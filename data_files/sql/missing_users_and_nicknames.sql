SET @user_id_arabijoni = UUID();
SET @user_id_dimka300688 = UUID();
SET @user_id_Leicester = UUID();
SET @user_id_midlan = UUID();

INSERT INTO main.`user` (id, username)
VALUES
    (@user_id_arabijoni, 'arabijoni'),
    (@user_id_dimka300688, 'dimka300688'),
    (@user_id_Leicester, 'Leicester'),
    (@user_id_midlan, 'midlan');

INSERT INTO main.user_nickname (id, user_id, nickname, is_active, portal_id)
VALUES
    (UUID(), @user_id_arabijoni, 'arabijoni', 0, NULL),
    (UUID(), @user_id_dimka300688, 'dimka300688', 0, NULL),
    (UUID(), @user_id_Leicester, 'Leicester', 0, NULL),
    (UUID(), @user_id_midlan, 'midlan', 0, NULL);