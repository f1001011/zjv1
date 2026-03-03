CREATE TABLE `ntp_common_email` (
                                    `id` int(11) NOT NULL AUTO_INCREMENT,
                                    `user_id` int(11) NOT NULL DEFAULT '0',
                                    `title` varchar(255) NOT NULL,
                                    `content` varchar(255) DEFAULT NULL,
                                    `is_send` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 未发送 1 已发送',
                                    `is_read` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 未读 1 已读',
                                    `send_time` datetime DEFAULT NULL COMMENT '发送时间',
                                    `create_time` datetime NOT NULL COMMENT '创建时间',
                                    `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '变化时间',
                                    PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='邮件发送表';