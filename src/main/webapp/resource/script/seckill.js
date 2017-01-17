//存放主要交互逻辑代码
//模块化
var seckill = {
	// 封装秒杀相关的ajax的url
	URL : {
		now:function(){
			return ctx+"/seckill/time/now";
		},
		exposer:function(seckillId){
			return ctx+"/seckill/"+seckillId+"/exposer";
		},
		killUrl:function(seckillId,md5){
			return ctx+"/seckill/"+seckillId+"/"+md5+"/execution";
		}
	},
	
	handleSeckill : function(seckillId,seckillBox){
		//处理秒杀逻辑
		seckillBox.hide().html('<button type="button" class="btn btn-primary btn-lg" id="killBtn">开始秒杀</button>').show();
		$.post(seckill.URL.exposer(seckillId),{},function(result){
			if(result && result['success']){
				var exposer = result['data'];
				if(exposer['exposed']){
					//秒杀已开启
					//获取秒杀地址
					var md5 = exposer['md5'];
					var killUrl = seckill.URL.killUrl(seckillId, md5);
					console.log("killUrl="+killUrl);
					var btn = $("#killBtn");
					//绑定一次点击事件
					$(btn).one('click',function(){
						//绑定执行秒杀请求
						//禁止
						$(this).addClass('disabled');
						//发送秒杀请求
						$.post(killUrl,{},function(result){
							if(result && result['success']){
								var killResult = result['data'];
								var state = killResult['state'];
								var stateInfo = killResult['stateInfo'];
								//显示秒杀结果
								console.log("stateInfo="+stateInfo);
								var label = '<span class="label label-success">'+stateInfo+'</span>';
								seckillBox.html(label);
							}
						});
						seckillBox.show();
					});
				}else{
					//秒杀未开启
					var now = exposer['now'];
					var start = exposer['start'];
					var end = exposer['end'];
					seckill.countdown(seckillId, nowTime, startTime, endTime);
				}
			}else{
				console.log("result="+result);
			}
			
		});
	},
	// 验证手机号
	validatePhone : function(phone) {
		if (phone && phone.length == 11 && !isNaN(phone)) {
			return true;
		} else {
			return false;
		}
	},
	countdown:function(seckillId,nowTime,startTime,endTime){
		//时间判断，开始结束
		var seckillBox = $("#seckill-box");
		if(nowTime>endTime){
			//秒杀结束
			seckillBox.html("秒杀已结束！");
		}else if(nowTime<startTime){
			//秒杀未开始
			var killTime = new Date(startTime+1000);
			seckillBox.countdown(killTime,function(event){
				var fmt = event.strftime('秒杀倒计时：%D天  %H时   %M分   %S秒');
				seckillBox.html(fmt);
				/** 时间完成后回调逻辑**/
			}).on('finish.countdown',function(){
				//获取秒杀地址
				seckill.handleSeckill(seckillId,seckillBox);
			});
		}else{
			//秒杀开始
			seckill.handleSeckill(seckillId,seckillBox);
		}
	},
	// 详情页秒杀逻辑
	detail : {
		// 详情页初始化
		init : function(params) {
			// 手机登录，验证，计时
			// 规划我们的交互流程
			// 在cookie中查找手机号
			var killPhone = $.cookie('killPhone');
			// 验证手机号
			if(!seckill.validatePhone(killPhone)){
				//去绑定手机号
				var myModal = $('#myModal');
				myModal.modal({
					show:true,
					keyboard: false,
					backdrop:'static'
				});
				$("#killPhonebtn").click(function(){
					var inputPhone = $("#killPhoneKey").val();
					if(seckill.validatePhone(inputPhone)){
						//验证通过，刷新页面
						$.cookie('killPhone',inputPhone,{expires:7,path:'/seckill'});
						window.location.reload();
					}else{
						$("#killPhoneMessage").hide().html('<label class="label label-danger">手机号错误<label>').show(500);
					}
				});
			}else{
				//已经登录
				//计时
				var startTime = params['startTime'];
				var endTime = params['endTime'];
				var seckillId = params['seckillId'];
				$.get(seckill.URL.now(),{},function(result){
					console.log("result="+result);
					if(result && result['success']){
						var nowTime = result['data'];
						//时间判断，计时交互
						console.log("nowTime="+nowTime);
						seckill.countdown(seckillId, nowTime, startTime, endTime);
					}else{
						console.log("result="+result);
					}
				});
			}
		}
	}
}