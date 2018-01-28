CREATE TABLE `board` (
   `board_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `board_title` varchar(100) NOT NULL,
   `board_content` varchar(21000) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `report_count` int(1) NOT NULL DEFAULT '0',
   `recommend_count` int(1) NOT NULL DEFAULT '0',
   `thumbnail_url` varchar(200) DEFAULT NULL,
   PRIMARY KEY (`board_no`,`board_title`),
   KEY `email_idx` (`email`),
   CONSTRAINT `email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8
 
 CREATE TABLE `bookmark` (
   `bookmark_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `target_email` varchar(45) NOT NULL,
   PRIMARY KEY (`bookmark_no`),
   KEY `bookmark_email_idx` (`email`),
   KEY `bookmark_target_email_idx` (`target_email`),
   CONSTRAINT `bookmark_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `bookmark_target_email` FOREIGN KEY (`target_email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8
 
 CREATE TABLE `chatroom` (
   `room_id` varchar(45) NOT NULL,
   `room_title` varchar(45) DEFAULT NULL,
   `room_content` varchar(45) DEFAULT NULL,
   `room_type` int(11) DEFAULT NULL,
   `reg_date` datetime DEFAULT CURRENT_TIMESTAMP,
   `max_user` varchar(45) DEFAULT NULL,
   `image` varchar(45) DEFAULT NULL,
   `host` varchar(45) DEFAULT NULL,
   PRIMARY KEY (`room_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8
 
 CREATE TABLE `codes` (
   `code_no` int(11) NOT NULL AUTO_INCREMENT,
   `code_name` varchar(45) NOT NULL,
   PRIMARY KEY (`code_no`)
 ) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8
 
 CREATE TABLE `comment` (
   `comment_no` int(11) NOT NULL AUTO_INCREMENT,
   `board_no` int(11) NOT NULL,
   `senior_comment_no` int(11) DEFAULT NULL,
   `email` varchar(45) NOT NULL,
   `level` int(1) NOT NULL DEFAULT '0',
   `content` varchar(600) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `report_count` int(1) NOT NULL DEFAULT '0',
   `active` int(1) NOT NULL DEFAULT '1',
   `recommend_count` int(11) NOT NULL DEFAULT '0',
   PRIMARY KEY (`comment_no`),
   KEY `comment_email_idx` (`email`),
   KEY `comment_board_no_idx` (`board_no`),
   CONSTRAINT `comment_board_no` FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `comment_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8
 
 CREATE TABLE `creation` (
   `creation_no` int(11) NOT NULL AUTO_INCREMENT,
   `creation_title` varchar(100) NOT NULL,
   `author` varchar(45) NOT NULL,
   `creation_head` varchar(45) NOT NULL,
   `creation_file_name` varchar(100) NOT NULL,
   `creation_origin_name` varchar(100) NOT NULL,
   `creation_intro` varchar(800) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `active` int(1) NOT NULL DEFAULT '1',
   PRIMARY KEY (`creation_no`),
   KEY `creation_author_idx` (`author`),
   CONSTRAINT `creation_author` FOREIGN KEY (`author`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8
 
 CREATE TABLE `funding` (
   `funding_no` int(11) NOT NULL AUTO_INCREMENT,
   `creation_no` int(11) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `end_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `funding_target` int(4) NOT NULL,
   `per_funding` int(4) NOT NULL,
   `funding_file_name` varchar(100) NOT NULL,
   `funding_origin_name` varchar(100) NOT NULL,
   `active` int(1) NOT NULL DEFAULT '1',
   `funding_title` varchar(100) NOT NULL,
   `funding_intro` varchar(2000) DEFAULT NULL,
   PRIMARY KEY (`funding_no`),
   KEY `funding_creation_no_idx` (`creation_no`),
   CONSTRAINT `funding_creation_no` FOREIGN KEY (`creation_no`) REFERENCES `creation` (`creation_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8
 
 CREATE TABLE `grade` (
   `grade_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `category_no` int(1) NOT NULL,
   `target_no` bigint(20) NOT NULL,
   `grade` int(1) NOT NULL,
   PRIMARY KEY (`grade_no`),
   KEY `email_idx` (`email`),
   CONSTRAINT `grade_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8
 
 CREATE TABLE `like` (
   `like_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `category_no` int(1) NOT NULL,
   `target_no` bigint(20) NOT NULL,
   PRIMARY KEY (`like_no`),
   KEY `like_email_idx` (`email`),
   CONSTRAINT `like_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8
 
 CREATE TABLE `log` (
   `log_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `category_no` int(11) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `behavior` int(1) NOT NULL,
   `add_behavior` int(1) DEFAULT NULL,
   `target_no` bigint(20) NOT NULL,
   PRIMARY KEY (`log_no`),
   KEY `email_idx` (`email`),
   CONSTRAINT `log_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=5127 DEFAULT CHARSET=utf8
 
 CREATE TABLE `pay_info` (
   `pay_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `funding_no` int(11) NOT NULL,
   `tid` varchar(45) NOT NULL,
   `uid` varchar(45) NOT NULL,
   `user_name` varchar(45) NOT NULL,
   `post_code` varchar(10) NOT NULL,
   `addr` varchar(300) NOT NULL,
   `addr_detail` varchar(45) DEFAULT NULL,
   `phone` varchar(20) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`pay_no`),
   UNIQUE KEY `tid_UNIQUE` (`tid`),
   UNIQUE KEY `uid_UNIQUE` (`uid`),
   KEY `pay_info_email_idx` (`email`),
   KEY `pay_info_funding_no_idx` (`funding_no`),
   CONSTRAINT `pay_info_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `pay_info_funding_no` FOREIGN KEY (`funding_no`) REFERENCES `funding` (`funding_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8
 
 CREATE TABLE `posting` (
   `posting_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `posting_title` varchar(100) NOT NULL,
   `posting_content` varchar(21000) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `active` int(1) NOT NULL DEFAULT '1',
   PRIMARY KEY (`posting_no`),
   KEY `posting_email_idx` (`email`),
   CONSTRAINT `posting_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8
 
 CREATE TABLE `recommend` (
   `recommend_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `category_no` int(11) DEFAULT NULL,
   `target_no` bigint(20) DEFAULT NULL,
   `pref` varchar(10) DEFAULT NULL,
   PRIMARY KEY (`recommend_no`),
   KEY `recommend_email_idx` (`email`),
   CONSTRAINT `recommend_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8
 
 CREATE TABLE `reply` (
   `reply_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `category_no` int(1) NOT NULL,
   `target_no` bigint(20) unsigned NOT NULL,
   `reply_content` varchar(200) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`reply_no`),
   KEY `reply_email_idx` (`email`),
   CONSTRAINT `reply_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8
 
 CREATE TABLE `report` (
   `report_no` int(11) NOT NULL AUTO_INCREMENT,
   `email` varchar(45) NOT NULL,
   `target_no` bigint(20) NOT NULL,
   `category_no` int(11) NOT NULL,
   PRIMARY KEY (`report_no`),
   KEY `report_email_idx` (`email`),
   CONSTRAINT `report_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8
 
 CREATE TABLE `subscribe` (
   `subscribe_no` int(11) NOT NULL AUTO_INCREMENT,
   `creation_no` int(11) NOT NULL,
   `email` varchar(45) NOT NULL,
   PRIMARY KEY (`subscribe_no`),
   KEY `subscribe_email_idx` (`email`),
   KEY `subscribe_creation_no_idx` (`creation_no`),
   CONSTRAINT `subscribe_creation_no` FOREIGN KEY (`creation_no`) REFERENCES `creation` (`creation_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `subscribe_email` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8
 
 CREATE TABLE `tag` (
   `tag_no` int(11) NOT NULL AUTO_INCREMENT,
   `tag_name` varchar(45) NOT NULL,
   PRIMARY KEY (`tag_no`),
   UNIQUE KEY `tag_name_UNIQUE` (`tag_name`)
 ) ENGINE=InnoDB AUTO_INCREMENT=2150 DEFAULT CHARSET=utf8
 
 CREATE TABLE `tag_group` (
   `tag_group_no` int(11) NOT NULL AUTO_INCREMENT,
   `tag_no` int(11) NOT NULL,
   `category_no` int(1) NOT NULL,
   `target_no` bigint(20) NOT NULL,
   PRIMARY KEY (`tag_group_no`),
   KEY `tag_group_tag_no_idx` (`tag_no`),
   CONSTRAINT `tag_group_tag_no` FOREIGN KEY (`tag_no`) REFERENCES `tag` (`tag_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=2163 DEFAULT CHARSET=utf8
 
 CREATE TABLE `upload_file` (
   `upload_no` int(11) NOT NULL AUTO_INCREMENT,
   `category_no` int(1) NOT NULL,
   `target_no` bigint(20) NOT NULL,
   `file_name` varchar(100) NOT NULL,
   `origin_name` varchar(100) DEFAULT NULL,
   `main_file` int(1) DEFAULT '0',
   PRIMARY KEY (`upload_no`)
 ) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8
 
 CREATE TABLE `user` (
   `email` varchar(45) NOT NULL,
   `nickname` varchar(45) DEFAULT NULL,
   `password` varchar(45) DEFAULT NULL,
   `gender` varchar(6) NOT NULL,
   `birth` date NOT NULL,
   `active` int(1) NOT NULL DEFAULT '0',
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `role` varchar(45) NOT NULL DEFAULT 'user',
   `booklog_name` varchar(45) DEFAULT NULL,
   `booklog_intro` varchar(200) DEFAULT NULL,
   `booklog_image` varchar(100) DEFAULT '../../images/no_booklog_image.png',
   `certification_no` varchar(45) DEFAULT NULL,
   `outer_account` int(1) NOT NULL,
   `booklog_no` bigint(20) NOT NULL AUTO_INCREMENT,
   PRIMARY KEY (`email`),
   UNIQUE KEY `booklog_no_UNIQUE` (`booklog_no`),
   UNIQUE KEY `nickname_UNIQUE` (`nickname`)
 ) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8
 
 CREATE TABLE `writing` (
   `writing_no` int(11) NOT NULL AUTO_INCREMENT,
   `creation_no` int(11) NOT NULL,
   `writing_title` varchar(100) NOT NULL,
   `writing_content` varchar(21000) NOT NULL,
   `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `update_date` datetime DEFAULT CURRENT_TIMESTAMP,
   `active` int(1) NOT NULL DEFAULT '1',
   PRIMARY KEY (`writing_no`),
   KEY `writing_creation_no_idx` (`creation_no`),
   CONSTRAINT `writing_creation_no` FOREIGN KEY (`creation_no`) REFERENCES `creation` (`creation_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8
 
 INSERT INTO `bookbox`.`user` (`email`, `nickname`, `password`, `gender`, `birth`, `active`, `role`, `booklog_name`, `booklog_intro`, `outer_account`) VALUES ('admin', '운영자', 'admin', '남', '1990-12-27', '1', 'admin', '공지사항', '공지사항을 확인하세요', '0');
 
 