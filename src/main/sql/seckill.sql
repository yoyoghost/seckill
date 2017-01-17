--秒杀执行的存储过程
DELIMITER $$

CREATE PROCEDURE `seckill`.`execute_seckill`
	(in v_seckill_id bigint,in v_phone bigint,in v_kill_time timestamp,out r_result int)
	BEGIN
		declare insert_count int DEFAULT 0;
		start transaction;
		insert ignore into success_killed
			(seckill_id,user_phone,create_time)
		values(v_seckill_id,v_phone,v_kill_time);
		select row_count() into insert_count;
		IF(insert_count = 0) THEN
			ROLLBACK;
			set r_result = -1;
		ELSEIF(insert_count < 0) THEN
			ROLLBACK;
			set r_result = -2;
		ELSE
				update seckill
					set number = number - 1
					where seckill_id = v_seckill_id
					and end_time > v_kill_time
					and start_time < v_kill_time
					and number > 0;
				select row_count() into insert_count;
				if(insert_count=0) THEN
					ROLLBACK;
					set r_result = 0;
				elseif(insert_count<0) THEN
					ROLLBACK;
					set r_result = -2;
				else
					commit;
					set r_result = 1;
				end if;
		end if;
	END
$$
--存储过程定义结束
DELIMITER ;

set @r_result=-3;

--执行存储过程
call execute_seckill(1003,13520775684,now(),@r_result);

select @r_result;