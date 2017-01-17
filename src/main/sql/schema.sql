---创建秒杀数据库相关脚本
create database seckill;

---使用数据库
use seckill;

--创建秒杀数据库表
create table seckill(`a`
'seckill_id' bigint NOT NULL AUTO_INCREMENT COMMENT '商品库存id',
'name' varchar(120) NOT NULL COMMENT '商品名称',
'number' int NOT NULL COMMENT '库存数量',
'start_time' timestamp NOT NULL COMMENT '秒杀开始时间',
'end_time' timestamp NOT NULL COMMENT '秒杀结束时间',
'create_time' timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
PRIMARY KEY (seckill_id),
key idx_start_time(start_time),
key idx_end_time(end_time),
key idx_create_time(create_time)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='秒杀库存表';


CREATE TABLE seckill (
	`seckill_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '商品库存id',
	`name` VARCHAR (120) NOT NULL COMMENT '商品名称',
	`number` INT NOT NULL COMMENT '库存数量',
	`start_time` TIMESTAMP NOT NULL COMMENT '秒杀开始时间',
	`end_time` TIMESTAMP NOT NULL COMMENT '秒杀结束时间',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY (seckill_id),
	KEY idx_start_time (start_time),
	KEY idx_end_time (end_time),
	KEY idx_create_time (create_time)
) ENGINE = INNODB AUTO_INCREMENT = 1000 DEFAULT CHARSET = utf8 COMMENT = '秒杀库存表'

--初始化秒杀数据
insert into 
	seckill(name,number,start_time,end_time) 
values
	('10元秒杀罗技鼠标',100,'2016-09-17 22:57:22','2016-09-18 22:57:22'),
	('10元秒杀神州笔记本',100,'2016-09-17 22:57:22','2016-09-18 22:57:22'),
	('10元秒杀诺基亚',100,'2016-09-17 22:57:22','2016-09-18 22:57:22'),
	('10元秒杀威刚移动硬盘',100,'2016-09-17 22:57:22','2016-09-18 22:57:22')

---秒杀成功明细表
---用户登录认证相关信息
create table success_killed(
	`seckill_id` bigint NOT NULL COMMENT '秒杀商品id',
	`user_phone` bigint NOT NULL COMMENT '用户手机号',
	`state` tinyint NOT NULL DEFAULT -1 COMMENT '状态表示: -1:无效 0:成功 1:已付款',
	`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY (seckill_id,user_phone),
	key idx_create_time(create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀成功明细表'