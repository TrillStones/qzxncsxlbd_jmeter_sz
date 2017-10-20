CREATE PROCEDURE `add_random_user`()
BEGIN
DECLARE userName VARCHAR (20) ;
DECLARE userMail VARCHAR (20) ;
DECLARE i INT DEFAULT 3;--原来是1，要看jforum_users表最新一个用户的id是多少，要比最新那个用户id大就行
WHILE i<= 400 DO
set userName = CONCAT ('test1', LPAD ( i, 3, '0' )) ;
set userMail = CONCAT (userName, '@test.com' ) ;
INSERT INTO jforum_users VALUES ( i, '1', userName,'823da4223e46ec671al0eal3d7823534', '0', '0',
null, '2015-05-06 09:33:18', null, '0', '', null, '', '%d/%M/%Y %H:%i', '0', '0', null, null, '0', '1',
'0', '1', '1', '1', '1', '1', '1', '0', '0', '1', '1', '0', null, '0',userMail, null, null, null,
null, null, null, null, null, null, null, null, null, null, null, null, '1', null, null, null) ;
INSERT INTO jforum_user_groups VALUES (3,i) ;
SET i = i+1;
END WHILE;
END

