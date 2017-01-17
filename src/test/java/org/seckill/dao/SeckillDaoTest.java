package org.seckill.dao;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckill;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author phonics
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SeckillDaoTest {

	@Resource
	private SeckillDao secKillDao;
	
	@Test
	public void testReduceNumber() {
		Date killTime = new Date();
		int reduceNumber = secKillDao.reduceNumber(1000L, killTime);
		System.out.println("reduceNumber="+reduceNumber);
	}

	@Test
	public void testQueryById() {
		Long seckillId = 1000L;
		Seckill seckill = secKillDao.queryById(seckillId);
		System.out.println(seckill.getName());
		System.out.println(seckill);
	}

	@Test
	public void testQueryAll() {
		List<Seckill> list = secKillDao.queryAll(0, 100);
		System.out.println(list.toString());
	}

}
