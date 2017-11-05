#1后台删除所有分类，然后去jforum_categories表将ID字段的自增设置为1
#2手工添加5个版面的分类，因为不手工添加，直接在数据库加会在首页展示不出来，分类名称如下：
categories_id	title	display_order	moderated
1	测试管理讨论区	1	0
2	JMeter技术区	2	0
3	自动化测试区	3	0
4	性能测试工具开发区	4	0
5	Test Category	5	0
#顺便也给sql语句吧
INSERT INTO `jforum`.`jforum_categories`(`categories_id`, `title`, `display_order`, `moderated`) VALUES (1, '测试管理讨论区', 1, 0);
INSERT INTO `jforum`.`jforum_categories`(`categories_id`, `title`, `display_order`, `moderated`) VALUES (2, 'JMeter技术区', 2, 0);
INSERT INTO `jforum`.`jforum_categories`(`categories_id`, `title`, `display_order`, `moderated`) VALUES (3, '自动化测试区', 3, 0);
INSERT INTO `jforum`.`jforum_categories`(`categories_id`, `title`, `display_order`, `moderated`) VALUES (4, '性能测试工具开发区', 4, 0);
INSERT INTO `jforum`.`jforum_categories`(`categories_id`, `title`, `display_order`, `moderated`) VALUES (5, 'Test Category', 5, 0);

