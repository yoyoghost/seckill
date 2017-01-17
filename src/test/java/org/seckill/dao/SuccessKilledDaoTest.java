package org.seckill.dao;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.SuccessKilled;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SuccessKilledDaoTest {

	@Resource
	SuccessKilledDao successKilledDao;
	
	@Test
	public void testInsertSuccessKilled() {
		Long seckillId = 1001L;
		Long userPhone = 13520775687L;
		int successKilled = successKilledDao.insertSuccessKilled(seckillId, userPhone);
		System.out.println("successKilled="+successKilled);
	}

	@Test
	public void testQueryByIdWithSeckill() {
		Long seckillId = 1001L;
		Long userPhone = 13520775687L;
		SuccessKilled successKilled = successKilledDao.queryByIdWithSeckill(seckillId,userPhone);
		System.out.println(successKilled.toString());
		System.out.println(successKilled.getSeckill());
	}

}
