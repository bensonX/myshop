$.fn.ProvinceCity = function(settings){
	settings=$.extend({
		dprovince:"所在省份",
		dcity:"所在城市",
		lcity:"所在区"
	},settings);
	var _self = this;
	_self.data("province",[settings.dprovince, settings.dprovince]);
	_self.data("city1",[settings.dcity,settings.dcity]);
	_self.data("city2",[settings.lcity,settings.lcity]);
	_self.append("<select id='province' name='province'></select>");
	_self.append("<select id='city' name='city'></select>");
	_self.append("<select id='lcity' name='lcity'></select>");
	var $sel1 = _self.find("select").eq(0);
	var $sel2 = _self.find("select").eq(1);
	var $sel3 = _self.find("select").eq(2);
	var proindex=jQuery.inArray(settings.dprovince,GP);
	if(proindex!=-1){
		var dcityindex=jQuery.inArray(settings.dcity,GT[proindex]);
		if(dcityindex==-1) dcityindex=0;
		var lcityindex=jQuery.inArray(settings.lcity,GC[proindex][dcityindex]); 
		if(lcityindex==-1) lcityindex=0;
	}else{
		dcityindex=0;
		lcityindex=0;
	}
	
	if(_self.data("province")){
		$sel1.append("<option value='"+_self.data("province")[1]+"'>"+_self.data("province")[0]+"</option>");
	}
	$.each(GP, function(index,data){
		if(index==proindex){
			$sel1.append("<option value='"+data+"' selected='selected'>"+data+"</option>");
		}else{
			$sel1.append("<option value='"+data+"'>"+data+"</option>");
		}
	});
	if(_self.data("city1")){
		$sel2.append("<option value='"+_self.data("city1")[1]+"'>"+_self.data("city1")[0]+"</option>");
	}
	if(_self.data("city2")){
		$sel3.append("<option value='"+_self.data("city2")[1]+"'>"+_self.data("city2")[0]+"</option>");
	}
	var index1 = "" ;
	$sel1.change(function(){
		$sel2[0].options.length=0;
		$sel3[0].options.length=0;
		index1 = this.selectedIndex;
		if(index1==0){
			if(_self.data("city1")){
				$sel2.append("<option value='"+_self.data("city1")[1]+"'>"+_self.data("city1")[0]+"</option>");
			}
			if(_self.data("city2")){
				$sel3.append("<option value='"+_self.data("city2")[1]+"'>"+_self.data("city2")[0]+"</option>");
			}
		}else{
			$.each( GT[index1-1] , function(index,data){
				if(dcityindex==index){
					$sel2.append("<option value='"+data+"' selected='selected'>"+data+"</option>");
				}else{
					$sel2.append("<option value='"+data+"'>"+data+"</option>");
				}
			});
			$.each( GC[index1-1][dcityindex] , function(index,data){
				if(lcityindex==index){
					$sel3.append("<option value='"+data+"' selected='selected'>"+data+"</option>");
				}else{
					$sel3.append("<option value='"+data+"'>"+data+"</option>");
				}
			})
		}
	}).change();
	var index2 = "" ;
	$sel2.change(function(){
		$sel3[0].options.length=0;
		index2 = this.selectedIndex;
		$.each( GC[index1-1][index2] , function(index,data){
			$sel3.append("<option value='"+data+"'>"+data+"</option>")
		})
	});
	return _self;
};