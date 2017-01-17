package org.seckill.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.exception.RepeatKillException;
import org.seckill.exception.SeckillCloseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/spring-dao.xml", "classpath:spring/spring-service.xml" })
public class SeckillServiceTest {

	Logger log = LoggerFactory.getLogger(SeckillServiceTest.class);

	@Autowired
	SeckillService seckillService;

	@Test
	public void testGetSeckillList() {
		List<Seckill> seckillList = seckillService.getSeckillList();
		log.info("seckillList = {}", seckillList);
	}

	@Test
	public void testQueryById() {
		long seckillId = 1000l;
		Seckill seckill = seckillService.queryById(seckillId);
		log.info("seckill = {}", seckill);
	}

	@Test
	public void testExportSeckillUrl() {
		long seckillId = 1000;
		Exposer exposer = seckillService.exportSeckillUrl(seckillId);
		log.info("exposer = {}", exposer);
	}

	@Test
	public void testExecuteSeckill() {
		long seckillId = 1000;
		long userPhone = 13520775685l;
		SeckillExecution seckillExecution = seckillService.executeSeckill(seckillId, userPhone,
				"aa3101d13bcb6f7bb07f03f92ddda3f6");
		log.info("seckillExecution = {}", seckillExecution);
	}

	@Test
	public void testSeckillLogic() {
		long seckillId = 1001;
		Exposer exposer = seckillService.exportSeckillUrl(seckillId);
		if (exposer.isExposed()) {
			log.info("exposer = {}", exposer);
			long userPhone = 13520775685l;
			String md5 = exposer.getMd5();
			try {
				SeckillExecution seckillExecution = seckillService.executeSeckill(seckillId, userPhone, md5);
				log.info("seckillExecution = {}", seckillExecution);
			} catch (SeckillCloseException e1) {
				log.error(e1.getMessage());
			} catch (RepeatKillException e2) {
				log.error(e2.getMessage());
			}
		} else {
			log.info("exposer = {}", exposer);
		}
	}

	@Test
	public void testKillByProcedure() {
		long seckillId = 1001;
		long userPhone = 13520775645l;
		Exposer exposer = seckillService.exportSeckillUrl(seckillId);
		log.info("exposer = {}", exposer);
		if(exposer.isExposed()){
			SeckillExecution execution = seckillService.executeSeckillByProcedure(seckillId, userPhone, exposer.getMd5());
			log.info("seckillExecution = {}", execution);
		}
	}
	
}