#3，添加版面数据，如果是手动在后台添加数据，则将jforum_forums的自增的数字设置为1。
#应该也可以直接执行sql语句，执行完重启tomcat即可
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (1, 1, '测试管理', '测试管理', 1, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (2, 1, '测试管理工具', '测试管理工具', 2, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (3, 2, 'JMeter技术交流', 'JMeter技术交流', 3, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (4, 2, 'JMeter工具扩展', 'JMeter工具扩展', 4, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (5, 3, 'QTP', 'QTP技术交流', 5, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (6, 3, 'selenium', 'selenium技术交流区', 6, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (7, 4, '监控工具', '监控工具交流区', 7, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (8, 4, '监控工具开发', '监控工具开发', 8, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (9, 1, '性能测试工具开发', '性能测试工具开发', 9, 0, 0, 0);
INSERT INTO `jforum`.`jforum_forums`(`forum_id`, `categories_id`, `forum_name`, `forum_desc`, `forum_order`, `forum_topics`, `forum_last_post_id`, `moderated`) VALUES (10, 5, 'Test Forum', 'THis is a Test Forum', 10, 0, 0, 0);

#该脚本展示了如何准备数据
#4添加随机用户
#要看jforum_users表最新一个用户的id是多少，要比最新那个用户id大就行
CREATE PROCEDURE `add_random_user`()
BEGIN
DECLARE userName VARCHAR (20) ;
DECLARE userMail VARCHAR (20) ;
DECLARE i INT DEFAULT 3;#原来是1，要看jforum_users表最新一个用户的id是多少，要比最新那个用户id大就行
WHILE i<= 400 DO
set userName = CONCAT ('test1', LPAD ( i, 3, '0' )) ;
set userMail = CONCAT (userName, '@test.com' ) ;
#密码123456
INSERT INTO jforum_users VALUES ( i, '1', userName,'e10adc3949ba59abbe56e057f20f883e', '0', '0',
null, '2015-05-06 09:33:18', null, '0', '', null, '', '%d/%M/%Y %H:%i', '0', '0', null, null, '0', '1',
'0', '1', '1', '1', '1', '1', '1', '0', '0', '1', '1', '0', null, '0',userMail, null, null, null,
null, null, null, null, null, null, null, null, null, null, null, null, '1', null, null, null) ;
INSERT INTO jforum_user_groups VALUES (3,i) ;
SET i = i+1;
END WHILE;
END


#5创建帖子和回复帖子的sql
CREATE PROCEDURE `addTopics`()
BEGIN
DECLARE topicId INT;
DECLARE postId INT;
DECLARE topicCount INT;
DECLARE userid INT;
DECLARE forumId INT;
DECLARE createDate datetime;
DECLARE i INT DEFAULT 1000053;#这里其实就加了1条记录和二个回复，修改WHILE i<=1000055来决定你要添加多少个帖子和回复帖子的数据
WHILE i<=1000055 DO 
set userid = 13+ceil(rand()*360 ) ;
set createDate = DATE_ADD( now(), INTERVAL - 3 DAY) ; 
set createDate = DATE_ADD( now(), INTERVAL -3 HOUR) ;
set forumId = 1+ceil(rand()*9) ;
SET topicId=i;
SET postId=i;

INSERT INTO jforum_topics VALUES (topicId, forumId ,CONCAT (topicId,'Welcome to
JForum' ) , userid,createDate,1,0,0,0,0,i,i+2,0, 0) ;

INSERT INTO jforum_posts VALUES (topicId,topicId,
forumId,userid,createDate,'127.0.0.1',1,0,1,1,null,0,1,0,0) ;

INSERT INTO jforum_posts VALUES (i+1,topicId,
forumId,userid,createDate,'127.0.0.1',1,0,1,1,null,0,1,0,0) ;

INSERT INTO jforum_posts VALUES (i+2,topicId,
forumId,userid,createDate,'127.0.0.1',1,0,1,1, null, 0,1,0,0) ;

INSERT INTO jforum_posts_text VALUES (postId,'[b][color-blue)[size-18]Congratulations :!;
[/size) [/color] (/b]\nYou have completed the installation, and JForum is up and running. \n\nTo start
administering the board, login as [i]Admin / <the password you supplied in the installed[/i] and
access the [b][url-/admBase/login.page]Admin Control Panel[/url](/b] using the link that shows up
in the bottom of the page. There you will be able to create Categories, Forums and much more :D \n\nFor
more information and support, please refer to the following pages:\n\n:arrow: Community forum:
http://www.jforum.net/community.jsp\n:arrow: Documentation: http://www.jforum.net/doc\n\nThank you for
choosing JForum. \n\n (url-http: //www. j forum. net/doc/Team] The JForum Team [ /url] \n\n',' Welcome to JForum');
INSERT INTO jforum_posts_text VALUES (i+1,'[b][color-blue](size-18]Congratulations :!:
[/size] [/color] [/b]\nYou have completed the installation, and JForum is up and running. \n\nTo start
administering the board, login as [i]Admin / <the password you supplied in the installed[/i] and
access the [b][url-/admBase/login.page]Admin Control Panel[/url][/b] using the link that shows up
in the bottom of the page. There you will be able to create Categories, Forums and much more :D \n\nFor
more information and support, please refer to the following pages:\n\n:arrow: Community forum:
http://www.jforum.net/community.jsp\n:arrow: Documentation: http://www.jforum.net/doc\n\nThank you for
choosing JForum. \n\n [url-http: //www. j forum.net/doc/Team] The JForum Team [ /url ] \n\n',' Welcome to JForum' );
INSERT INTO jforum_posts_text VALUES (i+2,'[b][color-blue](size-18]Congratulations :!:
[/size] [/color] [/b]\nYou have completed the installation, and JForum is up and running. \n\nTo start
administering the board, login as [i]Admin / <the password you supplied in the installed[/i] and
access the [b]lurl-/admBase/login.page]Admin Control Panel[/urll[/b] using the link that shows up
in the bottom of the page. There you will be able to create Categories, Forums and much more :D \n\nFor
more information and support, please refer to the following pages:\n\n:arrow: Community forum:
http://www.jforum.net/community.jsp\n:arrow: Documentation: http://www.jforum.net/doc\n\nThank you for
choosing JForum. \n\n [url=http: //www. jforum.net/doc/Team] The JForumTeam[/url] \n\n', ' Welcome to JForum' );
SET i = i+3;
END WHILE;
END

#6，添加了数据，但是你访问论坛时，还是没有数据显示出来的，所以需要修改表的一些字段的值。
SELECT count(topic_id),max(topic_id),forum_id
FROM jforum_topics GROUP BY forum_id asc

