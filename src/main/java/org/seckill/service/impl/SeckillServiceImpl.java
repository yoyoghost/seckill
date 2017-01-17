package org.seckill.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.seckill.dao.SeckillDao;
import org.seckill.dao.SuccessKilledDao;
import org.seckill.dao.cache.RedisDao;
import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.entity.SuccessKilled;
import org.seckill.enums.SeckillStatEnum;
import org.seckill.exception.RepeatKillException;
import org.seckill.exception.SeckillCloseException;
import org.seckill.exception.SeckillException;
import org.seckill.service.SeckillService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

@Service
public class SeckillServiceImpl implements SeckillService {

	private Logger log = LoggerFactory.getLogger(SeckillServiceImpl.class);

	@Autowired
	private SeckillDao seckillDao;

	@Autowired
	private RedisDao redisDao;

	@Autowired
	private SuccessKilledDao successKilledDao;

	private final String salt = "#$%^*()_+_(*^%^&*)gHJKLLJHGT%^&*()HJKM_*^%";

	public List<Seckill> getSeckillList() {
		return seckillDao.queryAll(0, 10);
	}

	public Seckill queryById(long seckillId) {
		return seckillDao.queryById(seckillId);
	}

	public Exposer exportSeckillUrl(long seckillId) {

		// 首先查询缓存操作
		// 没有再去查询数据库，然后将查询出来的数据写入缓存
		Seckill seckill = redisDao.getSeckill(seckillId);
		if (null == seckill) {
			seckill = seckillDao.queryById(seckillId);
			if (null == seckill) {
				return new Exposer(false, seckillId);
			} else {
				redisDao.putSeckill(seckill);
			}
		}

		Date startTime = seckill.getStartTime();
		Date endTime = seckill.getEndTime();
		Date nowTime = new Date();

		if (nowTime.getTime() < startTime.getTime() || nowTime.getTime() > endTime.getTime()) {
			return new Exposer(false, seckillId, nowTime.getTime(), startTime.getTime(), endTime.getTime());
		}
		String md5 = getMD5(seckillId);
		return new Exposer(true, md5, seckillId);
	}

	private String getMD5(long seckillId) {
		String base = seckillId + "/" + salt;
		String md5 = DigestUtils.md5DigestAsHex(base.getBytes());
		return md5;
	}

	@Transactional
	public SeckillExecution executeSeckill(long seckillId, long userPhone, String md5)
			throws SeckillException, RepeatKillException, SeckillCloseException {

		if (StringUtils.isEmpty(md5) || !StringUtils.equals(md5, getMD5(seckillId))) {
			throw new SeckillException("seckill data rewrite");
		}

		Date nowTime = new Date();

		try {
			int insertCount = successKilledDao.insertSuccessKilled(seckillId, userPhone);
			if (insertCount <= 0) {
				throw new RepeatKillException("seckill repeated");
			} else {
				int reduceNumber = seckillDao.reduceNumber(seckillId, nowTime);
				if (reduceNumber <= 0) {
					throw new SeckillCloseException("seckill is closed");
				} else {
					SuccessKilled successKille = successKilledDao.queryByIdWithSeckill(seckillId, userPhone);
					return new SeckillExecution(seckillId, SeckillStatEnum.SUCCESS, successKille);
				}
			}
		} catch (SeckillCloseException e1) {
			throw e1;
		} catch (RepeatKillException e2) {
			throw e2;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw new SeckillException("seckill inner exception" + e.getMessage());
		}
	}

	public SeckillExecution executeSeckillByProcedure(long seckillId, long userPhone, String md5) {

		if (StringUtils.isEmpty(md5) || !StringUtils.equals(md5, getMD5(seckillId))) {
			return new SeckillExecution(seckillId, SeckillStatEnum.DATA_REWRITE);
		}
		Date killTime = new Date();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("killTime", killTime);
		param.put("seckillId", seckillId);
		param.put("userPhone", userPhone);
		param.put("result", null);
		try {
			seckillDao.killByProcedure(param);
			int result = MapUtils.getInteger(param, "result", -2);
			log.info("result = {}", result);
			if (result == 1) {
				SuccessKilled successKille = successKilledDao.queryByIdWithSeckill(seckillId, userPhone);
				return new SeckillExecution(seckillId, SeckillStatEnum.SUCCESS, successKille);
			} else {
				return new SeckillExecution(seckillId, SeckillStatEnum.stateOf(result));
			}
		} catch (Exception e) {
			return new SeckillExecution(seckillId, SeckillStatEnum.INNER_ERROR);
		}
	}

}
