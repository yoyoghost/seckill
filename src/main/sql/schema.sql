---������ɱ���ݿ���ؽű�
create database seckill;

---ʹ�����ݿ�
use seckill;

--������ɱ���ݿ��
create table seckill(`a`
'seckill_id' bigint NOT NULL AUTO_INCREMENT COMMENT '��Ʒ���id',
'name' varchar(120) NOT NULL COMMENT '��Ʒ����',
'number' int NOT NULL COMMENT '�������',
'start_time' timestamp NOT NULL COMMENT '��ɱ��ʼʱ��',
'end_time' timestamp NOT NULL COMMENT '��ɱ����ʱ��',
'create_time' timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
PRIMARY KEY (seckill_id),
key idx_start_time(start_time),
key idx_end_time(end_time),
key idx_create_time(create_time)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='��ɱ����';


CREATE TABLE seckill (
	`seckill_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '��Ʒ���id',
	`name` VARCHAR (120) NOT NULL COMMENT '��Ʒ����',
	`number` INT NOT NULL COMMENT '�������',
	`start_time` TIMESTAMP NOT NULL COMMENT '��ɱ��ʼʱ��',
	`end_time` TIMESTAMP NOT NULL COMMENT '��ɱ����ʱ��',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
	PRIMARY KEY (seckill_id),
	KEY idx_start_time (start_time),
	KEY idx_end_time (end_time),
	KEY idx_create_time (create_time)
) ENGINE = INNODB AUTO_INCREMENT = 1000 DEFAULT CHARSET = utf8 COMMENT = '��ɱ����'

--��ʼ����ɱ����
insert into 
	seckill(name,number,start_time,end_time) 
values
	('10Ԫ��ɱ�޼����',100,'2016-09-17 22:57:22','2016-09-18 22:57:22'),
	('10Ԫ��ɱ���ݱʼǱ�',100,'2016-09-17 22:57:22','2016-09-18 22:57:22'),
	('10Ԫ��ɱŵ����',100,'2016-09-17 22:57:22','2016-09-18 22:57:22'),
	('10Ԫ��ɱ�����ƶ�Ӳ��',100,'2016-09-17 22:57:22','2016-09-18 22:57:22')

---��ɱ�ɹ���ϸ��
---�û���¼��֤�����Ϣ
create table success_killed(
	`seckill_id` bigint NOT NULL COMMENT '��ɱ��Ʒid',
	`user_phone` bigint NOT NULL COMMENT '�û��ֻ���',
	`state` tinyint NOT NULL DEFAULT -1 COMMENT '״̬��ʾ: -1:��Ч 0:�ɹ� 1:�Ѹ���',
	`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����ʱ��',
	PRIMARY KEY (seckill_id,user_phone),
	key idx_create_time(create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ɱ�ɹ���ϸ��'