<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="solar" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O>
<![CDATA[2020-04-06]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[


/*
光伏发电查询
*/


SELECT DISTINCT 
	 dss1.date
	,round(seg0.so_td,2) so_td  -- 光伏日上网电量
	,round(seg1.so_mtd,2) so_mtd -- MTD上网电量
	,round(seg2.so_ytd,2) so_ytd -- YTD上网电量
	,round(seg3.day_load_rate,4) day_load_rate -- 日负荷率
	,round(seg4.month_load_rate,4) month_load_rate -- 月负荷率
	,round(seg5.year_load_rate,4) year_load_rate -- 年负荷率
	,round(seg6.day_avai_rate,4) day_avai_rate -- 日设备可用率
	,round(seg7.month_avai_rate,4) month_avai_rate -- 月设备可用率
	,round(seg8.year_avai_rate,4)  year_avai_rate -- 年设备可用率
	,round(seg9.day_avai_hours,2) day_avai_hours -- 日利用小时数
	,round(seg10.month_avai_hours,2) month_avai_hours  -- 利用小时数 MTD
	,round(seg11.year_avai_hours,2) year_avai_hours -- 月利用小时数 YTD 

FROM dwa_solar_site_1d dss1
LEFT JOIN (
	SELECT 
		 date data_d_fmt
 		,SUM(production_active/1000) so_td  -- 日上网电量
	FROM dwa_solar_site_1d 
	WHERE date = '${para_date}'
	GROUP BY data_d_fmt 
) seg0 ON dss1.date = seg0.data_d_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
 		,SUM(production_active/1000) so_mtd  -- MTD上网电量
	FROM dwa_solar_site_1d 
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt 
) seg1 ON date_format(dss1.date,'%Y-%m') = seg1.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
 		,SUM(production_active/1000) so_ytd  -- YTD上网电量
	FROM dwa_solar_site_1d 
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg2 ON date_format(dss1.date,'%Y') = seg2.data_y_fmt 

LEFT JOIN (
	SELECT 
		 dsse1.date
		,CASE
		 WHEN sun_mul_cap = 0 THEN 0
		 ELSE IFNULL(sum(production),0)/ sun_mul_cap 
		 END day_load_rate -- 日负荷率
	FROM dwa_solar_device_1d  dsse1
	LEFT JOIN (
			SELECT 
				 dssi1.date
				,IFNULL(sum(dssi1.sun_hour*1000*dss.capacity),0) sun_mul_cap
			FROM dwa_solar_site_1d dssi1
			LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
			WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
			AND date <= '${para_date}'
			GROUP BY dssi1.date 
	) seg3_1 ON dsse1.date = seg3_1.date 
	GROUP BY date 
) seg3 ON seg3.date =  dss1.date
LEFT JOIN (
	SELECT DISTINCT 
		 date_format(dsse1.date,'%Y-%m') data_m_fmt
		,CASE
		 WHEN sun_mul_cap = 0 THEN 0
		 ELSE IFNULL(sum(production),0)/ sun_mul_cap 
		 END month_load_rate -- 月负荷率
	FROM dwa_solar_device_1d  dsse1
	LEFT JOIN (
			SELECT 
				 date_format(dssi1.date,'%Y-%m') data_m_fmt 
				,IFNULL(sum(dssi1.sun_hour*1000*dss.capacity),0) sun_mul_cap
			FROM dwa_solar_site_1d dssi1
			LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
			WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
			AND date <= '${para_date}'
			GROUP BY data_m_fmt
	) seg4_1 ON  date_format(dsse1.date,'%Y-%m') = seg4_1.data_m_fmt 
	GROUP BY data_m_fmt  
) seg4 ON seg4.data_m_fmt =  date_format(dss1.date,'%Y-%m') 
LEFT JOIN (
	SELECT DISTINCT 
		 date_format(dsse1.date,'%Y') data_y_fmt
		,CASE
		 WHEN sun_mul_cap = 0 THEN 0
		 ELSE IFNULL(sum(production),0)/ sun_mul_cap 
		 END year_load_rate -- 年负荷率
	FROM dwa_solar_device_1d  dsse1
	LEFT JOIN (
			SELECT 
				 date_format(dssi1.date,'%Y') data_y_fmt 
				,IFNULL(sum(dssi1.sun_hour*1000*dss.capacity),0) sun_mul_cap
			FROM dwa_solar_site_1d dssi1
			LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
			WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
			AND date <= '${para_date}'
			GROUP BY data_y_fmt
	) seg5_1 ON  date_format(dsse1.date,'%Y') = seg5_1.data_y_fmt 
	GROUP BY data_y_fmt  
) seg5 ON seg5.data_y_fmt =  date_format(dss1.date,'%Y') 

LEFT JOIN (
	SELECT 
		 dsse1.date
		,CASE
		 WHEN operavai_plus = 0 THEN 0
		 ELSE IFNULL(sum(operation_avai),0)/ operavai_plus 
		 END day_avai_rate -- 日设备可用率
	FROM dwa_solar_site_1d  dsse1
	LEFT JOIN (
			SELECT 
				 dssi1.date
				,IFNULL(sum(operation_avai+operation_not_avai),0) operavai_plus
			FROM dwa_solar_site_1d dssi1
			WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
			AND date <= '${para_date}'
			GROUP BY dssi1.date 
	) seg6_1 ON dsse1.date = seg6_1.date 
	GROUP BY date 
) seg6 ON seg6.date =  dss1.date

LEFT JOIN (
	SELECT 
		 date_format(dsse1.date,'%Y-%m') data_m_fmt 
		,CASE
		 WHEN operavai_plus = 0 THEN 0
		 ELSE IFNULL(sum(operation_avai),0)/ operavai_plus 
		 END month_avai_rate -- 月设备可用率
	FROM dwa_solar_site_1d  dsse1
	LEFT JOIN (
			SELECT 
				 date_format(dssi1.date,'%Y-%m') data_m_fmt  
				,IFNULL(sum(operation_avai+operation_not_avai),0) operavai_plus
			FROM dwa_solar_site_1d dssi1
			WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
			AND date <= '${para_date}'
			GROUP BY date_format(dssi1.date,'%Y-%m')
	) seg7_1 ON date_format(dsse1.date,'%Y-%m') = seg7_1.data_m_fmt 
	GROUP BY data_m_fmt  
) seg7 ON seg7.data_m_fmt = date_format(dss1.date,'%Y-%m') 

LEFT JOIN (
	SELECT 
		 date_format(dsse1.date,'%Y') data_y_fmt 
		,CASE
		 WHEN operavai_plus = 0 THEN 0
		 ELSE IFNULL(sum(operation_avai),0)/ operavai_plus 
		 END year_avai_rate -- 年设备可用率
	FROM dwa_solar_site_1d  dsse1
	LEFT JOIN (
			SELECT 
				 date_format(dssi1.date,'%Y') data_y_fmt  
				,IFNULL(sum(operation_avai+operation_not_avai),0) operavai_plus
			FROM dwa_solar_site_1d dssi1
			WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
			AND date <= '${para_date}'
			GROUP BY date_format(dssi1.date,'%Y')
	) seg8_1 ON date_format(dsse1.date,'%Y') = seg8_1.data_y_fmt 
	GROUP BY data_y_fmt  
) seg8 ON seg8.data_y_fmt =  date_format(dss1.date,'%Y') 


LEFT JOIN (
	SELECT 
		 dsse1.date
		,CASE
		 WHEN mul_cap = 0 THEN 0
		 ELSE IFNULL(sum(production),0)/ mul_cap 
		 END day_avai_hours -- 日利用小时数
	FROM dwa_solar_device_1d  dsse1
	LEFT JOIN (
			SELECT 
				 dssi1.date
				,IFNULL(sum(1000*dss.capacity),0) mul_cap
			FROM dwa_solar_site_1d dssi1
			LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
			WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
			AND date <= '${para_date}'
			GROUP BY dssi1.date 
	) seg9_1 ON dsse1.date = seg9_1.date 
	GROUP BY date 
) seg9 ON seg9.date =  dss1.date
LEFT JOIN (
			SELECT 
				 date_format(dsse1.date,'%Y-%m') data_m_fmt
				,CASE
				 WHEN mul_cap = 0 THEN 0
				 ELSE IFNULL(sum(production),0)/ mul_cap 
				 END month_avai_hours -- 利用小时数 MTD 
			FROM dwa_solar_device_1d  dsse1
			LEFT JOIN (
					SELECT 
						 dssi1.date
						,IFNULL(sum(1000*dss.capacity),0) mul_cap
					FROM dwa_solar_site_1d dssi1
					LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
					WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
					AND date <= '${para_date}'
					GROUP BY dssi1.date 
			) seg10_1 ON dsse1.date = seg10_1.date 
			GROUP BY date_format(dsse1.date,'%Y-%m')  
) seg10 ON seg10.data_m_fmt =  date_format(dss1.date,'%Y-%m') 
LEFT JOIN (
		SELECT 
			 date_format(dsse1.date,'%Y') data_y_fmt
			,CASE
			 WHEN mul_cap = 0 THEN 0
			 ELSE IFNULL(sum(production),0)/ mul_cap 
			 END year_avai_hours -- 利用小时数 YTD 
		FROM dwa_solar_device_1d  dsse1
		LEFT JOIN (
				SELECT 
					 dssi1.date
					,IFNULL(sum(1000*dss.capacity),0) mul_cap
				FROM dwa_solar_site_1d dssi1
				LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
				WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
				AND date <= '${para_date}'
				GROUP BY dssi1.date 
		) seg11_1 ON dsse1.date = seg11_1.date 
		GROUP BY date_format(dsse1.date,'%Y') 
) seg11 ON seg11.data_y_fmt =  date_format(dss1.date,'%Y') 

WHERE dss1.date = '${para_date}']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="solar_chart" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586275200000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[

SELECT DISTINCT 
	 date_format(dss1.date,'%d') date_day
	,seg9.day_avai_hours  -- 日利用小时数
	,seg12.ly_day_avai_hours  -- 利用小时数 去年同期

FROM dwa_solar_site_1d dss1
JOIN (
	SELECT 
		 dsse1.date
		,CASE
		 WHEN mul_cap = 0 THEN 0
		 ELSE IFNULL(sum(production),0)/ mul_cap 
		 END day_avai_hours -- 日利用小时数
	FROM dwa_solar_device_1d  dsse1
	LEFT JOIN (
			SELECT 
				 dssi1.date
				,IFNULL(sum(1000*dss.capacity),0) mul_cap
			FROM dwa_solar_site_1d dssi1
			LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
			WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
			AND date <= '${para_date}' 
			GROUP BY dssi1.date 
	) seg9_1 ON dsse1.date = seg9_1.date 
	GROUP BY date 
) seg9 ON seg9.date =  dss1.date
LEFT JOIN (
	SELECT 
		 dsse1.date
		,CASE
		 WHEN mul_cap = 0 THEN 0
		 ELSE IFNULL(sum(production),0)/ mul_cap 
		 END ly_day_avai_hours -- 日利用小时数  去年同期
	FROM dwa_solar_device_1d  dsse1
	JOIN (
			SELECT 
				 dssi1.date
				,IFNULL(sum(1000*dss.capacity),0) mul_cap
			FROM dwa_solar_site_1d dssi1
			LEFT JOIN dim_solar_site dss ON dssi1.site_id = dss.site_id 
			WHERE date >= concat(date_format(date_add('${para_date}',interval -1 year),'%Y-%m'),'-01')
			AND date <= date_add('${para_date}',interval -1 year)
			GROUP BY dssi1.date 
	) seg12_1 ON dsse1.date = seg12_1.date 
	GROUP BY date 
) seg12 ON date_add(seg12.date, interval +1 year)  =  dss1.date
WHERE dss1.date >= concat(date_format('${para_date}','%Y-%m'),'-01')
AND dss1.date <= '${para_date}' ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="rm" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586188800000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[
SELECT 

	 dws1.date
	,round(dws1.production_active/1000,2)  rmactive  -- 黑山日发电量
	,round(seg1.rmmtd,2) rmmtd -- MTD发电量
	,round(seg2.rmytd,2) rmytd -- YTD发电量 
	,round(IFNULL(dws1.ongrid_production, dws1.production_active/1000*0.97),2)  ongrid -- 上网电量 
	,round(seg3.rm_ogmtd,2) rm_ogmtd -- MTD上网电量
	,round(seg4.rm_ogytd,2) rm_ogytd -- YTD上网电量
	,round((dws1.production_active/1000)/(dws1.fullhour_capacity/1000),2)  available_time  -- 日利用小时数

	,round(seg5.avai_time_mtd,2) avai_time_mtd -- MTD日利用小时数
	,round(seg6.avai_time_ytd,2) avai_time_ytd -- YTD日利用小时数
	,round(dws1.wind_speed_avg,2) wind_speed_avg -- 日平均风速
	,round(dws1.production_active/(dws1.partial_performance_duration/3600+dws1.full_performance_duration/3600)/2000,2) daily_loadrate -- 日负荷率
	,round(dws1.wind_speed_avg_08,2) wind_speed_avg_08 -- 平均风速0-8h
	,round(dws1.wind_speed_avg_16,2) wind_speed_avg_16 -- 平均风速8-16h
	,round(dws1.wind_speed_avg_24,2) wind_speed_avg_24 -- 平均风速16-24h
	
FROM dwa_wind_site_1d dws1
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
 		,SUM(production_active/1000) rmmtd  -- MTD发电量
	FROM dwa_wind_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt
) seg1 ON date_format(dws1.date,'%Y-%m') = seg1.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
 		,SUM(production_active/1000) rmytd  -- YTD发电量
	FROM dwa_wind_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg2 ON date_format(dws1.date,'%Y') = seg2.data_y_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
 		,SUM(IFNULL(dws1.ongrid_production, dws1.production_active/1000*0.97)) rm_ogmtd  -- MTD上网电量
	FROM dwa_wind_site_1d dws1 
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt
) seg3 ON date_format(dws1.date,'%Y-%m') = seg3.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
 		,SUM(IFNULL(dws1.ongrid_production, dws1.production_active/1000*0.97)) rm_ogytd  -- YTD上网电量
	FROM dwa_wind_site_1d dws1 
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg4 ON date_format(dws1.date,'%Y') = seg4.data_y_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
 		,SUM((dws1.production_active/1000)/(fullhour_capacity/1000))  avai_time_mtd  -- MTD日利用小时数
	FROM dwa_wind_site_1d dws1 
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt
) seg5 ON date_format(dws1.date,'%Y-%m') = seg5.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
 		,SUM((dws1.production_active/1000)/(fullhour_capacity/1000))  avai_time_ytd  -- YTD日利用小时数
	FROM dwa_wind_site_1d dws1 
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg6 ON date_format(dws1.date,'%Y') = seg6.data_y_fmt

WHERE dws1.date = '${para_date}'
ORDER BY date ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="rm_chart" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1588003200000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[
SELECT 

	 date_format(dws1.date, '%d') day_date
	
	,(dws1.production_active/1000)/(dws1.fullhour_capacity/1000)  available_time  -- 日利用小时数
	,seg7.ly_available_time  -- 同期_日利用小时数
	
	
FROM dwa_wind_site_1d dws1
LEFT JOIN (
	SELECT   date
			,(dws1.production_active/1000)/(fullhour_capacity/1000)  ly_available_time  -- 同期_日利用小时数
	FROM dwa_wind_site_1d dws1 
	WHERE date >= concat(date_format(date_add('${para_date}',interval -1 year),'%Y-%m'),'-01')
	AND date <= date_add('${para_date}',interval -1 year)
) seg7 ON  date_add(seg7.date, interval +1 year) = dws1.date 
WHERE dws1.date >= concat(date_format('${para_date}','%Y-%m'),'-01')
AND dws1.date <= '${para_date}' ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="d3" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586102400000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[


/*
D3发电计算

*/


SELECT 
	 dgs1.date
	,ROUND(dgs1.production_active,2) d3day -- 日发电量
	,ROUND(seg1.d3mtd,2) d3mtd -- MTD发电量
	,ROUND(seg2.d3ytd,2) d3ytd -- YTD发电量
	,ROUND(dgs1.year_annual_avail_loss,2) year_annual_avail_loss -- 年可用容量损失
	,ROUND(dgs1.year_avail_ratio,4) year_avail_ratio -- 年设备可用率
	,CASE
	 WHEN sum_caprunning = 0 THEN 0 
	 ELSE ROUND(dgs1.production_active/sum_caprunning,4) 
     END lodarate -- 日负荷率
	,dgs1.actual_heat_rate  -- 累积实际热耗
	,dgs1.contracted_heat_rate -- 累积协定热耗
	,CASE
	 WHEN IFNULL(dgs1.contracted_heat_rate,0) = 0 THEN 0  
	 ELSE ROUND((dgs1.actual_heat_rate - dgs1.contracted_heat_rate)/dgs1.contracted_heat_rate,4)
	 END heat_rate_bias -- 累积热耗偏差率


FROM dwa_gas_site_1d dgs1
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
 		,SUM(production_active) d3mtd  -- MTD发电量
	FROM dwa_gas_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt
) seg1 ON date_format(dgs1.date,'%Y-%m') = seg1.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
 		,SUM(production_active) d3ytd -- YTD发电量
	FROM dwa_gas_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg2 ON date_format(dgs1.date,'%Y') = seg2.data_y_fmt
LEFT JOIN (
	SELECT 
		 dgd1.date
		,IFNULL(sum(dgd.capacity * dgd1.running_hours) ,0) sum_caprunning -- ∑(设备额定容量*设备运行小时)
	FROM dim_gas_device dgd 
	LEFT JOIN dwa_gas_device_1d  dgd1
	ON dgd.device_id = dgd1.device_id
	GROUP BY   dgd1.date
) seg3 ON seg3.date = dgs1.date 
WHERE dgs1.date = '${para_date}'
ORDER BY date ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="d3_chart" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586188800000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[

SELECT 
	 date_format(dgs1.date, '%d') day_date
	,ROUND(dgs1.actual_heat_rate,2) actual_heat_rate  -- 累积实际热耗
	,ROUND(dgs1.contracted_heat_rate,2) contracted_heat_rate -- 累积协定热耗
FROM dwa_gas_site_1d dgs1
WHERE dgs1.date >= concat(date_format('${para_date}','%Y-%m'),'-01')
AND dgs1.date <= '${para_date}'
ORDER BY date ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="dic_d3_min_value" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586102400000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[
SELECT MIN(ROUND(dgs1.actual_heat_rate)) actual_heat_rate FROM dwa_gas_site_1d dgs1 WHERE dgs1.date >= concat(date_format('${para_date}','%Y-%m'),'-01') AND dgs1.date <= '${para_date}']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="sepm" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586102400000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[







SELECT 
 dgs1.date
,IFNULL(ROUND(dgs1.production_active,2),0)+IFNULL(seg3.rmday,0)+IFNULL(seg4.so_td,0) sepm_day -- sepm 日发电量
,IFNULL(ROUND(seg1.d3mtd,2),0) + IFNULL(seg3.rmmtd,0) + IFNULL(seg4.so_mtd,0)  sepm_mtd -- sepm 月发电量
,IFNULL(ROUND(seg2.d3ytd,2),0) + IFNULL(seg3.rmytd,0) + IFNULL(seg4.so_ytd,0)   sepm_ytd -- sepm 年发电量
,IFNULL(m_d3_bgt,0) + IFNULL(m_rm_bgt,0) + IFNULL(m_solar_bgt,0)  sepm_bgt_mtd -- 月计划
,IFNULL(y_d3_bgt,0) + IFNULL(y_rm_bgt,0) + IFNULL(y_solar_bgt,0) sepm_bgt_ytd -- 年计划
		
FROM dwa_gas_site_1d dgs1
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
 		,SUM(production_active) d3mtd  -- d3_MTD发电量
	FROM dwa_gas_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt
) seg1 ON date_format(dgs1.date,'%Y-%m') = seg1.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
 		,SUM(production_active) d3ytd -- d3_YTD发电量
	FROM dwa_gas_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg2 ON date_format(dgs1.date,'%Y') = seg2.data_y_fmt
LEFT JOIN ( 
	SELECT 

		 dws1.date
		,ROUND(dws1.production_active/1000,2)  rmday -- 黑山日发电量
		,ROUND(seg1.rmmtd,2) rmmtd -- 黑山_MTD发电量
		,ROUND(seg2.rmytd,2) rmytd -- 黑山_YTD发电量 
		
	FROM dwa_wind_site_1d dws1
	LEFT JOIN (
		SELECT 
			 date_format(date,'%Y-%m') data_m_fmt
			,SUM(production_active/1000) rmmtd  -- MTD发电量
		FROM dwa_wind_site_1d
		WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
		AND date <= '${para_date}'
		GROUP BY data_m_fmt
	) seg1 ON date_format(dws1.date,'%Y-%m') = seg1.data_m_fmt
	LEFT JOIN (
		SELECT 
			 date_format(date,'%Y') data_y_fmt
			,SUM(production_active/1000) rmytd  -- YTD发电量
		FROM dwa_wind_site_1d
		WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
		AND date <= '${para_date}'
		GROUP BY data_y_fmt
	) seg2 ON date_format(dws1.date,'%Y') = seg2.data_y_fmt
) seg3 ON seg3.date = dgs1.date 
LEFT JOIN (

	SELECT DISTINCT 
		 dss1.date
		,ROUND(seg0.so_td,2) so_td  -- 光伏日上网电量
		,ROUND(seg1.so_mtd,2) so_mtd -- 光伏_MTD上网电量
		,ROUND(seg2.so_ytd,2) so_ytd -- 光伏_YTD上网电量
	FROM dwa_solar_site_1d dss1
	LEFT JOIN (
		SELECT 
			 date data_d_fmt
			,SUM(production_active/1000) so_td  -- 日上网电量
		FROM dwa_solar_site_1d 
		WHERE date <= '${para_date}'
		GROUP BY data_d_fmt 
	) seg0 ON dss1.date = seg0.data_d_fmt
	LEFT JOIN (
		SELECT 
			 date_format(date,'%Y-%m') data_m_fmt
			,SUM(production_active/1000) so_mtd  -- 光伏_MTD上网电量
		FROM dwa_solar_site_1d 
		WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
		AND date <= '${para_date}'
		GROUP BY data_m_fmt 
	) seg1 ON date_format(dss1.date,'%Y-%m') = seg1.data_m_fmt
	LEFT JOIN (
		SELECT 
			 date_format(date,'%Y') data_y_fmt
			,SUM(production_active/1000) so_ytd  -- 光伏_YTD上网电量
		FROM dwa_solar_site_1d 
		WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
		AND date <= '${para_date}'
		GROUP BY data_y_fmt
	) seg2 ON date_format(dss1.date,'%Y') = seg2.data_y_fmt 
) seg4 ON seg4.date = dgs1.date 
LEFT JOIN (
	
	SELECT  
		 seg1.date_str
		,m_d3_bgt  -- d3月计划
		,y_d3_bgt -- d3年计划
		,m_rm_bgt  -- 黑山月计划
		,y_rm_bgt -- 黑山年计划
		,m_solar_bgt  -- 光伏月计划
		,y_solar_bgt -- 光伏年计划
	FROM ( 
		SELECT 
			 date_str
			,SUM(budget_production) m_d3_bgt  -- d3月计划
			,y_d3_bgt -- d3年计划
		FROM dim_gas_site_month_attr dgsm 
		LEFT JOIN (
			SELECT 
				 SUBSTR(date_str, 1,4) date_ytd
				,ROUND(SUM(budget_production),2) y_d3_bgt
			FROM dim_gas_site_month_attr dgsm 
			WHERE end_date IS NULL 
			GROUP BY date_ytd
		) seg ON SUBSTR(dgsm.date_str, 1,4) = seg.date_ytd
		WHERE end_date IS NULL 
		GROUP BY date_str, y_d3_bgt 
	) seg1 
	LEFT JOIN ( 
		SELECT 
			 date_str
			,SUM(budget_production) m_rm_bgt  -- 黑山月计划
			,y_rm_bgt -- 黑山年计划
		FROM dim_wind_site_month_attr dwsma 
		LEFT JOIN (
			SELECT 
				 SUBSTR(date_str, 1,4) date_ytd
				,ROUND(SUM(budget_production),2) y_rm_bgt
			FROM dim_wind_site_month_attr dwsma 
			WHERE end_date IS NULL 
			GROUP BY date_ytd
		) seg ON SUBSTR(dwsma.date_str, 1,4) = seg.date_ytd
		WHERE end_date IS NULL 
		GROUP BY date_str, y_rm_bgt 
	) seg2 ON seg1.date_str = seg2.date_str
	LEFT JOIN ( 
		SELECT  
			 date_str
			,SUM(budget_production) m_solar_bgt  -- 光伏月计划
			,y_solar_bgt -- 光伏年计划
		FROM dim_solar_site_month_attr dssma
		LEFT JOIN (
			SELECT 
				 SUBSTR(date_str, 1,4) date_ytd
				,ROUND(SUM(budget_production),2) y_solar_bgt
			FROM dim_solar_site_month_attr dssma 
			WHERE end_date IS NULL 
			GROUP BY date_ytd
		) seg ON SUBSTR(dssma.date_str, 1,4) = seg.date_ytd
		WHERE end_date IS NULL 
		GROUP BY date_str, y_solar_bgt 
	) seg3 ON seg1.date_str = seg3.date_str
	WHERE seg1.date_str = date_format('${para_date}','%Y-%m')
 ) seg5 ON seg5.date_str = date_format(dgs1.date,'%Y-%m')

WHERE dgs1.date = '${para_date}'
ORDER BY dgs1.date ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="sepm_fr_chart" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586102400000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[
SELECT 
	 dgs1.date
	,"D3" potype
	,IFNULL(ROUND(seg1.d3mtd,2),0) d3mtd  -- mtd发电量
	,seg3.m_d3_bgt  -- 月计划值
	,IF(seg3.m_d3_bgt = 0, 0, ROUND(seg1.d3mtd/seg3.m_d3_bgt,4)) m_fr -- 月达成率
	
	,IFNULL(ROUND(seg2.d3ytd,2),0) d3ytd  -- ytd发电量
	,seg3.y_d3_bgt -- 年计划值
	,IF(seg3.y_d3_bgt = 0, 0, ROUND(seg2.d3ytd/seg3.y_d3_bgt,4)) y_fr -- 年达成率


FROM dwa_gas_site_1d dgs1
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
 		,SUM(production_active) d3mtd  -- d3_MTD发电量
	FROM dwa_gas_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt
) seg1 ON date_format(dgs1.date,'%Y-%m') = seg1.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
 		,SUM(production_active) d3ytd -- d3_YTD发电量
	FROM dwa_gas_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg2 ON date_format(dgs1.date,'%Y') = seg2.data_y_fmt
LEFT JOIN ( 
		SELECT 
			 date_str
			,IFNULL(SUM(budget_production),0) m_d3_bgt  -- d3月计划
			,y_d3_bgt -- d3年计划
		FROM dim_gas_site_month_attr dgsm 
		LEFT JOIN (
			SELECT 
				 SUBSTR(date_str, 1,4) date_ytd
				,IFNULL(ROUND(SUM(budget_production),2),0) y_d3_bgt
			FROM dim_gas_site_month_attr dgsm 
			WHERE end_date IS NULL 
			GROUP BY date_ytd
		) seg ON SUBSTR(dgsm.date_str, 1,4) = seg.date_ytd
		WHERE end_date IS NULL 
		GROUP BY date_str, y_d3_bgt 
) seg3 ON seg3.date_str = date_format(dgs1.date,'%Y-%m') 
WHERE dgs1.date= '${para_date}'

UNION ALL 

 
SELECT 

	 dws1.date
	,"风电" potype
	,seg1.rmmtd rmmtd -- 黑山_MTD发电量
	,seg3.m_rm_bgt  -- 黑山月计划值
	,IF(seg3.m_rm_bgt = 0, 0, ROUND(seg1.rmmtd/seg3.m_rm_bgt,4)) m_fr -- 月达成率
	,seg2.rmytd rmytd -- 黑山_YTD发电量 
	,seg3.y_rm_bgt -- 黑山年计划值
	,IF(seg3.y_rm_bgt  = 0, 0 , ROUND(seg2.rmytd/y_rm_bgt ,4)) y_fr -- 年达成率
	
FROM dwa_wind_site_1d dws1
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
		,IFNULL(SUM(production_active/1000),0) rmmtd  -- MTD发电量
	FROM dwa_wind_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt
) seg1 ON date_format(dws1.date,'%Y-%m') = seg1.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
		,IFNULL(SUM(production_active/1000),0) rmytd  -- YTD发电量
	FROM dwa_wind_site_1d
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg2 ON date_format(dws1.date,'%Y') = seg2.data_y_fmt

LEFT JOIN (
	 
	SELECT 
		 date_str
		,IFNULL(SUM(budget_production),0) m_rm_bgt  -- 黑山月计划
		,y_rm_bgt -- 黑山年计划
	FROM dim_wind_site_month_attr dwsma 
	LEFT JOIN (
		SELECT 
			 SUBSTR(date_str, 1,4) date_ytd
			,IFNULL(ROUND(SUM(budget_production),2),0) y_rm_bgt
		FROM dim_wind_site_month_attr dwsma 
		WHERE end_date IS NULL 
		GROUP BY date_ytd
	) seg ON SUBSTR(dwsma.date_str, 1,4) = seg.date_ytd
	WHERE end_date IS NULL 
	GROUP BY date_str, y_rm_bgt 
) seg3 ON seg3.date_str = date_format(dws1.date,'%Y-%m')
WHERE dws1.date= '${para_date}'

UNION ALL 


SELECT  DISTINCT 
	 dss1.date
	,"光伏" potype
	,seg1.so_mtd -- 光伏_MTD上网电量
	,seg3.m_solar_bgt  -- 光伏月计划值
	,IF(seg3.m_solar_bgt = 0, 0, ROUND(seg1.so_mtd/seg3.m_solar_bgt,4)) m_fr -- 月达成率
	,seg2.so_ytd -- 光伏_YTD上网电量
	,seg3.y_solar_bgt  -- 光伏年计划值
	,IF(seg3.y_solar_bgt = 0, 0 , ROUND(seg2.so_ytd/seg3.y_solar_bgt ,4)) y_fr -- 年达成率
FROM dwa_solar_site_1d dss1
LEFT JOIN (
	SELECT 
		 date data_d_fmt
		,SUM(production_active/1000) so_td  -- 日上网电量
	FROM dwa_solar_site_1d 
	WHERE date <= '${para_date}'
	GROUP BY data_d_fmt 
) seg0 ON dss1.date = seg0.data_d_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y-%m') data_m_fmt
		,IFNULL(SUM(production_active/1000),0) so_mtd  -- 光伏_MTD上网电量
	FROM dwa_solar_site_1d 
	WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
	AND date <= '${para_date}'
	GROUP BY data_m_fmt 
) seg1 ON date_format(dss1.date,'%Y-%m') = seg1.data_m_fmt
LEFT JOIN (
	SELECT 
		 date_format(date,'%Y') data_y_fmt
		,IFNULL(SUM(production_active/1000),0) so_ytd  -- 光伏_YTD上网电量
	FROM dwa_solar_site_1d 
	WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
	AND date <= '${para_date}'
	GROUP BY data_y_fmt
) seg2 ON date_format(dss1.date,'%Y') = seg2.data_y_fmt 
LEFT JOIN (
	 
	SELECT  
		 date_str
		,IFNULL(SUM(budget_production),0) m_solar_bgt  -- 光伏月计划
		,y_solar_bgt -- 光伏年计划
	FROM dim_solar_site_month_attr dssma
	LEFT JOIN (
		SELECT 
			 SUBSTR(date_str, 1,4) date_ytd
			,IFNULL(ROUND(SUM(budget_production),2),0) y_solar_bgt
		FROM dim_solar_site_month_attr dssma 
		WHERE end_date IS NULL 
		GROUP BY date_ytd
	) seg ON SUBSTR(dssma.date_str, 1,4) = seg.date_ytd
	WHERE end_date IS NULL 
	GROUP BY date_str, y_solar_bgt 
) seg3 ON seg3.date_str = date_format(dss1.date,'%Y-%m')
WHERE dss1.date= '${para_date}'


UNION ALL 

SELECT 
	 sseg.date
	,sseg.potype
	,sseg.sepm_mtd -- mtd发电量
	,sseg.sepm_bgt_mtd -- 月计划值
	,IF(sseg.sepm_bgt_mtd = 0, 0, ROUND(sseg.sepm_mtd/sseg.sepm_bgt_mtd,4)) m_fr -- 月达成率
	,sseg.sepm_ytd  -- ytd发电量
	,sseg.sepm_bgt_ytd  -- 年计划值
	,IF(sseg.sepm_bgt_ytd  = 0, 0,ROUND(sseg.sepm_ytd/sseg.sepm_bgt_ytd,2)) m_fr -- 年达成率
FROM ( 

	SELECT 
	 dgs1.date
	,"sepm" potype 
	,IFNULL(ROUND(seg1.d3mtd,2),0) + IFNULL(seg3.rmmtd,0) + IFNULL(seg4.so_mtd,0)  sepm_mtd -- sepm 月发电量
	,IFNULL(m_d3_bgt,0) + IFNULL(m_rm_bgt,0) + IFNULL(m_solar_bgt,0)  sepm_bgt_mtd -- 月计划
	,IFNULL(ROUND(seg2.d3ytd,2),0) + IFNULL(seg3.rmytd,0) + IFNULL(seg4.so_ytd,0)   sepm_ytd -- sepm 年发电量
	,IFNULL(y_d3_bgt,0) + IFNULL(y_rm_bgt,0) + IFNULL(y_solar_bgt,0) sepm_bgt_ytd -- 年计划
			
	FROM dwa_gas_site_1d dgs1
	LEFT JOIN (
		SELECT 
			 date_format(date,'%Y-%m') data_m_fmt
			,SUM(production_active) d3mtd  -- d3_MTD发电量
		FROM dwa_gas_site_1d
		WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
		AND date <= '${para_date}'
		GROUP BY data_m_fmt
	) seg1 ON date_format(dgs1.date,'%Y-%m') = seg1.data_m_fmt
	LEFT JOIN (
		SELECT 
			 date_format(date,'%Y') data_y_fmt
			,SUM(production_active) d3ytd -- d3_YTD发电量
		FROM dwa_gas_site_1d
		WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
		AND date <= '${para_date}'
		GROUP BY data_y_fmt
	) seg2 ON date_format(dgs1.date,'%Y') = seg2.data_y_fmt
	LEFT JOIN ( 
		SELECT 

			 dws1.date
			,ROUND(dws1.production_active/1000,2)  rmday -- 黑山日发电量
			,ROUND(seg1.rmmtd,2) rmmtd -- 黑山_MTD发电量
			,ROUND(seg2.rmytd,2) rmytd -- 黑山_YTD发电量 
			
		FROM dwa_wind_site_1d dws1
		LEFT JOIN (
			SELECT 
				 date_format(date,'%Y-%m') data_m_fmt
				,SUM(production_active/1000) rmmtd  -- MTD发电量
			FROM dwa_wind_site_1d
			WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
			AND date <= '${para_date}'
			GROUP BY data_m_fmt
		) seg1 ON date_format(dws1.date,'%Y-%m') = seg1.data_m_fmt
		LEFT JOIN (
			SELECT 
				 date_format(date,'%Y') data_y_fmt
				,SUM(production_active/1000) rmytd  -- YTD发电量
			FROM dwa_wind_site_1d
			WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
			AND date <= '${para_date}'
			GROUP BY data_y_fmt
		) seg2 ON date_format(dws1.date,'%Y') = seg2.data_y_fmt
	) seg3 ON seg3.date = dgs1.date 
	LEFT JOIN (

		SELECT DISTINCT 
			 dss1.date
			,ROUND(seg0.so_td,2) so_td  -- 光伏日上网电量
			,ROUND(seg1.so_mtd,2) so_mtd -- 光伏_MTD上网电量
			,ROUND(seg2.so_ytd,2) so_ytd -- 光伏_YTD上网电量
		FROM dwa_solar_site_1d dss1
		LEFT JOIN (
			SELECT 
				 date data_d_fmt
				,SUM(production_active/1000) so_td  -- 日上网电量
			FROM dwa_solar_site_1d 
			WHERE date <= '${para_date}'
			GROUP BY data_d_fmt 
		) seg0 ON dss1.date = seg0.data_d_fmt
		LEFT JOIN (
			SELECT 
				 date_format(date,'%Y-%m') data_m_fmt
				,SUM(production_active/1000) so_mtd  -- 光伏_MTD上网电量
			FROM dwa_solar_site_1d 
			WHERE date >= concat(date_format('${para_date}','%Y-%m'),'-01')
			AND date <= '${para_date}'
			GROUP BY data_m_fmt 
		) seg1 ON date_format(dss1.date,'%Y-%m') = seg1.data_m_fmt
		LEFT JOIN (
			SELECT 
				 date_format(date,'%Y') data_y_fmt
				,SUM(production_active/1000) so_ytd  -- 光伏_YTD上网电量
			FROM dwa_solar_site_1d 
			WHERE date >= concat(date_format('${para_date}','%Y'),'-01-01')
			AND date <= '${para_date}'
			GROUP BY data_y_fmt
		) seg2 ON date_format(dss1.date,'%Y') = seg2.data_y_fmt 
	) seg4 ON seg4.date = dgs1.date 
	LEFT JOIN (
		
		SELECT  
			 seg1.date_str
			,m_d3_bgt  -- d3月计划
			,y_d3_bgt -- d3年计划
			,m_rm_bgt  -- 黑山月计划
			,y_rm_bgt -- 黑山年计划
			,m_solar_bgt  -- 光伏月计划
			,y_solar_bgt -- 光伏年计划
		FROM ( 
			SELECT 
				 date_str
				,SUM(budget_production) m_d3_bgt  -- d3月计划
				,y_d3_bgt -- d3年计划
			FROM dim_gas_site_month_attr dgsm 
			LEFT JOIN (
				SELECT 
					 SUBSTR(date_str, 1,4) date_ytd
					,ROUND(SUM(budget_production),2) y_d3_bgt
				FROM dim_gas_site_month_attr dgsm 
				WHERE end_date IS NULL 
				GROUP BY date_ytd
			) seg ON SUBSTR(dgsm.date_str, 1,4) = seg.date_ytd
			WHERE end_date IS NULL 
			GROUP BY date_str, y_d3_bgt 
		) seg1 
		LEFT JOIN ( 
			SELECT 
				 date_str
				,SUM(budget_production) m_rm_bgt  -- 黑山月计划
				,y_rm_bgt -- 黑山年计划
			FROM dim_wind_site_month_attr dwsma 
			LEFT JOIN (
				SELECT 
					 SUBSTR(date_str, 1,4) date_ytd
					,ROUND(SUM(budget_production),2) y_rm_bgt
				FROM dim_wind_site_month_attr dwsma 
				WHERE end_date IS NULL 
				GROUP BY date_ytd
			) seg ON SUBSTR(dwsma.date_str, 1,4) = seg.date_ytd
			WHERE end_date IS NULL 
			GROUP BY date_str, y_rm_bgt 
		) seg2 ON seg1.date_str = seg2.date_str
		LEFT JOIN ( 
			SELECT  
				 date_str
				,SUM(budget_production) m_solar_bgt  -- 光伏月计划
				,y_solar_bgt -- 光伏年计划
			FROM dim_solar_site_month_attr dssma
			LEFT JOIN (
				SELECT 
					 SUBSTR(date_str, 1,4) date_ytd
					,ROUND(SUM(budget_production),2) y_solar_bgt
				FROM dim_solar_site_month_attr dssma 
				WHERE end_date IS NULL 
				GROUP BY date_ytd
			) seg ON SUBSTR(dssma.date_str, 1,4) = seg.date_ytd
			WHERE end_date IS NULL 
			GROUP BY date_str, y_solar_bgt 
		) seg3 ON seg1.date_str = seg3.date_str
		WHERE seg1.date_str = date_format('${para_date}','%Y-%m')
	 ) seg5 ON seg5.date_str = date_format(dgs1.date,'%Y-%m')

	WHERE dgs1.date = '${para_date}'		

) sseg


]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="sepm_chart" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="para_date"/>
<O t="Date">
<![CDATA[1586102400000]]></O>
</Parameter>
</Parameters>
<Attributes share="true" maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[envision_malta]]></DatabaseName>
</Connection>
<Query>
<![CDATA[
SELECT 
	 date_format(dgs1.date, '%d') date_ft
	,IFNULL(ROUND(dgs1.production_active,2),0)+IFNULL(seg3.rmday,0)+IFNULL(seg4.so_td,0) sepm_day -- sepm 日发电量
	,ly_sepm_day -- sepm 去年同期_日发电量
FROM dwa_gas_site_1d dgs1
LEFT JOIN ( 
	SELECT 
		 dws1.date
		,ROUND(dws1.production_active/1000,2)  rmday -- 黑山日发电量
	FROM dwa_wind_site_1d dws1
) seg3 ON seg3.date = dgs1.date 
LEFT JOIN (
	SELECT DISTINCT 
		 dss1.date
		,ROUND(seg0.so_td,2) so_td  -- 光伏日上网电量
	FROM dwa_solar_site_1d dss1
	LEFT JOIN (
		SELECT 
			 date data_d_fmt
			,SUM(production_active/1000) so_td  -- 日上网电量
		FROM dwa_solar_site_1d 
		GROUP BY data_d_fmt 
	) seg0 ON dss1.date = seg0.data_d_fmt
	
) seg4 ON seg4.date = dgs1.date 
LEFT JOIN (
	
	SELECT 
		 dgs1.date
		,IFNULL(ROUND(dgs1.production_active,2),0)+IFNULL(seg3.rmday,0)+IFNULL(seg4.so_td,0) ly_sepm_day -- sepm 去年同期_日发电量
		
	FROM dwa_gas_site_1d dgs1
	LEFT JOIN ( 
		SELECT 
			 dws1.date
			,ROUND(dws1.production_active/1000,2)  rmday -- 黑山日发电量
		FROM dwa_wind_site_1d dws1
	) seg3 ON seg3.date = dgs1.date 
	LEFT JOIN (
		SELECT DISTINCT 
			 dss1.date
			,ROUND(seg0.so_td,2) so_td  -- 光伏日上网电量
		FROM dwa_solar_site_1d dss1
		LEFT JOIN (
			SELECT 
				 date data_d_fmt
				,SUM(production_active/1000) so_td  -- 日上网电量
			FROM dwa_solar_site_1d 
			GROUP BY data_d_fmt 
		) seg0 ON dss1.date = seg0.data_d_fmt
		
	) seg4 ON seg4.date = dgs1.date 
	WHERE dgs1.date >= concat(date_format(DATE_ADD('${para_date}',interval -1 year),'%Y-%m'),'-01')
	AND dgs1.date <= date_add('${para_date}',interval -1 year) 
) seg5 ON date_add(seg5.date, interval +1 year) = dgs1.date 
WHERE dgs1.date >= concat(date_format('${para_date}','%Y-%m'),'-01')
AND dgs1.date <= '${para_date}'
ORDER BY dgs1.date ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<ReportFitAttr fitStateInPC="2" fitFont="false"/>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="false" isAdaptivePropertyAutoMatch="false" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="true"/>
</FormMobileAttr>
<Parameters>
<Parameter>
<Attributes name="temp_para_type"/>
<O>
<![CDATA[sepm]]></O>
</Parameter>
</Parameters>
<Layout class="com.fr.form.ui.container.WBorderLayout">
<WidgetName name="form"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="form" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<NorthAttr size="35"/>
<North class="com.fr.form.ui.container.WParameterLayout">
<WidgetName name="para"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<Background name="ColorBackground"/>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.parameter.FormSubmitButton">
<WidgetName name="Search"/>
<LabelName name="日期:"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Search" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[查询]]></Text>
<Hotkeys>
<![CDATA[enter]]></Hotkeys>
</InnerWidget>
<BoundsAttr x="249" y="8" width="80" height="21"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.DateEditor">
<WidgetName name="para_date"/>
<LabelName name="日期:"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="para_date" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<DateAttr/>
<widgetValue>
<O t="Date">
<![CDATA[1586102400000]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="86" y="8" width="122" height="21"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Labelpara_date"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Labelpara_date" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[日期:]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="SimSun" style="0" size="72"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="39" y="8" width="47" height="21"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="para_date"/>
<Widget widgetName="Search"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<Display display="true"/>
<DelayDisplayContent delay="false"/>
<UseParamsTemplate use="false"/>
<Position position="2"/>
<Design_Width design_width="960"/>
<NameTagModified>
<TagModified tag="para_date" modified="true"/>
<TagModified tag="Search" modified="true"/>
</NameTagModified>
<WidgetNameTagMap>
<NameTag name="para_date" tag="para_date:"/>
<NameTag name="Search" tag="日期:"/>
</WidgetNameTagMap>
<ParamAttr class="com.fr.report.mobile.DefaultMobileParamStyle"/>
</North>
<Center class="com.fr.form.ui.container.WFitLayout">
<WidgetName name="body"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name=".SF NS Text" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ColorBackground" color="-1513237"/>
<Alpha alpha="0.23"/>
</Border>
<Background name="ColorBackground" color="-1513237"/>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,1141920,1143000,1257300,432000,144000,144000,6683432,2304000,2304000,2304000,144000,1656000,1656000,1656000,1656000,144000,432000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[360000,665018,1008000,798021,199505,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,798021,360000,665018,1008000,798021,199505,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,798021,360000,665018,1008000,798021,199505,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,798021,360000,665018,1008000,798021,199505,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,798021,365760,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" cs="4" s="1">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="0" cs="4" s="2">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="0" cs="4" s="3">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="0" cs="4" s="4">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" cs="2" s="5">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="1" cs="2" s="6">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="1" cs="2" s="7">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="22" r="1" cs="2" s="8">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="1" cs="2" s="9">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmactive"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="36" r="1" cs="2" s="10">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="1" cs="2" s="11">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_td"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="50" r="1" cs="2" s="12">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="13">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" cs="4" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="2" s="13">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="2" cs="4" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="21" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="23" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="2" s="13">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="2" cs="4" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="35" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="37" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="2" s="13">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="2" cs="4" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="49" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="51" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" cs="3" s="15">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" cs="4" s="16">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" cs="3" s="16">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="3" cs="3" s="16">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="3" cs="3" s="17">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="3" cs="4" s="18">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="3" cs="3" s="18">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="3" cs="3" s="18">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="3" cs="3" s="19">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="3" cs="4" s="20">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="3" cs="3" s="20">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="3" cs="3" s="20">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="3" cs="3" s="21">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="3" cs="4" s="22">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="3" cs="3" s="22">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="3" cs="3" s="22">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" cs="3" s="23">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" cs="4" s="24">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="4" cs="3" s="24">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="4" cs="3" s="24">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="4" cs="3" s="25">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="4" cs="4" s="26">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="22" r="4" cs="3" s="26">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="25" r="4" cs="3" s="26">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="28" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="4" cs="3" s="27">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="4" cs="4" s="28">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmactive"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="36" r="4" cs="3" s="28">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmmtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="39" r="4" cs="3" s="28">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="42" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="4" cs="3" s="29">
<O>
<![CDATA[上网电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="4" cs="4" s="30">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_td"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="50" r="4" cs="3" s="30">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="53" r="4" cs="3" s="30">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="56" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" cs="3" s="31">
<O>
<![CDATA[计划发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" cs="4" s="32">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" cs="3" s="33">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_bgt_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="5" cs="3" s="33">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_bgt_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="5" cs="3" s="34">
<O>
<![CDATA[年可用容量\\n损失(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="5" cs="4" s="35">
<O t="DSColumn">
<Attributes dsName="d3" columnName="year_annual_avail_loss"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="22" r="5" cs="3" s="35">
<O>
<![CDATA[年设备可用率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="5" cs="3" s="35">
<O t="DSColumn">
<Attributes dsName="d3" columnName="year_avail_ratio"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="28" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="5" cs="3" s="36">
<O>
<![CDATA[上网电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="5" cs="4" s="37">
<O t="DSColumn">
<Attributes dsName="rm" columnName="ongrid"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="36" r="5" cs="3" s="37">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rm_ogmtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="39" r="5" cs="3" s="37">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rm_ogytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="42" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="5" cs="3" s="38">
<O>
<![CDATA[负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="5" cs="4" s="39">
<O t="DSColumn">
<Attributes dsName="solar" columnName="day_load_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="50" r="5" cs="3" s="39">
<O t="DSColumn">
<Attributes dsName="solar" columnName="month_load_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="53" r="5" cs="3" s="39">
<O t="DSColumn">
<Attributes dsName="solar" columnName="year_load_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="56" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="21" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="23" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="35" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="37" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="49" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="51" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="21" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="23" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="35" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="37" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="49" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="51" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="7" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="21" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="23" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="35" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="37" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="49" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="51" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" cs="13" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-5850655"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[发电量(MWh)]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="64" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="8.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="7.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-7039852"/>
<OColor colvalue="-2793436"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-1"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-1" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[sepm_chart]]></Name>
</TableData>
<CategoryName value="date_ft"/>
<ChartSummaryColumn name="sepm_day" function="com.fr.data.util.function.NoneFunction" customName="发电量"/>
<ChartSummaryColumn name="ly_sepm_day" function="com.fr.data.util.function.NoneFunction" customName="同期发电量"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="c72f2374-a031-4214-a4f7-738804731f6b"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="9" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="9" cs="13" rs="4" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[D3热耗趋势图]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="9.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="6.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-1677274"/>
<OColor colvalue="-11827253"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=VALUE(&quot;dic_d3_min_value&quot;, 1, 1)"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=15"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[d3_chart]]></Name>
</TableData>
<CategoryName value="day_date"/>
<ChartSummaryColumn name="actual_heat_rate" function="com.fr.data.util.function.NoneFunction" customName="D3实际热耗"/>
<ChartSummaryColumn name="contracted_heat_rate" function="com.fr.data.util.function.NoneFunction" customName="D3协定热耗"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="e649a30e-47d4-43e0-89d6-04525e576764"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="9" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="9" cs="13" rs="4" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[风电利用小时数]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="9.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00]]></Format>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00]]></Format>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="6.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-1677274"/>
<OColor colvalue="-11827253"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[rm_chart]]></Name>
</TableData>
<CategoryName value="day_date"/>
<ChartSummaryColumn name="available_time" function="com.fr.data.util.function.NoneFunction" customName="风电利用小时数"/>
<ChartSummaryColumn name="ly_available_time" function="com.fr.data.util.function.NoneFunction" customName="风电同期"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="bc384428-27a5-4417-b66e-39163c01c485"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="9" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="9" cs="13" rs="4" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[风电利用小时数]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="9.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<Attr showLine="false" autoAdjust="false" position="1" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00]]></Format>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00]]></Format>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="48" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="6.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-1677274"/>
<OColor colvalue="-11827253"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="48" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[rm_chart]]></Name>
</TableData>
<CategoryName value="day_date"/>
<ChartSummaryColumn name="available_time" function="com.fr.data.util.function.NoneFunction" customName="风电利用小时数"/>
<ChartSummaryColumn name="ly_available_time" function="com.fr.data.util.function.NoneFunction" customName="风电同期"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="48a1ae53-c2f7-4078-87ee-fc92478fc8d5"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="10" cs="13" rs="3" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[完成本月(MWh)进度]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="64" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="7.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.column.VanChartColumnPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="false" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00%]]></Format>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="56" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="8.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-1677274"/>
<OColor colvalue="-11827253"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="1"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴2" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="1" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[0]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O t="I">
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[sepm_fr_chart]]></Name>
</TableData>
<CategoryName value="potype"/>
<ChartSummaryColumn name="m_d3_bgt" function="com.fr.data.util.function.NoneFunction" customName="月计划值"/>
<ChartSummaryColumn name="m_fr" function="com.fr.data.util.function.NoneFunction" customName="月完成率"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="7677999e-7df6-422a-81a4-10cd8586032d"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="10" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="10" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="10" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="11" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="11" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="11" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="12" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="12" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="12" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="21" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="23" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="35" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="37" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="49" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="51" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="13" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="14" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="14" cs="13" rs="4" s="0">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[完成全年(WMh)进度]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="64" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="true" maxHeight="7.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.column.VanChartColumnPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="4" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrTrendLine">
<TrendLine>
<Attr trendLineName="" trendLineType="exponential" prePeriod="0" afterPeriod="0"/>
<LineStyleInfo>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
<AttrColor>
<Attr/>
</AttrColor>
<AttrLineStyle>
<newAttr lineStyle="0"/>
</AttrLineStyle>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
</LineStyleInfo>
</TrendLine>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name=".SF NS Text" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.0%]]></Format>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr shadow="true"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="3" visible="true"/>
<FRFont name=".SF NS Text" style="0" size="56" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="8.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<ColorList>
<OColor colvalue="-1677274"/>
<OColor colvalue="-11827253"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
<OColor colvalue="-15290420"/>
<OColor colvalue="-8011743"/>
<OColor colvalue="-3069334"/>
<OColor colvalue="-15830324"/>
<OColor colvalue="-9657585"/>
<OColor colvalue="-683247"/>
<OColor colvalue="-375997"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" lineColor="-5197648"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="1"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴2" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0">
<FRFont name="Verdana" style="0" size="56" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="1" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[0]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O t="I">
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[sepm_fr_chart]]></Name>
</TableData>
<CategoryName value="potype"/>
<ChartSummaryColumn name="y_d3_bgt" function="com.fr.data.util.function.NoneFunction" customName="年计划值"/>
<ChartSummaryColumn name="y_fr" function="com.fr.data.util.function.NoneFunction" customName="年完成率"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="ef216464-9ccf-468e-a70c-9459991486d3"/>
<tools hidden="false" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0"/>
</TextAttr>
<AttrToolTipContent>
<Attr isCommon="true"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr shadow="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
</Chart>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="14" s="41">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="14" cs="4" rs="2" s="42">
<O>
<![CDATA[负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="14" cs="3" rs="2" s="43">
<O t="DSColumn">
<Attributes dsName="d3" columnName="lodarate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="22" r="14" cs="3" rs="2" s="44">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="14" cs="3" rs="2" s="45">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="14" s="41">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="14" cs="4" s="46">
<O>
<![CDATA[利用小时数\\n(h)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="14" cs="3" s="47">
<O t="DSColumn">
<Attributes dsName="rm" columnName="available_time"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="36" r="14" cs="3" s="47">
<O t="DSColumn">
<Attributes dsName="rm" columnName="avai_time_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="39" r="14" cs="3" s="28">
<O t="DSColumn">
<Attributes dsName="rm" columnName="avai_time_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="43" r="14" cs="4" rs="2" s="48">
<O>
<![CDATA[设备可用率\\n(%)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="14" cs="3" rs="2" s="49">
<O t="DSColumn">
<Attributes dsName="solar" columnName="day_avai_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="50" r="14" cs="3" rs="2" s="49">
<O t="DSColumn">
<Attributes dsName="solar" columnName="month_avai_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="53" r="14" cs="3" rs="2" s="50">
<O t="DSColumn">
<Attributes dsName="solar" columnName="year_avai_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="56" r="14" s="51">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="15" s="52">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="15" s="41">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="15" cs="4" s="46">
<O>
<![CDATA[日平均风速]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="15" cs="3" s="47">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="36" r="15" cs="3" s="47">
<O>
<![CDATA[本日负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="15" cs="3" s="28">
<O t="DSColumn">
<Attributes dsName="rm" columnName="daily_loadrate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="56" r="15" s="53">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="16" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="16" cs="4" rs="2" s="54">
<O>
<![CDATA[热耗指标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="16" cs="3" s="55">
<O>
<![CDATA[累积实际热耗\\n(KJ/kWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="16" cs="3" s="55">
<O>
<![CDATA[累积协定热耗\\n(KJ/kWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="16" cs="3" s="56">
<O>
<![CDATA[累积热耗\\n偏差率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="16" s="52">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="16" cs="4" rs="2" s="57">
<O>
<![CDATA[平均风速\\n(m/s)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="16" cs="3" s="58">
<O>
<![CDATA[0-8h]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="16" cs="3" s="58">
<O>
<![CDATA[8-16h]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="16" cs="3" s="59">
<O>
<![CDATA[16-24h]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="16" cs="4" s="60">
<O>
<![CDATA[利用小时数\\n(h)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="16" cs="3" s="61">
<O t="DSColumn">
<Attributes dsName="solar" columnName="day_avai_hours"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="50" r="16" cs="3" s="61">
<O t="DSColumn">
<Attributes dsName="solar" columnName="month_avai_hours"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="53" r="16" cs="3" s="62">
<O t="DSColumn">
<Attributes dsName="solar" columnName="year_avai_hours"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="56" r="16" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="17" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="17" cs="3" s="63">
<O t="DSColumn">
<Attributes dsName="d3" columnName="actual_heat_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="22" r="17" cs="3" s="63">
<O t="DSColumn">
<Attributes dsName="d3" columnName="contracted_heat_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="25" r="17" cs="3" s="64">
<O t="DSColumn">
<Attributes dsName="d3" columnName="heat_rate_bias"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="28" r="17" s="40">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="17" cs="3" s="65">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg_08"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="36" r="17" cs="3" s="65">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg_16"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="39" r="17" cs="3" s="66">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg_24"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="43" r="17" cs="4" s="38">
<O>
<![CDATA[天气]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="17" cs="3" s="67">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="17" cs="3" s="67">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="17" cs="3" s="68">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="21" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="23" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="35" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="37" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="49" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="51" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="18" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="18" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="19" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="20" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="21" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="22" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="23" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="24" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="25" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="26" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="27" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="28" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="29" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="30" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="31" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="32" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="33" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="34" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="35" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="36" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="37" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="38" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="39" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="40" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="41" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="42" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="43" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="44" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="45" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="46" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="47" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="48" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="49" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="50" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="51" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="52" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="53" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="54" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="55" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
<C c="56" r="19" s="69">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="48"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="1" size="48"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="1" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-5850655"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00%]]></Format>
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-394759"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-394759"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00%]]></Format>
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00%]]></Format>
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00%]]></Format>
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-394759"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat">
<![CDATA[#0.00%]]></Format>
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Top style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1907994"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[be%La;f1,EN.?K`&5a%%-;BWZOX:iYB[UZ]ARK5_[&I;C5pMN6X&ip:$OKKcR'G2N8#t4mZ7=
#7cmfr7H^@[h+hKaU!o?AubZ/'btCT[21a#_f.Vr:et8lXuVT-GL&Ti+a:pm?_f$q`iQ.Sk<
o\2)M['MLja.7rWpK!'=;Eou&^b<tq*D3.u]Af[pU6]Au3g@Qi"/E[/@l>ltc6'cU+dAb#*OS7
XDCo2hmU*KX?W:mD=QlZ7:D`_(LCK'm6<^<<Wo0Uu6qJ'!f(IB,s#oAnL'j6Y:Xc\jL`"2nS
=X(K^'W1Q,<@'647.`H>!>5GDSRV8DmKZKskjMi4@6(G;Ns<ej>NBsj2ii2M]APTiM:dY&N9_
mSC!Me\al.^l7cA1G/H7j+=<U#KEf+lh).JSYN49mJ537)O]A=UK$Y\i$OSAo_Z41-oGV([i1
TkD8KBoO;I%,l!E0-qN6B>>lJPj]A47ieB<YR@2jB$//`(EcnaM<TeF`>n@o(i\V#DjjV<(fh
.b`BN3(=p&J!&D*O+IcF/S]A0k$mLbg1[j(eU\\&WQ)n9G2l.R`lN:.X5cVt"(pW%g5C'-JD"
ed%"s)FZ:MULDLirA/I+S9KTH*\%K@m8-4#`*h&<haD#eIJJV[l5</e475V6Skh+;9IBEb9G
U"8ZtuBeV7<Jnp)86<(2L%>j,[gl:.M*?S>Hj6d(S?\#=I2&#/1m:5"S!r+k,`qQR`=C#$3W
k>o+^rWrZO7B70`?<3J2W!lr+Q7(!`eYmuHY%8)FGhmbH.oi3@kjGlR\gjHZ-cPr-82O#q!G
A$m\C,qF)-K6^XJ(a&i>.&@ae;n-k1CCoFQh9M[Ab'6#8=9]AM(<8o!a,,#5.1I1C`kkiJ3p+
cc;j,fop6^mFnidMBskXfT^mlVh*GS`Ratt'BG!a"phTEb,?5\q^Tpf#Wh"7pBPFjH/dnE"*
:D@lY.KTpg:TL@i2iOB!gs=tZ&,-W/ue@pTP&D>,Wq(7i1N=e7jarER_0;Abul06WL$W^O,e
XX+ar<E/8@*U^;AtfQ>)CaP[0mNQ'nRVp-WdY?nXem(S;N2'JXb@L@77]A2m('ph\:AsLu`rS
_#aR>n9UZ^@6+A\fKKKg2;XD*@E#n^pbPdHOUl5U1P/eI1dg$C\SF:La)eK*$SXE3$51ZCUK
'F%_F6b0pJ+<($TTH=D+[:2X+*3S9fL'tGV58<rJ,N*&MmN-C9h:mN.2KA;4G[H_]Add$!n(h
uiA<R)5d;A^.$.OW13#=f`i9"cY8QZRE!usBe`rjN?+!/*")M[eo9^QmQV-RmLB4;&]ADrkld
->6aKB0[_<=C,RVW*FKK^Rb\fh[02$umcc1*s]A.hDf2u/U;n/*@As;[Fe7?"'09GXV\bE&a!
7]Ad\o16pJ%Z9(723/7L4l<cK.?lmH*AhW.-:djJ^#EjU+%gqV"7r)o1dICY\.,LI;,d\FRiZ
nKhh!>tk$r3tHorfq"H1D7dF%5*6cF%hhG)'a^*fZiZ(U.>t;YMb1U?i5U`6qiKcC$00=dMN
&Ko"KrhNUt)b'XpV5$#;+WANS3YK23Wb5eKdUMe<$mIX7+VB=K.VUCHlpGC-1i]AkrWMSK_*"
k&M@B!c?'bU!K,(PG%FXd+ZO?JELd0)jE';oo9(_L(\\n1#&^L^'nY.+\Z:b'_86H3?Krk;i
5'@sf8^-1j;HO*(<K0NRQ/%Q/dCHl7@n\IlGN$(O6bdj88-+eqXSs70Q\>9C/*1iKBfX^8lK
MA([6#O(@>W<6G;ktamKf8^'\Su&CBGG<T+Z&fqQ6o!Q")&YR:ri-[<`Qkr>\ON!,hk9s`t\
9o?c>qV[>%;U$+9l*Dg"W1ZNqg`D71\uDr>4\h#+*S%*;D6h2N!_#%NihZ_lM6ALhJadcANB
5n6<GeTt)*q`)ne81Kq3k>AM9D/*<R'(pPH>[@:Il?".U7U^FI.!',gZ,'5h%mt/n%pc&kiZ
%QnLec%d]ARX:e:6b@bb7$#e"g$'N8)lAQ@uF?/DOtqKDi$DE<Afi**#VLdpm[LMdm_DldTQ_
2T9ZT$AM/dC+I(k2Mp!(P-[1k$k.ka,aD2J'LFumOCD7Hq#PQ/Itl+#Im12de[o!KA(T%"SK
WGcJGLW?unX+Q#WIf9Y;"-F`EWP&@It.PoEcSiX+WG^]Am%C[f*8^A*SilrUH.73)kgU:Xe%L
`js#:D%n`i@2U9omAM%,VI&\p1=4[V_6%fh-Zrpk=$\pup;S(B_KRcrl8%F(9/!D2ACa//5K
'OI"D!BW]Aq2apBI6@%U=.!GjAQ_co'pEL6I91<m++n(_WjFW.$#a#Vn/]AV_VKcl'XO&:IbCU
GQ:8:h);2;oDC0qL4!C&hHR\l$@^NOgWr:l2QG6u.NV@h&**ZFT,Q6!9Z>nI'C,>Ku!DKCbo
7Y"WWU'aP_7E$o6Uu%']AkZ573OV823X(*W_A!qJE7?4o$57K^If(M0jn;h?Jl"@J@7tEU5a7
ib4cChi7FCM^i='K<XN\3%Em/F%Ao)&4?)hK?D\HN8,u%M@LceDE<\hgIE;(8%HA6PQV%AD@
Y467Rh`pR+O6`<WZcDJ,&DYWg._37]AA<ap3-\'fVMr.dDK.($6^?FQ,rr`\[-_C>5*ch[s_D
L`N>]AQ?D?>&X-^-hb_a9:n>QJ1W!Cd7nq5(hQ[G+aSjaonDFSE1-LAZdG3I45YbR2&]A"5>b0
H9E_ci`+8=mJ`+k)7Ib"%II*T=DP$[U0KH$F-+ioI2oPeu3Z'q&#b?K@$EPt*(+=StVUO)D$
/On5URl[3]A*Ib4^P,Rqp@5mM]ARjr\iVfBE^:2'n@,HM'%S"+S$r`7.o"+RFo:SGi4hGip&S/
2'UKM-WHj&(/C.V:N8dH";hMluM?.$l&#bs`4Npds)[(,fRlRbUYY`C11[3iS4Jm3Ds[q]AH*
'5kIUD/sM<"!UQDEC^aMX'JBSV#nJu?E?9%d-Y"2#/p(TA:me1m@rUDQ?D,RBB1obQImNL6q
g.i^r<j`ra-[ZRZRikV(AHW6eo\I"93<*7o'Z#>@Ms*ikhlF:"rPGCM$ZGUeR:dNVX-S"u<k
]ABb13F".G_rTt$E0,2S9_,,fl4^>oUGd_W^7p_epiV&T0\P"TV?b*^`>L.fMdq>pB=_S,kCZ
<u8Ioa+I%UK/eOUC3#"Ko`JGr7EqX;`E[r-6tc9T,7WYp.W0V]AS#b7THj)bQ"<X39Xp"MDg;
#nOg53g:3RZZg:X3Q)ur*f[V0pD20K_;i@hCN^Yc763Yl0B?7V',\$C<2H]AhCA-6r_fP-hIi
@tduh"%X^9hiT`U#J3LjiU"!8?*O>gp]A:3NiRUfAX7^6S_a"ABr_DR$bLnO8qTu<pOcL'"6s
ns]Ar[2MCnik)_EeWD#QH92cf\f"7T%3pLFWg0,kh6g5mUc2jr"hj\R4At9h5)+WX3<-!1,g5
aT4l3ZRJsCZ(^/M#qgX1ZR1Z7357ZN3NC'3\+o0Dl$p.6O'%m!0Xt6n=N-0(-'/DVLNWpn62
f8*g1(k3OZ8?P/EWd+rAI;,19MIioO3.MC8=Lq9<-;:C)ljYqg;O+:A;V/Tj$G-+%%I@$Hm:
pR>ml7;!13EC8cSg$LpW+d/SZo2'=:!8;=A=fU)HZHC`RuN%CjBK"FVW^"&^9J]AfcGb-XQ2Z
ZocsQS-QOI&X4u;cc3<*/ksG_e/R$e0aB7%m25Tl(=(G^MLMLT7FeLK=#BLh?+WV"$i4WrDT
`f35*_D1`):b]A^fIrc-6uW>J.Q+2mo4fNYO')<&T&Mh_5QnT3:SMi2I`N=^uo!^lsS)ZpqZe
qTk)^q:5r:oi9Bn<i]AuMm_aA_<AQ&0UU8M1aHt@8KfjHAaMu`7;.Cc4^./3/cYfF8sK?R9)2
OUaaHpZmm5r]AGWcYqql')1)*a[HJ&T8hl:5b8"9\#/F*7;QhAU6`67Ql9FHM"6q8/>5+Z&t4
I:%$X]AN2#fliksd-K#6bE*p)-0[#>,QfAO@^8B,p-+&+#aM.85!<J^*nJ9n?r>K$\YZR28We
Ijbq'YQ#<N?J8!+\D]A-scraM4a1Y0+)B,O@BAX\3h1"Zks.cZuq@nQDZ;^!;s7@h4eimGQn#
15E*O;!K?Wh>!p)0]AG`8<Y>,\SV]AiN;]A\X.Kj71Rcs'od5@H%9V>d5XGTQT[[u'9SE;&;D-2
)@B8AtcT%\2T$r&P%olkGObUKSq-NHQl%T6Bn`R;]An4K0WBQ;3.DHFY]AmS#UrXa.Q('R7\jM
?9fOn.^[UO;*-*o]A%==emEb!BU?1(/#?ejR%4aXCeYFV/k%.@c\XY%SRF5cES<jOOf3_5ca#
i_>>YV;^u*Fa@?ujA*i8N#WGHmg+WdkOch"VK%FOlV0oET.b7!h6cV[iq+_"1#i]AD%&3SOII
Sqm(5fXCYb4JC\`e49^TKMB;dEZbe>=#Y;NrU,4TR]A/iG;B=k#Zh-D^F/qNTMG*TH16I;o,g
2hukqEB.^%#^i%?fec?YqWe6qo[rar!.oP=d5uI-5IT?`=aklmo=t<ki>k,2a0s'CG'(/$hP
+]A2Vi*Ut2r/YE%YKAg3T<?>V.e4l1[MFT"q)W;Ym-K#F598\7+r3?Bf)KZIFr^3INQ4M@?8A
UBb<5$DE+ED55eqF7Nd<8e%10=JSh_Vs,(R5d-_fOne/ft(,`(AU]AX0n3Lq>9R@UA*J%oST_
d:Eb-V=:=T9tXf4qj>&2^!CF<&[6HC%ZH@lRrjbeS`3s#7LS-qZ:q45Kf$@BaWKn?BCqaP_<
\EVS(")6D=8$16b6PrePBhWPja6lS)6]AFQ"Zu3OO\>5pT8DNYE:i*o!+%Z5=HK#+Yg,;i6&r
5W,:t,d>MtY,dJF,:4HUeq'Q4%0<79A^1Xpf\VA.s\=&61cal$R.T:dk2dd%qXn;^EGZl()T
kh!lE'aW$s?@L[R9Kheq;UA/]A9$i+jeG2m54oWtRV16]Au^_Q#*E'r_0WIM1RsM4u6>fhr(oJ
L+4@0[FjbpBM6t^ke7RUZtq+^+7hS`2cYR4Qt;Xn5>H2-ggnQ,_V1!)G8pHI4t?uN\o;6U"d
:31s!X0=&FISK4BC0+9?mK$*,TQ(]Akjbs%RIcpD-d6h"SVi_LBbT)W.D\'8DCH!mi.uosqG-
`J_l!5D'e4%kE37Cs&AgEHksP&`Oql>gB/0Z')@S9sUsJZ9:BbY%s1Q(,&W(KWQ]An;iq,PiZ
r?lb\:lDCa!,lIJlMERH)W]AjKW9"`AT7$M!gk+qX@%\l\NY9&QeDec&_1(b-k(Zd92.KWMas
\T7K4RF\rX#L$`2?"CCqX*0?)6d.QR^PaXO@4]Ak7hP5X7&3&T6_/FInlC"[4O>I4Bg"k'6DM
r.3*f`qMhD^C9h"E\eS:QFrQDm^mNrT>r.+e`LBhEk#6&)q@<&h_:kD.)_9Cs3e[KVBOp7-s
sMd7-4MWKmp=6$Ot6oJ46fm7_=q^3?q,FE=m/R[AoQl[8;OQD'(!')4\[K;=)->$k(o8kk77
^[1AU;_ic"di3UA%qSXojgVrfE*O;6_p2n&`9^h*qcH3.[sa*']ADEO>/?mGm#?r5-MH`m&+l
Wbo_Z#uZlf>dp5#TnGDFh<XJE6h<12uJjquMKB!_jb+J1TV\F-YIe_J%U;5;V\jh>7^HJW>,
&rY4X^$Y^hIP[$@P<)/'=/ZmT>"hT4F!^QJj>^p[q[6X?7j3J3hBkM!EZTm:4.#QUsLp'g8X
1pKCN+ZY8Er#:T*fd#Lf#%qSJ$[A7Ecb)Y='3.`a*iu<H'PdoB"CDLP5ioV2(WRK;-[PKdan
`b2+GFeLt-\IZT;/1E5e_Hcjt]A*r/@?g#*oT4B-IL_\e#dJh&WaOcGj9G5XY54F5Dl=YO[.'
TT=6WkQa6ipGDZXo+I5`KLb[;Z51Ls7rd<7N`cmKDI%ejUf]A1Vf-[hsU[Ng2dY'qt$%(-2fj
D_b89qWX\3_i&.#_\rqec%@j4KrlOIHsn([5nJJ8fUQ[+PNoQ*BRd\[6t^E'aHTb?&p(p8p8
GUXC#hjURmI-?nXRV/@h0Ou>["$4AGQmWs8_h*5#AE*,,Cnbh9B+cpSj%BVVeaL'i:`]A4#0h
iWKO.g?XoDMO@Phr2tm5C_k4U3_:rT?3:]A6[Bd0L$PJ9I14Bs+B2\5Q;<,mhc8tM.*$m5'U%
E,.6Hm(COf6#oVK1s#mQ%0c@J2IK@@aldJup\Hq!Nf)qIMtRiT^\N+itY?M6@u2pXTdhtN0T
@Np\B@TLm6>!eR9RO<GJN!d1#F:nt%reHX<OuEu!De,FeCbLdd1+HYgVos5V6/S8[X"F)BER
>a-mPG[%i(U7MO\72Xlr6Q:4u7<g^_$;q;Jb`eGR;0WhgCB,mnMQ&qB+NJ/25,?/?r%VIq&A
c%p^qY%r[IqQ6!b/`Qo!sU7(C*O)i@X?N_]APr2i]AmA)#%5Q1ePoF1)e"IafUib-XpnoHu=&b
NJ0M_,6iZNLa"^!Q'sF#QdOPi\?O%F<ck/$X0['mJ::Gm4*l5>U4gpk[+e@To1>r\3a,R&Ff
PLF.0G_YdoNRZB7/7obR"9j!"fBrW.;%4\-!m.sF6gY5<fI4248p2UH;3NQmU)k&E:S3IpLi
P?hVsgGA0Qb.qr=NdY!%s24U/'A[p)dJp*g24,G]Ai9=CNE8\8`$uA*6M*ct9g2$4_;5'nZSt
=tQ$g_[5`@BP*Pu3kbdN1te4kg3C.P(#Dhqp)pkt*=@C)V/W,p=FE&cgnIaSLp/.teb*ka1*
FI^V.sR@g*Yq4fOKqC8,B@6):0ag!9)Pt.@m7]AS>^qP);6[gX_Oe8[`Db"W/pg@>gL>h!W\,
9/o1UCF84-6`1!#`MHHrULRkVSg@HMQqL(qAj0)9rF$3<Xr/hraO'R'_<nJL^S#Po7A%N@fH
:<EYu(/F/^Blj[rVrl`^o3NK"C/lkWlpV@7'kIcPKWQPii\>kO5un#iK^<%(uP0p4'*Fa!Mn
\S+#"U1:&bkpd]AX)q&d2RiHrf9RLQaFGbbE6K&UER1%V1U^2L=T?7'nF->Zf)r&aVf'O!["J
P1>;&7]AjI8`:<@U`HeY5^[q>j'TQ_^'['he0+UUJhd=gEIlVJpC>aRl5Q4F-B@C`m2PXK:T*
d-qFCC^V>Gh]AQ[d/arjg?k:=7K$K"V0B?MK#0fie4,O_k_G:Gm,&/'I\7$MhQYJ@'GQUAi;X
.t=7g0lb"HZAS[XP-'[9gt.eSMAA+`Gqoh/?^>&>$>dq4_1Ju2IbI6IbAT?U,(+c;+$$#K[g
q@I,;8cMe=i<(oE$I>)!hJoJ"J_Dsc0BUmUs/_c!9n?Z(jprNEk7Sd43U#W)*<Vt=-KkZOq2
0Zn^Q<,m-sm<;O]AEl>>8U*E_^B^`Ud7jp\E'e6[^Qc&gQaZole++9]Au7+]AP/8G/h%r3A<1)D
(Ao`ScCK@5W<$B)sa#UO9h9DijB&AahXl07!@!7D:k0GSn7+8j7^&^Fe![98:9C(l=k/<-PB
X+h=@oXf^Os`,W&EC1IkrEc*#DUbqP!U&-$i$?q/#.Gki7[g=>gA7(pAL>,g75@g]Aa(U:"RZ
2;s<h1$kJS:or>c#J8f+N=S8HHtG]AlNkUk,!rRSNK\TF?\rDaa0g6:Zl<>>P&G"3LnQ.fBYP
uJCj@\onfJ%+%)KDS<'6:+UH[4<Ua%hRM]AnN1.1Nn5l)m,bK\e?TOLWc02#jDU4.bOr3C`c'
ZFZg6X[\I3UY&lIQ/4kq+$Z[m^VW+eZYP!;0,bBG&Gl[204Mu_)e1*g**V+O3+&r`"3kPtXl
Vd#2.3NPlR.SI?gF3>Q0"p&./5'!JsftPf2gsbI=%D,!NXo-CV';-TBrd>4Rlq=odajW2_?L
+RYk'3loO@eSAAEH*S[3L#H^<pF8+07gprXdCUUU>0"3J%2-p0u67*sg$seRWlW(uFU11'QP
s*JeV2+;kA<ou5;dNV;oKNUX&/o1m4BTE0@a*#"T%LUnp%Q5_$B$n;J--^5ed'592ko(CK^S
le.YXA4hG.if)RJi_Gl?6E2cFBOV]A#A:f&Sh4^Y]ASS@,AoRB?Dg,hj&??6s%7^[WGPQU)DoD
)!lfsW-J(b,A&<["cTb<Y3.mN&,3'.TR$l:,CN7R="NMd-<M4@)srT8g)q68c;]AL7lV]Am33F
`d!f9CIu@^KqJqCFbV/FKQk`C.0-_d%Om1_[f2>pa[$i[PRYmecaO`lWEMMa;%G=!&IL[nT=
"3]A"JSL\`nW#UQC,[!tH_>BaC"s*HlB4lE#M=j-IAo6RVV=Q,remCR.i^.3\/e5\TMo93eXN
"N)ah#M$+o(uhG^K9O1Y)P&`+EEn'p$m<begm%"ErPr@ij>UDZdj;F1!J?F_X)J'I6\.HJ%Z
3!FNLVQ$Zt('BD)pBcoFj:'a^O`ZJi"B>8Kk6SJRbb/k=703j['$NUaZ!]AMmT25L]A9!$uWkd
[?d#JJ,00L&)DMsFl/h@i[l3o>B7Pia^-.6LZsFlB<2#\6DqcWTp-]ARrH*0g-Th.d<T\6[Uk
$kW)mtpG?brR/+BZtSj=Ni&=AB!c$(\6M)Ou3EG7IX3i:g75H*&orYCdL"lp0TWq3Z:`8Ub`
l@;0h,21\p%g)mQ/Dhm/)HrdXEr5F(NCWY[T2;8<<Jmup'aWr$ACI[DC5D*Y,TrG9Fi,n)Jg
uimO"'W1^=ReL9j1,T+)7Ot`3pEgHlTtI#FE(_nT_N"*7r#i;nE^&PIAp?P]ABbH_1j-s0fhG
PuK>&5U,r'-)"@(eF6c*^-1ujtRdf+@1#.s0p]AjeN#^r)mUqhq:,<CP$Ih+!0?3saNfV2)oo
PmOWsh<a\*IG^A-n.M*1OrZhc?F7%8K30Fhd$`WQZZMhbX\p-13ukq\WoXXPiqDK=$"`nA[m
")9aXCbn[&c\g!<W%GO5dY<=lGYo;W.j;"&QuYI\B7:FffhNGXB3cp>jU(%ApC:NDJBkic4A
TV%_`HF"aW0B5=HhQtRsR4NuPPC\lW(<usFA;"c`/ZuSHK[CQ7%bY@K>PgrBA78o.XJ6g#eX
.UK\I@J3ST1p\WR)5r&5m!U]AQQT6l3:.%\Gjoglp1glWKD8Z889]AM1\#uN4M='M*,;0qX^KK
,rgu]AOSA&)N9J=VF?6$d[4ChH``EUfISr_%lr?OI0?FLUNV?+KfF6dF.4IET5o2m*sP<+1&R
T3K!Qlh7i>o5s'7__D7+,HSM=3hq"I&lWS9THf2/<\9WDoFH+k.h'Za;^_IQchQ_>i*Fg]A$J
%`"hQhsJ*oN-Kc`ed*8n))&$gJPVV(b5Ke['_H8Q_r4+RMehb$ISb[h"LahIt$l4M';+pZ9b
BmFN?A9oJON9+6VFc^2bl2J1.)VOI)%k%ZZ?YDK[Ob_au@NE.V+I*bVH.4?NC'Sa-h787jk$
@bom^7!&B:FNXsg<cc_Fh]A8.[)(>eP?"s'%"J*Egk@6La]A&<80b2Z-7+e-nAYT)6eYG;9a]A%
qsiDGkAGI&1G67CQ]A9V=E@>&+HOct6s,:Z(C%g0KAAa&>H<flQjge`eaADl;LdQ_kUt6:9&s
oW=Dbf\SE>Wofe_G?f!PR!aoP(`C*?kRkEac/SD/"kHug.lTf8p3+DsdR;_&?@&cjS,CKW04
EZq3OX+(&AEPaXiELgg9m=prG_iJ?k>1-a*j(YQ-!['#V$H"?.'BM3rf3DkD/F7[CW>LBZ6+
XJSdIZ-L=cXA6rnL`%;$j?UZ6k=noBo%GM%kg*+Al/q*8T5O%P441Y1/7r%MW0/24FAX:)*M
nXKA-MZC1>m*s1Kduu8F+l\\g/?eGhhD`Ln,DEt@)P)&0Fj;BJC$s]Aab(3MNZPF3j\b?JeV2
_CT7#?_QFi]A=6DjjGk7esb3De*$D/h7nUH9RsnE4?DK,&#,q@ZMfaO@p&a9K^%nJ-M(>L[`!
l>F\_Vr[ZFMMK;9dBh5-l>NHjgL4\99;=XW.]AI`n:=@pDHsAW)%#]Aug]AD>iL=%+j8d,%d=Kb
ADJZPKEZWJ./D)!Ldn`oZOZ\kJ0geRlaZpPoWO@.mMe]A&g<4B2+Q`mm+2A',8fuk>Yn>c6X9
i6k2$_P]A=uirRcELkfCP%VFmS_nU%N[#aSiZ5=csn]A[iAZ7rV$UheL<MOd44!K#KX^A7DuP=
NJbQ/4_0_MgV_HXLBJ/.+F@THe!0[7P1JonZ59ZVUFPLJ?m<LDcYsd8\7X*X\W^kWQ*4&<+5
'7niF<TF@Y(Y^IEjQ'p#on75?r`=[L@&$3OZ7kMpb=H&gOrTb@4X9(1CjA3Lf'J[.QjD&KQX
nL7lMMsRHImE<&e*T7\tZf7B&jF!HAeR%<]Ab:e_hP(\<,*VH.T[BfPDHuLPPi6VU8kbkA&@@
N9P*?cdrkc?L*/U5Q!-BX^NS:U9`aj/aaCd\&or'OtN>beb<;q@L4aJT:0j(!#Q<@9s$QCNr
Skge.dSs\[jQJeC+?!`P2_n:DB4O1[Ma%#a:KX`NnJ>%7YhB)5SR.YfGg'bHKmVUtW*aZO$I
\V$H8X=2\m!*@B6S[6C9l]A@B0)@Z<mV(M*FqJLU-j^2qC?#%`,]A-9G'Q$iSpbCo2+?k)8$mH
l,60K+"H.="91KVo!$G1B<)M3.HTknCdY?oLWBW]AtpRP=86):*Rd@9mnT5!=p#UuY8KiO7P`
<S%:Qk@gd>.J]AQTb"`-R`c\RM+"Ec&?X$-(fBRZR,(<0;\V,%+*@A`H1hutpK*aWQY)+s*jN
eE4OHLofCtO@(48cq<ON@c:i?dO+@Te\ag[\+Bbr_[>,?YpI)@`inePW3r7PPR(2j6kFnF^q
qNStL7Bmki=&niRo!^gNT5^BB8?74\-.Wr5)aEI4!b4mRQN3j6n'n\]AmpWX`P>Y*qA>nEbm>
-&iaRsW8YF'S9N4s%Y0l">T1,ee_Y[rCFr#GA`%74j2cSi!?0k?/_7]A=9G5hR<":K7f.2gpS
G7N>>mXfr&@SmkT3LXuAtAB]AVI@Cm;fp4L)^1\<l%<5]AY0m^K46#n'p$Z4dS1ug`hnM_^c8+
.kEH(g0:L;*<s4a*=:Z)VS`ck+)rJ9Hijqh\5pll:]A4:!V)i>Si+'WA#U*-E5p%B!E2K^YY/
erFkAL+k,Lqt`[A699me4=MP;2!Z^7k7)!Rrl[E*'7=YD(CKat.Tq0fm8K&#l%KbifY;E'D'
88]AOGi[l[E17b'JITeK6?0-[E]A,M-8So']A(kWp-aQJ`+_+CsPLdQR2Sd7"c;O>G/.u"1hbKe
Stk*LEh-%gsHH4Wcajj?T?1;[_S&f=T7+*2c+;@p(BPaE=?*"g*aF5a]A?<l;eba#OYbR<@rq
2]AJKZ+.m*M'"]A?ki%(V3]AVDLa+h>$'8o8^Tm#(XOn`?5>0H+-?^[93T)3cDlMrcr]A]A1AQ10Q
IrTK3B7R&=\P6Cg@pj5UN`UTiI:%CB2T!c_+b*`1P)hQ_LV$mImm;%@&+"Ul?KsfhPiRlbIA
IrfnfdF9#F>_j!K"8o\Y,XZj>0^)X+Vk.?H:u0quSQaUtTp^Q-'QU^_b>9HFo-6@^[GYbGTr
4:0rm@^Pj-^&8h"gFFSi:0m_uX;"FB8nWH@tk]A.WRSG2UVA^2q'[aKlNRX\Z!D";?(^o9Aub
GNDBRekf5%=@pqqEk%M]ASKi]A9%VLI;OUQgh*'j=r>?@3d[TuRYC`7.B!(;tej?Z<VG'V13LW
qJ5!RoNFA[,:5%[^qFZ>prM,0_XBJbdm+>Hn:Jh#ZqNYp_#KOrYr[a#Y'lZt(+h6c3)noR"M
Sn0;tDs,-eCN;)MIpmFak_<oUQ4L1Mi_=2`$F9pIb<EFh*M5(7@VEjS2!Mj%9$^$K"Pp=8IZ
!4H%)=ZIn+<]AD#tu7i?(t/NiR/fNc$<Mt*`/5qhA'K(@[dP0'qYj[Fh$mjmJU(O[>X#cLYkj
X^u^oN(;`dW((0KUp)D^;eP(&S`s=^NbAn4N#C"LoJul`S\MdUn',@J\qgCoB\BN12=&b,!W
HD$BLN0F@.WqNggu%%td[b.)s/,8/KkoS<2Ne2lG?kWf%sXnTGXje>.1Uss8m4b;U8m;I2ak
hfGa!^:UfBP=frsSDSBX8tB=YVBCX;RVe'4o)%d5C'FgHAN[-"#H2X?\I=%:UG<;l/Th&I!L
dEIbpSF1&uSEs(cf\PB.8f9b6rP6A1'bpA(F^^j$AkBaH3WclR<j/(EI.6`eXR??$2JRNC($
sCq7SaSAm\q"2lW0K75ckEskpl8KY296$CIbWi9=$l0I>'8EM.S)edKn*X64R7$5,rkBJu`\
C@WL]AG2$,UdXAYuj/q`q7Ad3;AfA]Ap(\M'BJF&%UMYA2==;DM%_ZIV2[\>b-C]AcI=(;;N9lg
8H2r9o%j)/tY$#,_sG^9c!1o2n`fZd8;$R5Tt9je[-fH<]A0TXS,S>ER;Cd:<QC[F5/6a\e;G
d`CD4s[iA-Uc\W=g1,e_n*fg!.hd_1d]A'P#\4%&*9[ru)"\IE,q1X"\Gr.:E=,JMHbtb2pk9
m(Cm.%27kc0D5EPYM4%K9`d-F_-f\#Y10@j7E<%7[EM$*h!W@F(/lHQ,0nX`qINGF&;]A68M5
KHb%3-W=o=o!24.OCg2?K&2IaMT"Ht[c(_O53A(o,fgk]AqG)*n4;UD^&Lf\J7foXUU5J'9c/
[8*,p>7`8lneP#Rqf7's+9G5G);=/$W)B8rJf33PI/b>AJXgG+]AhJ.CCaBWYC\tk!(*sT@n!
e`e_;X\,MQu@_m^$q.?_PQ)X(;uP`Du7ZEgeTqZ%4b.UXk:Hkpg*=^/BOYMQjI['5RF/oPb'
p>WoQ<]A[-"Za(o,h<RpQ5C;19lq4nnL9GL,F9\NE/J;).%4hu-1ul"2pmhJD6t@ggLWME(\]A
mTaKlrXFko3O%/C:aUr`S4E"1a7"j]A=iYPGV4fkPXr\eB$hqmPAtS@UX0N'N4*_X3I8dTWHq
g,DNTJCQgV_MBq@#I6r"djRp%/R(Paf"M0J+$`o\A2.b$?B)>%,H<Ej]ASM^/RtKZAT.En+kX
5;854>44`"$cp*S*HVG7\A)BN-ecMY``!NDVKm+>qM7%U0eV*bWII=SIHa41hqF(nkU;%fr`
L0acUM'=,5)K+59]Ah1Zf.636RX]Aofn_]A3VY1R3=CXT:A-#.4^IepER't84bMG<k?;8N)NF?q
^aBc42W6"3Ls0sY9i@Kuc\31Eb8H_uL(_ZUt\7S@-H\SQg+<rXpDL:%[IR[TB()>Sf1WJ,WY
^8..PEE+m)oDHWUUH9!X_'q('pEkDkH4dM!*qV=-C:pR+oL%&Z9Len\dAhtq=41iuD]AHE?,-
lOe!=PQjS#j*d"s5M"Hh4(*\Gl^%LKL.O#=A4,mS<7Ac`kEQT-C7Z$b&.Rf"qBgMcts-&GhN
1fPVp+06F4JhZEmb7Ri`]A@R2I$-BZ8>Ib7+2[t`@K!2"9'Broj@2&]Aot.]AW\*VkiG&7Y/\0k
eZMV)'GmpAY/I3J/EcuI4BAV"*T_><8'PM<RDFn7E^>?nQVGa`lfHqD4GM&3ZdZ]ATuQ+MVLN
c=)`>n,$sc2<lr#jR9t'Je[EZXE?)^hP@ZNH@GK^V*3/g9rMc]AVPnseZAErAI4e&8R]Al21,n
Cf`0,9@ffI(]AG(=:p(fMLb;$-6GK8*a+#IWEoZ>45@,IGhk0Q>f0J66CZsCtfrI4WpfoX8Xf
_><RX8!$pn]A0m_tEM;E2bU]A\^d\3I^>UAXgH<Uo=_!?eT\PtI!FZiK-BC]A1o\aaP&K-cCX+<
P9/6j1S(Eu$*8F.dS+\jM6`P<Z/JRn_+(WmX6m>YY"+IND4N<r_gHQbIQa3uVAJK9W'Ek+$@
HX[A$QVUC]AFS.N9D^?W.gH[0L,q[X&5K;k.d")W=:k==[d:FZElMS'euGb;<+)Tq]A14'*8eb
aV9JLE,OJh(9GD^24Xc$9>P]A'!a!UnVtSA'Cuar`/??uST)I-PZ`lhCD+j[KR#M>`cfO:157
[FV<]Ac,gN"_KQ]A.hRX[/MuRoVp4LASZd1*M=@5Lse:>^"XXI=q8Kp[oq.X7=%SU@Rc%C!6rp
0-uYN<eW<L3[2Y;;#RmW"OL/NC6[]Ad?\VN,86JR1Eu8F`LFml:FL[ctq9%Z"e3,D-?pqjAZ^
1.8&QcV#(Yd;Hho"+k-2;.cl$_:7:+ejD!l#g_XtkVOp:S.iABLTpGIiUafM.7]AD>1$RK6^2
i,51$u)6.Tu(%8j6ttTQ`f*+C]Ab#fIib)[DS4ARCPc\f%8p35g9Ac7T(='0Xp/O;m*3%G1Y:
C2b^1^fX/E#1>1>RfIV\S)9:tMghs?a<QS83+4*HY<j18O>lYC6N?tEJK":\Ch/<,rUS$k70
V]ADg$FYC0DDaR=;?.<GXb>>ef*GH1U.sce+)I&9.9(-*,Wt,S(nDo>kc*_3f>"#kI:WE4AU1
VEFcDC'q041"h<P;WqO(l.rJMC*s9f.[fB@o_ojRfm\%7Km[fhDLE[:E>gF!&AcKdE3oJ\74
WPdf>(p+</1O^q-7'=e.s7JP/hq/M;sA0SN+<kfm))e-E'%[1o-84^q@!L!Z"HC[T`'BP'sg
[@a,bV_n4<dN-J8_Y%reSoQ94I`/XZ)t]A]A"WGfldHK,)X)@[uak;?.p\jg5>@!!T!LPV[fL4
Kl]AemiLol"\;$_MCN4+lHait1?/lOEQ2Rd$VRZGcV02DD0gqCb#B(6E.rP)`?,c)b)DGam)0
go3K&)sHmDbK9)l>0?,VA'UnSr2Cl`@(Y<%6j9^iLpP]A']A##:iBGu&$H_HePhssFQ"XMK1kI
&+^gp0K*Ll%XQ+.&k8^Qo00H<*NtV]A;@2Go[up\C]A>,$u_f$2O^K_Z?")]A`uEP%H9D#mI-\B
9n1K9oE!D.2BI(\-(3CC?GKL&e$Q@47KrTE"PVb.i?_9N9Spd96G<ar2Y2>=FQ<>)?V"aB_l
Qq(X-,TlT.hnFSs(DIqk_,R3"_YhI#F$+`!EjmGFY]A4X40"b"!pdnCj%/K^AA#^j+Jc5Do$1
FMp%Ea9<E%q<AisksE=N)_&%P-K[>@%A2d=DG=:6q!.5>R1f/9]A\Ie;Q.<2NEk[9tN:0rb#K
Al:orc2(D)'*Qp7Ga^"Rlj9N*7;GX@8V1@TZ]Ac!;2"L%gcjs3M4B/LDYBQhCD*o)[dEUa$]Al
i?lEL&;MZfg&\&_Vn&1)J&.CQ^&u=Mtq-jFBDWRLPZl0OE?E\Lq3kDpUl-[gQ_tU-tBIs0\0
pGYhPWXNY-UEFJh&`QKAHJVT[QD$Y4jf337dZ_T30:u2>0s#tSFF0U!,5UJ*9:Nf9;=5/hGD
`5]A,4`b*EQnAWe,:pdV_',mcSgTT^fFZ1X[OrrO)bZ:b9$4iD#Jnr@--;s6l[]AV<HONC:g;u
jBG-S$jo]A-?DBS0n\9TJ[\3hJU9MHn"%?EnnnXn_jdrUD,fOjY>6.f(66A$&Y1"Z!+NI/GU[
^O-#PLk%liHGH*I(+<(of]A#RI"$KHH08IpkQI98f9+9QhdPPqfE!Oef"7WhfQ_ZG@e58;TCQ
FbO>UZg,"AXn00q>XPD>+)\ag!rTWmp_Hn603[*#pP960K"cfD%RJ:'QlXqaR`?U$b3Z$.G^
*0+#7'A]A[X?=b@idnf#HV1MB27PB:f'X2;j!bf;`"`/VE,2tt'H;Kkar1U8NOc=/u$*76^5B
088$+\hlVP!lWMpUdn/o&L/?&bk(pCM*'P3^9XqB(VB)rCK:qWq]AEni)HcCZk@kWG\4i/.e0
o[1jk3U!&#Jn4G<Bnhp&YMHZTGILH%h8e4l*XDD(ZA05CqVbZf+&+S$uIoDek2i1f7ujZso8
L<"4%24CT:\[='hB1;V)r_;R!P_duh(948k*.=5#TQAWOV7RT[/[1"mM)L%S%nO%ID2PUK"b
_FLJN<QalVt)KfSB++_Sqr@j/fUV"'OkGKi%n;;Blkp-pV`sf7r-_k-S=""&sb8gOWXn4V:t
Er/HbjjR=-c2_NXoX]AGY"bF;^::`h'ZI\#2Y,\"EV7]AC1hot>5H!?'%C1n+ZtJ8h%Y*!=RS6
D=`p2pSN4SK2MiJ#%%M9-8YU<U(C6;p)g$\`G]AFPh"h\\[\43"nd1tFH(G4Z52]AX@o#!M70,
pFIh/)^qec`hIf6[S*n%,#ViRr.?rOCM.<g6L#9V!,J*6Bt,@qY`Z_TfVFkF`1,PhJuC]AAS=
9(M8n>_bOVaoC28a5`%L.[B-:QQ\M-=r7B^B)m,7a,V/Z#d,n2E2<[!fCid%OA=`bqb@W4r2
%T7(X`^nc3*!kpGN)q>Mi'4a$FR4[Zi/?KOa176T6mc]A+<!]Ao6&lE97NHb#l*hU:4.;KCL_`
a[d([XAl_>/^OB2bPH"e:7=(lmr=Q>bccZmf.0;rD2,^n-lY#Q1q8#NsC_-g;D[?8OJ,_Mc'
Qh^@$\0Cf8guch9!WMHaSe7u8"6CV1gL>qphkG1VW0JI`;B;aZK8*4%S[.Da)$5LS4N%C^(m
3%JD*.ZlCmA<$91^ViEmN$YJ8iXD9=;9Y2?"u!,qZ8MrH*Td'GQ=r0nE8Lcu0<?f@u0SKpWm
QMW4uXs2k?Z#(sl^5Vdecr#d>j"!1[kDHlK(sN.:LSSjHe%*$[#Ieeh3UC8RN?,7CApi#u+3
4G'9o!OaLqX)rc/4d`9cElA]A/#-XN^)X<PFq?>M7%BWH*VBGhr.c=p'5DZj'Wf>&e.TFNm2s
dG5MNAJW[2MOF@8:bhO6VS((&Unb7"US\!e?j"I0i'g%8r3lRXqhG,I`q+a2ihh11q[<gO8p
ENXA_'2oFWMrPHA>k>$8/?98q"B$ZE<V0=50TiG&jf^OiQi]A2>6ufq(h`kSiom`"h$<p&CPG
Im'6\$'hd2%5*Z463K#'[2`iQF/(Z+e]AB)0t43=NE(*-k"URDcK/chWk2FI3\1+(u9"4W!&T
/VN<fbIU8-#<9,<ZRJHu4D&,W\6X-qkibc7LO'$\g7UJR@(0.Qqt_YD,/nN_SDafPIa!M_[g
3m+d:uY]A[5K`1ebO<_Gq]Apt'EITfW8ZEbO8=V5XMOZ6M,B%?G8Ug5`;[qgk=;@3),:$I@6S.
JR@QO[l$g$2q#P]AI_rcqa$2`@pT964Dc0u%6r*b(Ujd;1PraaU=Tu<GHWiT*%oN)$KYa%<I3
jP'hcCIV?^;)!"?(?@c![Qo^=0HeJjkB(Po/:f?ZQbV]ASo-,$J&hH>i-a0U[l8%#TO8GGef4
l!_6:+``5hTZ9J@`I&\oQL7SEYrHWA\+<IR+j=%-R039;1D8UQU/3)Se3`05e8Qs7RHI(!sC
SF1Z0oTmk:+/@o,:#$31ZPp:L]AGrhRe/@T@NtO"uh+IQ\cQ*Pf.GL,(!HCR*Zc:GujNQkLj7
hNb:&f?\#s5IHls@?lYZ(M-G)DAsoMXcsAa42pg5ikcPeY*[2<HIs73H+S@,%.Cifbsl8Z\C
,:6q;kJB,*F.Ye8k]A3>.kEQ]A'7FWLGg7B\:dkfjfKQ6Q`28]AHU8_hV1'MIuu#X24,(75Fg7<
h&Y)VYs-#o0brJ?e2Q#Q@4gF<,&A"]AB876<BUDgHWe$?+ZSV?q8nD:q-b`?SZJ6&\Udrj6NV
Qr)WP(B+M[O4%a8nrS[E4iMncH?(nP/V+;\OC4f@SQIN*u'"@]AI7%rW[nS3TAoG68#6?'O;$
QGK"d4@M@*:=$KuSk8Sjd%2+*:'bM(?7o<B&kG&"4B>bG4Eq/Ms6.c-dni&\89li.Wq>@L95
ScImc6!U=#6X"X'0&=6)N%qF^XY5D(E+JCja"Ae;7\,fIF>J1QFRI1SXVI@<"aM\._k_KanC
R80[,'Waa=u592B.B&0Y.)]A40?F\\Xe0rW!Fj9EP-X/7^d`WdsW!cEMX7]A]AuqI=V^u`Xi-M8
jBu8jD,4,ctbP!>'b#58QmBQKXe6+g&`dGd7cgTB@(lLi;2.$#M:i9:E9kq&c$=Y'f"rH*$'
3W`6+.aoHfO#4eFGYlcUK2"B7<SXcu![XkP4L7)'%4M5@WY5'#l2e%b_2(A`?(4+OQeMYqRQ
&'T94Zc5,?Hu_j#>aT0(JIb62_@lHr/W4gsLukbE:BKYt<7cOJG/=hJkZ]Au]AeCN[;<arUnTq
Y3e"JSf?S&`uC1maLlgO1cN&[uI;lk?.RNJB>';LJ3tjGdA?GFR$1qNM&]A7dOs\%nLI.l&iR
U)kcDsX(gRblW#=r$BIaVWXrf^ZYcL;*UH0'd"&H;ChGbY.]Aj.F$l"GJ!M()ZQmFhFj-RJrO
gs&A<r[O9HuPAYW4eZn5X,qnpR,=o5?eo?>5&:SO%8i_1Fie/83=1p>mk8XYOCU?3.-1&Aob
EG\\#Si5,)j&=!mth6)]A-3]ANs.bh+F>\>+F#"/4'IDYIgP%Rp@P2[I/f0U;`\C,_pF^SL6,\
()@\s%`>^ZP[`nn.%3nur]Ac1sWY3BP8T$81XnG!M)6Rs5BT_i@E>5nW5gkM<A!0X@YIhQ>3*
G2:M@,013?8/!R]ATtt3+(LgcsUZVc#0-L7rr0*.Hp))L#;Ra0r_UX_H#`aoD3%?_+$M\)/G%
/S<TbboXa!;(2aLPK3#.9q$%9dNdNrQfIp4\)`DSZV^hhNZ9%l/M@GObQs1HL<Ph_go]A-FQp
Xr\=eO"7W\$8Hu?*uPB3`079&pCE-C<,o>=Zr69lr*GmAW/1o-;E>`^70N`7\S=*HNuV_3:H
sVV"JN[(T6=m!G0-CHlnt)c?=D_bhgmtdFW)3U\=s'J6"QJ;E[B&4ujp#j/5mi$tSV0kbYkS
2jntc%"EA1"\#o(NR+,1T5WGd"N4[HH;J3OVcZE0hHs[>q'G!mG5M'E!8/(5:u1-(=E5i>.:
*;eM1=AZ#"L8O%/t=\OHj*$q_jB#M\h)DV;Do;oh+j,O\!k8)<V;D3AY)?QNhS2@'=S*\ME_
+C#W#rim9,j9a[N7L-nqPO1clYkZOZFrR,=OpsBkg8KO6a(4YkKos[_OZGOc)FKuJX4ojH$O
ce0aKhHiUQ-,m`*s]AX-;i#10$HpUgH5n5MWni3jGj=\tc2&MIJ/H0`*-4!8%VeMZai-','E%
O9U]A_6L!T"OkY!SHgLtU;BIu>&V@)H,mg)&K=7l4b"rEp$+cuSag^-8.M%V/C,lnL9rG1PrB
Rec-ZAR);lFY/NqD<]A64DrK&>a:%Cs&oA[k0-r%Ra&)+J/$LV$BZ-;i"5Q&.KGXZ'Q[8475d
(5(`>imIT@#-LJA<ZOj0m:T9Y%6Y!_tYcV#X6lC@cc'T.!d<T"24NgaL=9*E).ADXtqj6Xq9
Ai>*Md@M4?'pM#:AQ0n\-fg"oNH0iOC2aGhja-+N>Wqt8p+Yf8DRt";MO^DLM^ndk:![@$;'
fAqR:i?V$LJSd&KPkJ<r>hZ5Q5-,NOnh;ue;J7\i-LI;njK)AcZLl!$C-5hA+W8`AYm&i^KF
Rm5qbcsa)t4Hr6/pWBS#X)b/uFjgq(SE47Plsjp"HEY-6a8S@Go9D_19`%j0GE`S<ClS*@)a
n)7(OUpRgjD]Aa?u2RHr\f3P,X(Uiq>#5)-AF&BGjIt,nKbbqPJ`"gZN<ja_l:hH<cn&N$<#Y
9FnMg>N=8^'!?m;-7E=f=f$OGHuM(h@E#U9-[$9H6fBJDGHd\uS:+8'a&&?`$!2FelLU%_ZC
hJXsn[4ja[X'k0p::Ro-.U6QjWBF^,<kt(aOK']ATjJOCrY[-@n1;(9q".rDJadX0d9?o\Xi_
@N^Tb$1uXN,dk(c-TK)LLKfKO%#]A]AQ;\YUM1jT\lbZ'&cPiqGLT]ABaYugL2!=A3akl=Q8kA;
WS".I)K/i8<#>`Cs:+kO>pT#lSrT>T@Bo/@BmRKEPXS06<U49&gn\ot^79foB1$5?k!-EQ]A#
><I\4UJG4(0q5i7V@m>PR;,V[5c:e61Jp6Y=R*3W,VBA7gQPqsp$'>DO0OFV*cuOr[rscXNZ
Eer94&U^W-fK3=VSXkrS@`(\9=J7&jYkjCo,/cq,VT:2fs,.`Ni8O)?q(LQZE]Am?ubf-&=l"
:%48OLfHf$P9&D3O9%m-%hHI%U'E;qVG2Lq`Ak\PLLokFd2-3%?%l^Fcm*#Y@/WWuq0D>WQ)
/W^AgTt(.`3LGF/=2q*)$%cPB2J9liIF$_j`6lO*;QE_?8nEVPeh"\I.M%DhI7`a5K[.27!)
U<iUYBKQa1,;[H`(dIH=p[3OJ>Y]AiM6CdeVM\6D,(BLm>5DVVp3NC#[GHFcQbW`liRC1ecY2
rT(A2?<pX3?\,SQ7R4(1B^p<GD%l+l,/s#F4I6S]AK"\D0k?%"$;,5ID%W\?6j!AV\3_'i%KF
0!\VK`u<)C/@mT6a2FVo!4?%O7@BY=jD?FifX[3d>WBGb&[e\b'KM$R;$3,Y>qsrC&kR27k&
1)&B7B4ePpt>1B5ijL(;2g>48h(rS3n2?E[CR^STJ(=h`,Zu]AB!?G\_k_p^".-J4B<Kk5\0(
"oY3>mSt2A+,d)h93<0JjqsI;$o1t6lueQ[ao<Y*W7"taU9\1[5uY1^44tIZAsf=h0h4ei>(
IV:Ag56H3XeK*dP`%EN9Z';Xa4mls?p$p"]AK$bCaJ]A@(WY!8$'YgLuFccgA".ZRN+6WC]AV;M
Q`dklUKtqA:Zsrj!-29?a4:"sXo5i"ZsQ=s%M9G\psbc9HVB@Ce&FB;>b=o/&p6gY?:6@NS]A
H6MfBi4%$-6P@GQ(?Zs4\MO;=)iV>9/-$M#hP@+Oo'qYY@_r5P=LCHS#,J[+=T>gj6NZH*Ws
<d3]AlFDN"7Z7UtZRUfsE,/8=+hg,4?lmB8<;qjK8.i8UBYVn#P,;`Bb,<[kiRUS3l6rRW`ue
uZO6e*c"594*Hl5YOD'0^57Y@36[^oU-]Au,.i)Io)%G0er)ej6<FlAoGFkQm20b;Qaf[JC:t
qVma"=gbdk*+]Aq6O-EMU^O#/QoHR\%=\T?#g;F<?Y\\.$)a>5T-AYH=,Y0$CgKEsg;BICO8*
O2(,CG3s`sBqOS[!VnignaCAER,':]A6Df0lc"L;<I1'nN*aZ2aALAu0VHBkXeA%mJeR2hF#J
N,UR^aKh4$UXHJIWhLO*fQ&YNc4q5*k=!3I^^/HGF`Ee-Tf>lI]ABlnFoC,$Udbn!qn_iNfV3
4PG2^Or:+T7'=B?MC#(0.[2XA6#[S>R4&!1N6JNFVi9"B1!5;AOU#aY!+$\6edM9j1m)M!NN
ffNrfMhpR[p2#o_"V,Pn'ME)nAJic?sVrYR+%7pQ2>k\Q/[E;IT2%\m]A@QuN.clF"qV@(^qD
P_f8b9T#CK4G5DXAE#m7F'6,Ds#9SjQA@%!9p4lhj\P&6f:k$t=:Q?f[R(L;Sn"JMk\$;Pab
YiZRB6h34cR*WWEf#(e7puc1GVpMd"'JXOWIst<C4[)h76@fKDcB-GA`m'U,T,3oE<>9?^9_
[$sT8LI7Y0)*,P=G<G22R'TcuZH6O@<+k\FeYW^M\OhRKEuF\S;[`h_.!L(=(!:!?%J5[lVV
bE0$eMFU"6C+fP0M7p/&*k&$dP#Gb>cA:S^A5>0ck?:$@kMm#acS,2bi&k&A>U%&H'JB+W&a
R"H5b8063Z`>Dd!2#iP8.%\u9TArf//]A"8np]A'7d%O6P[?B<<=-908Q7nFS0/BAO($oi=p]A$
WXj8M/Ui;TDNKBTt%`[O,SfloJV4K8B[87`bPLQ01@nc>N$gb8Dc#jrS`gY7dDdr@H-gO9S1
b[3EYi9;B.[SOS3OE1.l,4.:`I)#^RO4,M270'u(klCF.`pg)YW&@+"a^XVjOtfl$e%;qc[o
7Ak(D2'n_']AD[Q."/-ZSRfDM=p*priaLq!ph%Q9FmUP8)s>1B]AQbi/@jEZe+6f@m]AP,GZ-2t
.`NAsUn_i+Z%>2dCmc6I?;fkDG7e%mL\2`AFV>nrZUTc\e3p4U=:KCCp.HSci%LUdo)llJ\'
$p]A4rbt5nkme7>]AQ[E[";fa,5,",*$R$3@[T&4Feod2U^7YXPe9%eiQdo+\JT>.ECU\rDGpX
Y=TOfdd%,<=Vs'(Ft-F5DUk5g@2#kZ4ui:#MlHfVuhe5MaC2D)FMWP%d$Yk"(\;0?a10Hh_D
;Bi6M+:U\jF9p;CP*/0@89Y=fh;'M#!lKPa$:o@O-/B^"nEo2GY5@b#hrjre]AoKj^[J)`6)9
6`eCTfmbPEj.p-VL)QD$Fq@S%T_JI:"#G%QaI]A]As%2UeK\@D\mcPb8+Mqj\ZVFqRP-%&,DCV
XG[G7i-$=EUf)^2rLimQW[;'^/W;47?Zl&g?7+_\;D$nJ]ACb,j#DA:3aL2]ABQ-uVN9FMGn0'
b_88FZ@P4ZA/)HC+*YNVE8W'9?06YUi"@6W*iRF))"g`^3_<r\Y;j_,?C6ADTDE9bRormU==
F]AC2OSnZZ[5kd2?lrnn9Z;K<,Mmnq@n0f*bb?EU$UqKA9+JDJsW&B']AS-MQ7=:_$T+D0C5IT
&BVLuFBhe3+.h$M^*pY;k>`'QjG&eu:?KL:E6&(U:5aCQC<3990F0ZrE@<L+IOh"W8[\B0GR
!g@e7i\\S=#+'8d(8JU*3DLiHu_W'Zn6mY-7SI,,=jWH#d6Wlh;cM6&1h*VMNqt$p7P#+W(%
l)A*:&NJF]AF2R@usS=:@EMUSMK_@I[B)+Xo]A1JMhB>]AtHiB.%%L++]AjQOd1:[I[/Gl(m.m4[
ic-qVShWg#Oo\=TG'E*@sZmt270'g*C7`-R[trQb>)<BP3[h>_[t"R%MiX/>Jj/l%S.1?^g5
@_g>`-[BknLHF.=T<nk)E_@MW^PhHL[2*!+m*-->&d%\tl>2Xb#0>#0^Dj,e[\e9C@"KglU7
W3Y"/lqEg[L;Oml6.`TR1\TIW_q$2!HZMp8-!Fkmp<qB&m/.Iu4prH(cG3D\,P.lmotf6!b!
$tZ$\X.&MBT6&>9EC_(/VT\%hRhk#m'Pea<`_?a^`%oU<2NMRXCOd*^_$4BG[Z@h=ZMW#Mr-
/&lZnM?n(AChY[4pU@XHY>K-8<kB0q"c["lZTQdu5-+`dPNTbZ<j3LcDH1GgCEPCPU>=5q<L
aJ<D0$&Y<OKMhG(S@THe-h"DGjGdmLaCNL5)k7:T<Dfe(c--pO,Q#C\;XLY/+;7;hJH7HHSj
17FuWW&dG1:+*"Gu>DK+82&S"_^!=/nF+8(s71=B[YfhV3[^M>`q<=0CAY9I,ZmskmjMdMb2
2s=llQ+q9>5scTg^#j0C5%dJCCj:37E:('1k.[&$>;5thnGVRDQ"c_BE*fU8kEaR]A-0Xrr'N
<oaXS.hFf]A?:1IsL2fg/2]AqXbT>upgKI<P*>Ti+Rl2!;Rogg9FB*9ACS.@Nl$\pRh,CMF<-X
p234"D.RjFmNW;HJ9i*T*/D!)im[ihUQ&o=8&PIG3<nT943-8kapjm_U.0C'sX`pS+79:oo\
mE]A_*6'gQDJ"'r<Cc/!p9$D"/AtPQ2!snX`2Zekk2]A'G<H/'mA\._.9$[f<Z8t^CCIhU\r+*
CH9&G"l4O,VWng-opFk@n;;X.dZiHtACRV2&=eN9Z0=G5&UU,Q0cs*WXdc*<Tr[QG+m(`>0`
HQ#0NbV*Ifo9tdXmWFB@hr>D9qS$W&]AiA\gF?ASH?(oqQ2ah1S^JU2rl=%)WCGCqt!*FYgmk
96`7HE*G*<-;fMq!Z+-`VQJk0SR(OqZu'D@\NFTXk`t@aoXfW@0-ALqb;EdJ0kVRt('4C$bR
\X.(-'T?X1`l)[OXBW^%JC85>]A'q?Q2#La?(bF+jC]Ap8[S5+Bu9ATaSSZ`oCGQBR,o!q5Jg#
o]A#U0DNQ-?RP#*f2)f7s#*TFO`-S'4&Skr=/[E5>!VKOi2*_OI>6OM:)gng:9M-TR*qQE@6$
(^`dIJaI:-b2,mh#=[>AMsE"OPY:tj/[@LIFt'rs,uLt@TGM`%05<)gtnBVGXeUbO![M`/Hs
(IGi;,D.'6+FK%]Ab=%1NDeo?.O1J^iK^6gpA$k_-<A_ZhFa'irZ$/b+N[c4(.u=J2db=Fh<l
+#f&,gtQ07OX(TNn/67-Bm[YR^8tL*V+*GqpakXNYFhU@-qEMjG#YIm*]Ap6Lk;7;ZXe>ORtS
Eo#&YQ?4uj`P:KetD1nD#P`8BeD9!.acqGe3B,0pbqLd<]AJ9q3S>4a;7-\p$f<(EK*<-d1Q\
n5W_;"XoS1Co&&+afc`m17dF6a4#8qs9qu,;N-M*nH)>Vh]AQ8QTTkaq-,'uJCkPNIt"j]AE$o
PA(XItbDqc;P[T*[]Ah]ACRSFKSY9U/7fr'X<RuG$kjH=tOT`A!_'A3i21]A$9YAU0\p#&c#+;.
,mEF:.\Ii3V<B(LWQ:`6#]A5TLEbBL4p@>[O83pB"=N*Ro0rSDJ:E6"YL2MM2`<]AZ<Wk=.oJg
;XD5&IM!4Phqd8o9hqrGb>H=^P99S9W!=8iPX;IWrAHT]ARMs?.nkIL#O:nA$(X`08[U^l`XT
2[]Aa2RSpagR`1i[8b-#QuS3RQ8_.P&i1r&@oaN06W8tB$4pY$Z10B@_R7uG<%FW51,&X.r0$
$>\[?fsH#\pgK0KuK=`lqccSWr5RQMnE/.LS\T@dh/\hrMDQS5_S(TNJaVN%,V''!qeYMnAr
]A#BT`-Of.;u]AQJWLN>OMUh)#pJV7U%%di(L4]A%69^d"sL*D8kPt`KoYcih,Am>%c/DDDkP\.
&iN=8+jMfWQ=ri;JZd7C7.dmp8WO&@#>->GPPBN-`7@hT)e:Q\Q'P]A;/eg`CZVNt.*U!*r-Q
#S:SO"3lVfi=hWIdXoL$Z3%,"Is$N4CS+mr>WrFMepb"0:s(QrUaRQ4_$T]A0Y$hje6]A75Q4c
"_Dg[KND,\MB^.HSl?Ic28b%.Z\0D</Lcn5*h3m=ZmHRJ/F%o!s(0gA^@QKcDd\Bj?8KbWo#
e^!+J#r0c:Z@SH>@Vg8rg0&WN1`ZF'\<[XO46S.*c:MS;)5'O+_BttW]A1.h"[\Ti`&gRB^>p
,Bl3BekDO@aJN&HBBMZoAnncfl1Wjke(g%9u!ehY`c>q?QIY8:boh_]AF,G&Z7iIQDTn>([GP
;i66KR3D_4MqTE_V!p'gl"O0k>7`tMF<r5eN4qCfOIip)@0pl>hj[nu:+[S75#q'4F=AXNZ.
LRRk/>lShn5/k#XPB<cA/LoVo-dHp%>:HG%rALGiU/es*iQXeu/0:mHX)h65/.E9Cl-I?4nY
!LcW0#`\c1s<[]ARQ)d=olbj?1N$#@a%T9*Hk<MW)L*sTF#N>.@tSF+k8s2<F:e7.aT;;")`Q
ebm<[`sh__"FaK<CtucBe"2@cn47*h%<+NTZ$peRW'Da.^T(`A)0c%p\*BkrNPE/cDl.#/fJ
$b[M9d'l)8[?^aK)*IE4XCN)q0iH5O!M-HZ`[rjlKFjUKQEG$Z/,S]A=SHSSV)IJu:(>'>FCL
GDXtRKkRsJ6D(U7CRKojji#-WJU>>5(dDu8UU4S.R!!f6nqr"6Ha?+?d)6bT1tu^lUH^/t.4
#sL]AH[#[N^6/'(r%XZK_IZpk0j#/R!CgX;=3441NH`q8U%+HJ2+A+eEc,X*BBb:kfp),eT9?
-pt%>]AGf)J93"`k[9/+FD")VB",TtXC:5U1C0[KWIhI9RC2l_jtqit+qVt)^g0BfSr<Xg7D1
Wpen-6?)hqOm[IT4;g7QMCu9:9CL[Wc3+m#^+VY/<I.W8_GeeAjDkt&IqW^9.f?UG<'Rlru"
&Q!k\=6LOu/9X<p`u+'gq/oDCsN%ZT[dj6I&#\=hIq@<+">p7pNBfA:/l=6*U5Qp%"2^[*/d
q'%9uh(tfSg@?&H"i_S7"go>A?D.<JQ=q.#=T0$[&GgATYf%n@8H='g^1f\=`$5da0pO[UJ_
FYm_/"+R$r%\MWROOH1T-;o#E-KT>UV^m:Oh]A/=gWb=!$YZT*/E*\.CW-CG[>rgl*II3g>jG
5:V0kU&gn?bV"pZs?Nr&GGm!II?\qMr#X1&H/cO//m]A5s&'cf.<p<1b[*"#c'L6RI#$:>k+e
P=SR$`P/jKDS<@n4G6P2h`4hh2DmMF>m\c3E&0pHNjr)4#A*UQqXOUGg_l3N(7Knr$'#nQ[,
md%@I;M5e@*c#pj"%%uG7B;O54skt3aN\]Ar@oSCrVNn]A6*J?*;KO=7Cr/7loC_?Z-K&J=2ZY
c,8_&arX7XC2pk0$G/p9l=7D#H-k9LUOouW/OZ3;bXb+)k?V[u+=l$fl+!ktC!&OYi-4@-g!
srbYdn0Kd=8<)-"S0BP!r+[HB#+W+%pE'Q7@+;B^8oH<KVkfKqPB>a%O9U"[hN!c^[KrZ0VY
JN`fNC.Dq9\IIiNe7(lso`I.%>:*I^"q5c<XN;Y2HD6rRnPoBH(YJi`h0,fid$N//,rbk6O\
+;0;?f\SN48%@l,`dOEVgo<s6uB$FDm7UoI@L6@PpY/C5-Omg;C2,OF8t$DpVgTgl.lZF^R0
$uVa^9:.Z^Qt;d5u817sZX<>G=u+Fb/2&fE-P+e0nS3-dT)1YQ@r`lg8.qdH-??N>Zr<3Ur,
\Q3o@P:74=lr9K\mBS[FMWf5)%\=7,gkr-K^>JWO<Rd`6#!j4PS5&>hDjU%eDoXKPrh3T>G=
oB4(XfLjWj&ZPV6s4[)eJED-@mQZ8AM5k9;#7&L65fdpn7^U\OS+38-nnX!Yr5hd/[.L,sd<
h;7XB19K)RH?.uV_LiYOGD]ATql(HG"[UZ[C$*)[:,f)b>\[IK/$=0=KpjB$6K5DY'.qg6Ftj
E@u]AN&GZeI(i*(3E<#A@"u`IX$5k5n5mm$n)2&cV57UK8Y!-phL6j0Q+,p\14,83as+#2Z1h
a2!LG0gXqakb_`&5$*[CQp\+^)`]AeYC_<HVpMp='Y&'q&U3YK><8^%36oO-8Cu(R<M^3PX3!
n.$fMop-p/Q'lNP/gindP65rkVVG-j3PXet2,O3bfXqg*lY%LO=@jVOEPGdVmnf1T!+%ZjcO
fHG%oegUHLlnAKOI11GY'#"LUt[+.hQWLU'frF!/oKVMQ%%\`*K<Gg-Zm0OO7Ll/B_UJ\CnW
H?;\Qp4cpT1+W'+/2QI`N1l-f?Z>)IBp(T)cM85T"K(ShjK`cH1-jim;X@f7kk6EsjLLU#U"
iRBhbQ/<7Hhi(A'U/h5I$BC0r+YnUX%_Gg,[%,a`p6JO4`Xm(Z@U&^`'q&'NcA:ZE]A))r?DN
b&G)g!$+^ZHT<'I@Yb,#=PC>p%ND2u;(&'Is3Zh,@UU6IMo.SL_.<Di=ps6#J/'7=9,P@EnK
=LK!%d<\QnJukV.DCb?0T`2\#h,jThr$44M$fVma?K`q?E/de&Mai5*-C=r2N21VLQ3.c[CZ
,eO%Nd!J&CJ=p+ES[ILn1d>?+tY4_jUaf,eQAPT8Vc]AYO_T5j0@o7Kf=(VVgp6$k?TbhC:e$
*:ug(\\oH-m+5@l<OsN^%aa\ql#<m%X!$'/??@=BDIoPmV-fZuY63nCt6j/2F4ho<UnA.830
sq`V5$p]AOaFR-%m5Lt%+F;!24$uoX4qQnQ*Iii=aBMK%U)[(p!ne2G/XGu;OXN3)Vbb>E?7K
jmMn8;_*DiNK`r)Pi8f!otam,b.<YakpUDcCXT`J4dC[MGD-'Zj"lc7Bf;s??:kt*'T)OajR
&YiWR:<_fT;O79Kc@T0_ne,FFoYFb_"G5e3?h^*Zhh<^"bA2KKWfIKpK0Pn*3ZRPV35<cIkh
A[ggiKol,;*XNYMnlfPJ)>p0Y%OG2r@dtCod>?,L/C<CWfFWf:rB<>rcQ7]AIm!kE5+X&Lnn?
=+S=MG:'-sfrMUS6m[>6,<@3Xf#s"fH$._l]A;+FZd?a46Y$)s9ceWdsJJIHHg#19RA0%GiNk
VVid!\;P//U6*$5UZ&tF^YbuklMPJi*qLj+oD^fC2#%,g.hI:lWQL-S+XAh]A+PJrMb!95FZ'
)ql3758GP)hnJil=EL-PDJaf+r.9g/CkAdG:Jcehm8.;;Y#.mo@9IkN!3<i8sU<9(+`(@d2B
lL-un(e3L#Nu@hI`[s2%@UGs,),"-ST1-$9\0i=$^XANRP,tbuF+BL6E==q,4+@j[S,Z7GYZ
!T;3F%Rn_J+Mr)QmE+R,);d=DV5k`(o68]A)U*f5j#Ic)U8]A$D9%aLTA<6\,'^g3J:4BnqKYH
:[9-7`g]A0eUO`Yb1gH"6;rKWtmC7nkf?_J*Ps4tQg(<SB/W6'Cf=>M7T8u,QW92D`%d0ga,(
DB3lj\*t5@amWp;DT$I5J(J>BG=?GNb\8TYL&*i6K%2LZm[[YIs]AClF"gtCFqeIMR758:">I
7V:lb0h+edCi00fq@qOq=nQ>0Knh4ejK6ds5#C9,d:>jS#i-_n@-2@?VR\DH[Jf:)a<q_a2m
g"DRDE'nm&=l6o6<rFklEQ$6KZDI`G*:LOkV/AF$&tV!$cUa53/mPbE9Z>M>TE15jZj!fI4H
T@5p_iQtE2iXl?f^TrQaqek*bI!(eaJ$7qM@#a_qrf\5+?6Dh'F).QrmWUn"$JC$49;eoEp8
1619/nn-.14aXU^=&.XN?Q'pNZZ2n0j?+^PJ:Fo]A]AILJN`(]A#QLl$A17]Ab&RE)@hS"j92a.[
H-'i9'"s&`/btmURI4_4]AA!.(b'EF3sJ"/?gqc@ISU@na`5#W&[>^2>Yi>FSZ;NWrgj%"64u
t@H?1cEnd"=g!!c'h;m?i3M(sWPF>$t'29PTS#^c@j-FpT.abp8:n)8E31eQDu+YQ_Y+rAR7
/khV!FQ]A.,C0%Q1fRC=!**33t_j-FEe)ol#i\Ed7N<=&/=S)]AgM0kAGE4OQMmaW9VjVLOCV*
YnbBB%V!.KleBRfXQTCenlm?drg8I7MUbdK<U096;3Y!ai.7IOb."I(Q5NP:>d>#*gD=0-;r
UoH=d<BHf<AjPYblAlt`S_Z9Y!]ARD7G^Z!,)YU!"=)3W0\=jpU-R_jTsb"*D?SQk^Zh.WN8i
UL.Jih1,JR^\^h8spRfB<H2aXSU,HJ"hqcV('ma[+t@/LWK9#s6.]AT\/!XV%ZlWl!,C'iSM#
#4FN]A4!fM8(&.@S\3cjYPjLL+A.kF;JW_")kGX#D]A<]A!L$1W]AC]A-%dtY]A#4%/),Q$[,4fQC!
q2QkV-[eti+%i:?%;*D?_eiXU=o0Hq:rl?'<%'BfiMUFZh"Y_$PRdsX_I)dH;c>_MkK#]AZ6-
N+McqF!%5HV#g+APkf'EXEA'9OlsBlpJ176D\?VW*!A$+.uD_>4tq0LEc\?[/]AmPK93MSFo1
?,%`s?7$Q3<"$'WFAVop2=N=Rl[-7cpB:`]AQ(/NiO*YlT#l:77*F*7g%p6*nSD.8=Dn&#5[7
n.73(nkdU:XXI[]ALo;hPfG7sh=*BT68H@LC3EVp^TsHR7`,$L#M=@qg`PI1A=/"mI+bFRYDa
7]A/s<,R>KN1h)pO_E6eA4VUM(C_hbYQ+N2kZ_Mk;de<q,!Fe>^?C)%me#`<mjb//Qit@>L\G
l5i>V*3nK;5:d-a1SQ90T2K#(Cj+Js@DY(+mf=A?p2-L'P5FkkO9Lkr,nZ=VN-B5%j:V$rNu
=C\Nb`_t7@i?("\:uhg(Bi+C"IYBKfkOukQmHT$"F'i=8P2r"b=ns,hRHjCL+pg$4>3Q.;,L
`od2U*%\08b+ORfR?UVZuJRZh%Z1dCr$t<bE_m$Ci<)M8<2iGr',^_qE"ENMRO4(V(I%/gZq
'Ya(q"a6n@L3!b&KdRYm+\Xm6-<beFTKZ,keWO-6bH1^FY*KW(?*CH(?u_uZE`&pC.l9bmS%
=/T&9)`miD`C@qH&t$@Oj.hb'fQ]AbIGiR0HbY9d>`g?AD96HOLe8Hlbou53t;:Eru)j2^4Vh
dL\U2<U>%XkE^.07`CdP"&ef=g'`A81X.=i:PV9\47-r,=@#*#"ZSgGFFLJfr0#h\E"U9(>i
Qeua-;4C.h*p*%glckJGf:QS):]A_bc,ln2a=O`GW"@JO/?.,+\q.NHR;-;n;o<ik:pLI[nmo
QjH5lSI+c@8?&%(hec.3Bh9tpa_\k0_VKH$l$h5TZ<Bh$WPaBrFTB"so`X]AdZ!hFt_nhd>?.
IUaH6B))Qlh:WcG"U1k+IJ]ATKF#.HrI.f5hIBK#Fq0>A5dg=kqe@BD6q48`aUQO=f^:DiI6m
>u5XA>_F8qY<2+2ZfOj`;U-jRQ(,QJk^2jaa1!/$DVC2HugqO#4h3;JWc4c/]AQ^jpRe8i$R\
(nX)tG-%q_5#%fa8b,[l=JDAXZi[pCkl3EuBp>VYVa/bP]A&k$D>=OfA)Tj39?=F>l5SQ8T&I
,oHAAqOpqZ#roTXM5u9Ve,MJ7mVC.,<<1^aq,cLeBA_r;TQ84Qg@l]A*_LokKu\7n:l+Z+E%t
Ur?u%f"dF=X4J<^\rr/JHqhk=WPQ,+BR*,WNq^ER\;(%a`;UV=X%CKg8kGCM0,Vl#@&#mP[:
FTcUk(2CURg5$2CDIsk1&eG:b#O7=?&*1tZ6G+&0cea.aRpW_h-D,jK-tDph/o3U1Ai.h4$e
sB(rY(eA39RgJYqSP\P);T5pb`LQRq$]A(-Z,%PQ`4Q\!A.=1@WAJ<6&BeE8cd&E>^@L;.Cl#
eP`T(SP\@A&g_CY;:uRQ_a9"2+e<+:1VYoFi&.VMQ[$)n#,K,7!4!Z#UPW9o4Yi>OcVWh%3B
F(M7]A6n?00$NdiE)WcU`fR!#;eUfU$>Xh?tF':F2W&c`.%FjkCo:j=D!Qc<(q[KU(Fum)V<(
X.$]AA2pPeCR8C0p)VE+tC7Bo;L^tcQQ:R1nC6AV8;")g',m.Cl"%o<12BVc`ip]A0q\nNQR%r
s)29J6ia/fA?VCEluPel34@lH?`7W=Mu;Ak[3MH?>d&/-;oS9$E>r7Pufs6`DK'e>W?J[2n*
>#2Eqq%e>_%PGp8U?q]AKau^-o$gNN&oAk[>aE(gE1im*JqID40#Rb&J-GbNJm_@g&W)eOOG=
K,'m/H>1@4+\$9l';&ZeGR?qkNDp5uQ[#N,lD(?9O5Qp3Q264]Aj`@oW.)a&miNKde&b!DJ$>
XTG$=9Qa=MQRbpBCUdL4;lDQ3(g3MF.=F_3/2XkW!*ii@.o1'BT#[9$^".AMl7AEbXAFk6)g
"5-.Z1;,Y9ASJd@0hmhG@HcVU=4##ktI?Yn>0QDJEHTK3HV6PO'iY*%Aoh[E"'4$3Mi6$kr-
n^E=reWQN=\<L.j`b,-S;5B/_<:'T:Epi2eFM[p)4i6nT[9XROOU(tX`ZW$Ic.H]A5>rkM/ZO
2+;D?G1-ZlqHl(i]A/cbq7A5*QET8W[S?&'BDcR!=4Z:pODsRH;1tpACp@F7:mBL2a/8ZYRl9
/4,B2_ILHV7[9#JN-+%M;4au"2tf'o,d2S^3a4QeEA/P"SfW.^aEmdKj2(7`D/QtNDIOW=#o
9n55QZdA=W/\P*"rBI2VlLUH47MHR/^R&`Q*K0'/2'<ZLo?i7O87=Csuu4D<*VO*=<llSkD<
@Bg#C"a+=+$Jnp]A&1<a4CNB+;,<(>W+Q.b=r=W%`WSgX8o0&9htKt>[FQo8?7TjQYs4'&SSJ
)A@l\?+mjiP)IIHZ"c#3PE.NYieCD]A-Z+cahHFf<S"01eY%Nc<!:*[?7%M;5n+"3BQ8B??/D
(`X6't]A%1?7a:Csi5YqA$G=VGC[W#aC"ji):3^MLQ&'j$;+FU.t9&jb@3INV)g_&kn[eHV!]A
TEj]AXao%1b;'crm[ED@In#P.AP&7[e-:#?>fUW:!Z[*R?%'0\Pq)'!NFtf"Xc9[s#0!$suKr
B?HP,HXi\[Z,3M4fnaar3D\(.5\t37PjO1)4f^$8bQDR6G<4%-Cd>h7OJuHf)k?NUFd8j5Vg
F;%Y9trZV?L7LZ-e3l$;7MOYro31"jn^j_-(Y;H*LMi4pGB<sKD;=HBI$IlU[CusI$Z4,[7F
m.b+F8b5cq3Eu2!D4:Ll\E,0ip8kr"X2sNg6]A-e#PCbm/BWV@^:j8f__)HsD9q#Z7fPC=e*=
<C"$9[*1cUidb&f%R()t`scSp.!Y&8/^6`AtA7cXul8fGDt1/r0Ef)]A&;NB-Q`Pi#VM$od@s
gdcGPH8"*',@aXceU2]A0-.eN2WcIeZfEZop6)`hh]A+u9.Ia>G\=m6t)aK+m,8m//<c^?]A2[Y
A%e$^!VBC'"#!\?E3I$odN;$E2dtk0/*uWi*U$a8EKhgas:Zl3QRpI@iteKjRTPp03n[)?_Q
sO)ghXRg,3=Gl0*eQL%gkdMX5sp%Wo[43%>$`M\7oYX"f@qUftI9etEeJG2MmOi*6cS:CPOa
8,DHd:U,</iSX11urC4>8!^Zqq>>KNFt?paghoO<4KUlQLQaYni!o%e^MtSm:mN;mC^/B)S[
b%i]A<qsORT6Lir3(`nVMmZ$l!^1U(qXNmU6jX]ApPe(FmfUoImFfhW)2jVg>(qsoKc`?'\M@Z
+/jB;*sX=Y?qcpqs7%6>S-/ctdXAbXrPpV4hnQn[T3iRVdI?\>V@[cK7+#06),<E,ZFh_9q0
8$WQ<"X'q<5=OWG4fGB9SW,i/k^YAM[=4h9QlRKW)Z@5J/jVTd,dE9VIs)Nic+JnNtp\I&ph
>r?9;/%ICs4i5*r#J.@::Z5M<^ESrY(<)`TbjI@8=f$P?Q<%HCjO+IE+mu#tK$O&b+I/e1_Q
iJRS2*+es1896*U?.,4r1Tf%rTH2Ymk\Kq&HKd'K8/FLVkl&?j2ib>`B[Z7=%s`mI]ADM9"mO
4'<[J'<lJ)'0&$3n68Ys651:>tWM'n3,-pE54/tq8@$paPtbc9FWI19H_\u)Wron%jM"GQqp
1*rB!1+nc`p#44MJ#jbh-L<qL4g_N7!8*^%]Aj\n)>`7g4/og$?ib9k-E2(=!(l8W)>1LdcNP
KOVh.1S:h+Y^6eqr0(:F/oLeM7qo&dM\7ipp+k6`6$JcTd#AKZHI18[.bN=L6Uj[okPCjhqt
sZIYt=d4ssBKHecZH+F]A<#$M!oq[0[J<<g'BJj\3/0MW>G0p6oNn!A*o+JZs]AA(egr:SQSUU
#Enu-cA'9dH\-:n\Nc.P6\%J6<<Lr$%AC=X*pt+E#=8iZ5._'GJ8db8b"g.SAW\i4Id3-!*Y
Mr#>VBbp-cIML/7Pi50[GE^3/PU1'fm\Ahf*$&C,FoVMumH)=@"D5%<'N\+-9pT=BI,o'EC?
<Q@4&;i@.1i"II,$9bbe,Sp&.O$Nfudf)]A4?rOu&"[(G/^mZRJLN7u:ZrF-0^MG:)]Ae!*_?J
U?=Ka'TWIXHUPej`XO)T*tR$djGHjbGC@AE^<X8'Gi$)o_[aWM26]Ac`3`OOpZdL_iQ6+IL"O
h,V7coIK0F<.Vag<(>sE\q<+$UY#)oqs.^::@his"W2Fg0<1+*QRG+f>Wh$b'N\"0l9^mqJ(
6he2$+'O$B*E[9IuED_E@nZXG;ju&!G`O:;&(JS.t;8oi\B9V?`YY?<hj=;QL2Yj?%;U3i`d
o&b\UY80>"B"/O>#$'r*E-f<$GX<_Dr[Duu*>mm4-1:Sr=hHuAbObu_?nZO!ZkR$F_[HbD&<
h"5jaoe!A-V\n[aMVS^4!U"$3ftZMqGO5"_r@JW8ljT6OQ%NYFDEm4ch9W`Z0+kX*.jRA^$"
`gL>4F-D@ZUZ?hN?X.'Groa"67Yd(t<F(^%@.&!k:s=lF,/*;^PmQVFK6Q+*Ca'q[>c6+77t
HW$@63pLB/[aE"&;f'^*[B2T!V1lLG)Y^.O/n6^B7p^p#id_C&?9qCShXtH^5%bNJb*cXh'A
rm.j?)I]AOnS_kIAX(R;i[@WHi,]Ao[iMK,`r1s=m><0YoAkj0ShCK0Ra^[oJs0CT>#<`9RZl=
pVc;"4=/aVb&ZX?AiKQO%I@)Y9JK95W$$EjKcJM^9nJJ?SXbBF2i;>*/2hiMCMC.&bBP`%!9
R924uDK8@-JFKn,S0u+CLgefNQk691i'XH64TqE/"P*H6r$/7-(/q[P55_']AqqWt`Gc-f2:_
!0@TO60%='mHfVS=2=mP1U?U;!]ASG<^uEM0p(;8<m]Acm-7`@=<9Y2)"=7XVmqXK!,e4@Lg0F
ujS\2,jXf2=4aSM<3d@pFquF$f-=mK`!/WZX"^mI_rq\:V=T@NP-FWg"W_Wr,=nh?&r>eH7X
Zr_\A,i#c<JZHFJGV)MIeDGO;>a/hqVM]APj3VCp5ujFR:aIkK^kB5:?9I&SBrPrY$e`(K:27
2!hejZhLn]AS"mE89.4pq4)Dp1U/%QDp4eG(M57He4-s(8PhT2-*]Ak-An8PH?\:V>b'Le>'Gl
Lomc.SYS&[^GkJ5p:$%n?Q>*r\'bI'5,[mYaC%?'c-@8sQ<8=/lh@M$IYKq(-G[L&hTl70=l
I@*8s<Xnrc1=V!1%QWGio_!CfZ*2lJZ#Sd3U/?$D9"cd;\#;bWq<lB]A@p87usnjl(LT]AOs@d
oTsIkiA`<_#4J)m">`D4)Ca)q&I(\XAqDJ$uHi(N+2da(i(.s(.2[J81---q^5^4!X>3X!F;
*d69"8@pA^Qh!d:Y$+@#j6+Q*@SPAXGchdNEDY;/dl=84jW3(R90\'2%t/CPg,^dn$VUk^X;
3[gbk/&K9X?W9L97IR_RZLOEg<\k&dIeT;5cc/j>)#TS9fVpA:f5&):&VY5m2gEk`5#&r`*@
_#/BprQcko$%lUpH!I5."0DQ*><m9,fddqmV([XIh,Of-2JWLDjG#pS^=D<V5YSXK(U*oCp[
2]Aij5OeJIgmB4gA:XsSjJ-EV$s<]Acdu#Jj5:5X46_5rp0hDj.iFP1FjbjT-W>g&1-U'tqg+,
/b.QiSWJg7/1Ap8d-Za_?j&5eio/hG+L@&;$6Ks*IpH1*:6h;gV\'$#*57]A^-4;eC&b0Fk(o
Ef_(5\JrJcX6XH-M"ci'iRZKePccp;^+U`+W7M!o)X'KJ3:m4:!JYFcbQ'\Dr%W?5[+/EhS&
U/dBtmZ[lT"GoFgQUmd+rl)^=Om5["Y'=EXQLH=XiNY&mPp<uqDof+/m2_\dYo9]AubHpVB.9
&:g=6-=bWk3DA6gpi)[Hm_rDuCBU)j9Lq5n+_3D?30u'1'@IE$28#H%h$OP,#?![dG6R-u`I
pX7n=iPj1E?oc"9$0Kb@mTLlK-.E4?L??m"q&V4'$55UFeYn3eX4\FMa0ZZsAsg0Z]A^XIdk?
em"@!&;@Bk7?`."CLccH$fSVu^*gDU"m*[CX,YHJ<,(0"d4@++!"V#"9%UR5q'3U9c+7jjiV
i?c(3%6+HR1K8P"ZG91lA"Ku&DijoN'n$Q>j#/$0fp\QcHuR2A:#1XW$6,)s4.MWm!%E_OTo
;'5\hpk'MQ`qHOr?;"]AE0P5if,m;i/!hV57%.Re8!B)D`dS4=:565@->+U1N,0$2c<^^.XbU
4Wrm\?/Hr@72t!l"R6sBi[3B#R@)Bt^nF0L4315j+`E(@.6"GcN/C2&\@B(`@E:-^5.E7$C<
d2Ug\%>$&UV!FUQ#Atm$<J+qO`SF6DW3A:rfftHDuV`if@[/8WS#'cc#HI6?<Kj<4V/'MLIL
0Y$K_[)n+Um0$7$/LH;OJMEdaJjKZ@6ni3Jp?!1J#5+\pb%8C6\$$hr[(-Gp#'.OYj(-GXg3
`Wp5ki7V&H]Ao-"O#OWjk&nlGB?')?:n'TE%c/?1J!LZi2a*%[*&Y9)MpV"d*cifASIr#;B\"
Y,ff0tUpBqUF+<7#YWo6kClF&6`J*?E%[<YQkg-B90PCeW*?E<1klM6>451di37t%@aZk6+&
MWX'KSK(HLP!53@!-K*X8>PN$V1Q]A"NX%j62kEqK"B9me"r(Mp%(F/`]A#KVI5c;F9&qDsmZn
M3@bNJ>u$oK;caX:auL6U='9[<Z%Mr/5I[D7gCLPHFqqSW3mgjJ2:9SmB%(FGe2YVtR+ih7T
5+P5jsI"U=H,\t2<HK*Xp^#<Q]AQ^nmFCG+p]AT$ooGV'N]A4/Ar@XI*gQNFSVE[L[eI_d#4lY1
f.0p`Ubf-EN7\65n=aL9KF7^]A_:KVN6Zl*i--;c4:5e[P_?5Z(dg!_gsHYXf`mea03%Ece>0
=hS2An(s'+;75R#ddaJDlo/40ul:]ANG!?e;4Oj1q.t)CXT=(>FH23t*4gd`P$)AOPD-\0#W%
Mm*_>H.NtPQDcJ)&%\M:7.m0&[f,G$"YdA,:u$&GJ#MZLW^J@^pi&Xo;IL$+lqQ6;c/)d8,W
*OGZ+PMhG<%9WU\?3eX*N@I=SK8$Y*lk6XCSI%2OnP=i/]AMOT<L'K]Ah8q1J!hGs^h%Cqn3\D
`!<JoWOJPt;`2(2Z@=Lq@5P2E%",<+f-#hn*g>7?q:Iq-Gj`c%1htK@^Z1kZQ0^DM]AQGR,tF
0[s:"Q*)Z<"H$sK[/>]A.I6#*WK2<Vj&TbQiZ.ra8a%mfItlp;P-?>+\EqMRo6[12U!ON7pka
;V/d2Ad0%Xl@mG:aY6Ys('_A]Ar/p_Q)F>uqbX7B@,&0D3YQ4]Ag><`RL"^r9#[)l5fC&PV^A#
O1Y>^ce(EcUu3#T/\Be\!g?t3bXXZ4S9GHroAB'>^tjI%FeL:&e`-CKo`+VZO)gT^>(8U#>f
E0uRIcd6gm*@KZG0=4RYuS<3W8=IC3p)[OKP'Z`H&(@JtfDCT!T*d!VYDT%uBQOf`c-a!#k%
<c7H0;I(pan)$(]AQ5B8`P(r\_Ubkb4h=^IHH*RsD!fa]A,-jS=g\&EBAhPaE?KIsJWWF77rQb
ZFZh"=484r[3"@p[=/f&EJ1GK`X3GLBF`(hI1Rl>(?B)JhiVL3pc^=']A@r;H)^kr4+6a7kqC
S.r_,Q\%R>I2[;7+R;\>Qic6'N0X!\LC+EmsWiG[?7I3hs=p\;3A"/67#;ge*9$WM6Y81(#+
j:M_Rj<,"2K)m);f+gXO9IjM(WnO(E)4n_['(`<."@g<A!>5ZX_R^r``OSG^RiXktc0RapA(
]ApKPK+kt`VLj^SEKd)MVsi)FC<\I!u=JV!9JpqjJd,+I+*LnJRofO0YjEI/u\SrJm[U?3Ckl
5l0A1#,JO-06LuQeC,Rh2S*cdI\,t,nSpYA/@()jVG9l]A2l2[>mhNN+W&a5+A-D\6eHS\dW`
<N[`1r6:6Q`afrksC6%DQ_-/1LHJJMAEHkWIS5CjRcFj5LAaHeH<U+A^m/pZ4nb-i7-L!9tL
H?pID]A["rd=AfAp]AccPN%]ADegn\.k;$3]A^6XtWOcmi?$ZM_W`_f-o\!"Zpfu9(7R'EQ]A1mWg
Hl6>_<hr5O/+_2bG&([=7D>-1j%L,`fAMU;CZocDrG6^h6lK_NQg`179ojUF/pH<=/jZ0n'A
_V_gCjcTnNES,=C_'/_Y05?HBYo,kI7@h=+jiZ*%,(XLeO=&E(EVBpA&7K?4Z]A.>j(<mcPE[
5jDB6LSiB_t_]A(1Qc!KXSC'4"kN-\+crh2V2A?<c52IHi0T`KZ>]ApJjd@0tC1]A<b_t,2'Y1'
BS2:c9(NaJ6`OJ6WB<PSa>gn.l/dgfVlX:Sf6PV[&Xhe>=q3%W8!'a[/erM,]A[[4QT8oB+8A
Y`5"HH7Bf:Ar\D$@YG+u&)-'mqD`hpJEFMn^bFdOmRX(Ci2AT#@eL&KNN<;CD(^02X#olr35
ru3SUn/Jg4bVqe4XrN*+ZRiHW\4r59NcCYmKc$'@.q;Hj?rEVFl,"\QX7Z7.rEZ<!@YV-kAB
7B[m@$b`B%aC?#_-j)/+t*<!MKGGU;r2GRbu2gFK3U^QKO5h,.d?Ziul60nXa^4:qO]ALAgY!
O*S'i99^Wn)ZVbCF+Q37=7Dps1hfJFjlcErEk::CdD$%n9o0^'o4cnToe7&j$VFIO4.ZJ#c,
nm2X"R&K*jHhYZIY@+!>t(@Igj(;!dp2<%X71d?fN#o*L=>oF!;>OPDu2CUJnX7D&WS#d\fI
\c[)<$R5ZTmaG(":?Go<-?/JUhbSYEais'T7*>FBr]AGguQAb4\Pe`j55-Jau3f-XCI00'2Ro
&O1\r*d`b6mk$N7nLIk`Y^m2pQ562:FBA3(k[%)Lr1"HQP/7b'[;1Sd=q_q1l-e[rR&;T0U<
(b,!&<9D0J.jGXhbt4*/9oq4=k6\X[a_279,5E+=2b!3JQRsLgj8A/i2r%#BeW^;6PmQ1@@p
"EIM.IP_Ijfm[tm@Pbg7-ba1GK_]A=+lB0%4HRlBg2!Xru,<=T,fjK>d8H]ASOoQ\Ko6=lG:pT
2M0(H8G>1S7^5_]ANDLn`_nTuKiqm]A'+R$ngl`4_jsd-gF->a:Hm2U>L.kLo^YbQ<P[pa\e$2
4LVt/L&m+LVU6AN'OK5>._IWNZnmr,Icq6Z\18T?P4C($',NCU#AX_F#^Mq4#pl]A7X%SGhQC
.-hKJ3@)JdbR->R@Y>nIGF8;Bjm25f7s=@<FpN;S]AgTn6[:p;p._a\<-+Q=fG1)Y"@\0$:<,
*oYd.W(m<c<u6g\P;;DPne+F7iq2/Cm&qq64CEo2MPi'h?cbSPAi]AMHT%GX_m3F!9F&c,su^
ab-XYGnQW1/H%bdf(M=.e5+\C`Gp/[F;1`j):P6^`d-c<*c"<L[.GAiUn$Zf+?>D\k`T\_gL
,WK-$;%%f%c>G)l9;9MRgm;0J^>P9,3B\WpQ7Y)M]Apkb*:+PGZug6tir4VcT53]ARb#_)e9$6
Ju:q=YP`R93gWXm+%a1kl9)l`F<kc^J5"81d1l)&XZl0TQL#FPZn/ge4g?</Z%-9(jKHAbT:
8=#7,8:q=N/*iVogDS"cg!,uQ.lR4Lb=Ga2(TU5*56XJ_GckDJ]AS6,NI4N#9EnU!S[VPK5'n
?g`c0T(1W*?tCeSX$QgAO8GF`6mF)24QQDok_*D!.nUb&ntIaVmSSjMsAi;U7uZi.bn\/PHR
VF>uo9H<=u,dVXG/[DYFLYA\K`7"hs:[5(Cs$UZX9G_ud0;6;@2b0>'-(GpD=2hNo4]AOT!?!
[G1B.XeZs?=J_S+[o$<rh-+1+sb7_Y<l1a_*\4SNN$q#%%r[6odMAi%H,3P$?&*HKT/uj]A.[
RPpT6ZjWn-H^(GgtRe=U%bTrM/H6%YUQdDG`fGTPVl3`F#p=M%jtb,`@`HGHRrHM.d+N,K&g
"G.fj09JZ+ZI&@Oq51A`N`9OjP_q.<5g:[T*M7Pj54"O)IBJuldkY'BOMgTL5RhC@g10>R)H
#VY.6e[!-ekph9&m^A\Fs'SGX?WIe"H-58gN+_,,i=>mlB2ds%2UjGL(r`L&B8DEL\`9MZH"
7r'&c!fP-\3b>JGu==bpK.P6'KGYZtf'M5ZAO8[OQT@8,1%j]AgiftA8q28#A,r*^LE<:[%W`
/^JGmqA*L:E'4n>$ZE#f\,IY:+ZWsiR3J5-0_92kZe</%".Z*!<X0go.W7rWuE/)9eI'2&-F
GkIu"-XK6,dt.ZLe:JFT&Zs'Ya,c&l"c=?2&ONk>5LH\r=VTg"EK?m<bn8"/F%MtpR.!('h9
jR^R57Q(R0q[*DNDZBYokKWu@m_saLT0HB^NeY/KkK8HN[=6!g$n.-K(T2WHj5kS54+":C[9
tu$kR+p;4="@1XK7rU;dE\B_L%@hk$T-#L?]AecbHVeH]A9:0Jr(4C6i*J?SQ?^5q\LroJ^@L)
UaZ!7=Ac+i4`7*_.`-N'L'75+JJTf3$nr'a4\k8gp!0uC5KbKd96UN19QBsh1i<b2Ef8ck[E
$>5pn/sbb:j#-o8h>VCo";q4IP<Gf]Ar!u7c/1.2@.JQk']A_&&F/bVB7M1+#!J).K'gQm7JIY
$p-&7"1(:BWK(1&Gt*+;:EhrM-<2W;kiSnqqODn^oG_2CN&WS(5FCt\Y@7*$mXCU=YBeUSn6
-d)*KI@j[J`d@o?YJ49PRI:@cm9RqthhFC,*?a\PqLs+J))#"Gs,'/`D)VhZS3fL._./KANd
Ghn:nXZ"BsjD/X%_NZc'Xq!r0!l",3/_.R9gZjdHl`Q\.<S>-bWdjVISGQD+N1OHAM?N>lI$
ufAUIO?FS@n1(a;:Gj_(4Fb>Tcg-(L'(1qJ[<ot`cq(tl*\5^,?H_3GbZO[aB/?]A4#j/]A\kH
cb/FoWsd>VAkL2S%a6:ZDNY`8?)>jh6c8@@/ha.m%r!c//k%e'#k#I!*s$_T-f)<3V;,!p?!
9"IplZ.K;JUu?J7Wf,VCkVG*R"V8CE,@qNhMZp.J?fRbjA""!&>PQTrdkENf0=:eQ08p"=2$
(\10\J2E48?t&W:ZC!%9n*K=seuuJQGOFjUASdER._/eA41M::!9hU2Y;J1skC7_nJOJHHG&
*lrng]AaYoB^[p1!mPqMj&I*nG!1RPOqMe^BRd&p;Sj;-et;)98>^r19`"QeBdQ@Yd^0Af"82
7E.-*NDD[_,Ng5uXO9q_l^'0VBLkib=V":m)$OV-+^6I5&BW]A:.Xj&ahd$<<AVPT]Aa%\GV*c
pG5JJ]A\2.?\+`J;/#Z)ar@G<l!!0f8L\P>cft\;\pWM3/ikQO@F=[L_7,iC"1EZh#;_;.6Cd
)WqZM[X:kS5o\>ajG,T6;lSXj;0L56>oOt>FoM#SNk-Ur9GCVd&nRXT*=Fg&\u9")ikg8hn3
qIdr?M:>7&1c^iedU/Fh>$]A`NW)naTZh7'3eV"Z?IJmD9Vl22cY.?q.hgWk[qEtDFWjfGrYP
ZlGbC>)[>tcP+CbU-Apg!1kD@8m%8)r@s!e#CL6>PLOe\n-6lXWbfcF@NP1!JF&"dWCb@&t"
S7G\j([.\FbPBDP7Mdb:P_$DU*!7lCdW%!IKUj@=#Q<@^f^o#.74?O$85$T&jBfZ2!$f:GGr
+0K_fFrF\;`KL%jEoL@70B3-md[OfC"jUf[!q,WSK:aj\6o5JmnUS`So+!*d#k2R30reI50S
^B5/2lqFSN*8h;9AEAr(]AAX7[%4ECi2=kU:0A7PbbsLAns)`W%YZ>*XoXrVm,k6iN^dIK+Li
$9KF[`TXM,KnFW77fN6k[/"/F8q6A/P315:UHVb;T<"MaJ\aarV,I3TUhrQHRm<;0@/]AoWa*
C.3k?kIu4LT#gbXu(Mlaq8XT$R-F-*Xb"H.lXm4<L</[1o0/?1'\7DS9sa)-i^orn$oFctPL
_g]A1)m31eN]A4[.kNj-D#MA'4@$K^bB6;),cg\&`@JJM8HQrC"T3rWcg)]AeX#QQhm=+;Y'L\d
VfSuIOi<QYu$7r"$.$KEK?$)c^L(s-g[7%(i>;liHEIGmodIG?Q"Goo$t?gY]A%957ZCBCFrl
^'N)6hVX1etFTl,A/;"3Qo]A]AYM0hKX,7e@t5?Eq6*Gj^[G5'8kiV:V+EDAWg1<jh:"J0`?&r
J`$.;mpMmM4N<UJN&i2fPNCtZOlII,o0)r,*Shf$^h.[`!UD9j'Yt7]A;1?/N#4S*@LMiucrg
"1r%>4J2I:j59%+$.=V1L`ZaK@E:eq^73e,(Fn"CY&&8mhl:3)SWj%m:+'EZc-^V@ojL%+)3
-<Y[dFpWZ<Sq!RkRF+FX2&bk0(=]AHrZpaHIQ`o'/NcSVrdAV]AGQUk!]Arqa@s/R[1C6J&8l*i
JepE@]A=u8^g\(1Old([@8;m\hFu]A'p"0_0\ST^PC.@b&fD%EK@n6tCU^.^P]A;\4!_=2'Eo[/
iQnD;'6kQH>FDjLpB$9j9t-cgtO-JmQtoA;LVfmGNVhOaNsP2t<fmM8MKcad=\a>BSG1&_N$
!qDYFpIjJ/8`KeI9)aPLhnP.M_hQL&lEaXYHmDp!3B1\PQWh1$O[UhpPoYqtgp&n)"iC<^eE
RIZh@J*N6I_J0*kja:5,-+W/?o`7)r`ZBLZ8(ZmEm^!C:.`P-V]A@%n+11IT2[f&bRp";be;_
(CMHF>=Ke4/kmd[XF8C<!EOa"Y3)\Q/qCm6V?nXP4FZ]A71++[h:/!5<U82plrS\Guc=\uCUF
t?u0?X2PGGUT-YSE=J;2Mp6`CjS]ADp3^2u$C$a^?"^A2dE&n[l#FiMiH3/04r^:=O&p3S;`$
T6kVnraC5;;\K#Q*KpU$#/h0+tT2I9AIr>=X(e^0HP*a<(HVh@[0>Fqj=;/Z6$:FR'j5LLaj
RJ)4*B;g<8:SLYB$0o2rg\%@T7c+`H3%JIiX\ah<%I+_j*k\,!Gi7lb`&Q!^a%PSCdBoleFs
"Q&oU;u!^J(Sn-?r&.@(ilb"OS#QKaRc/C5c;,CN\YtP9\3n,X%"ZB_NT3bcGe?5^@Sen$OA
oA1CU("L]A6)+]AQ^qI^ZF_&G_`*bZi$LgA_hi<$__]AYZ)477^F`=QV"fg^Lr[.^DMjs0:&!6N
I23FA_q2G-%R;/4cVlM4L#iFJNE#,?b6V4aVMNfb0rJnJcpV^a;+4%\W=;VWucn`Ma&;aE&h
k%E`t*h@N(0\i0"D&hi&H.DL]A+#(V;EmRXr$jOSuO>4b$NUba*5';0%W1<"Op3[N!L[h46^3
HkTdTl#Ck"P@,67PNkIPePj!(bsLa,cok1b0O,M!g#Q.Ya_rmdnMRBoW'0C56eh02.#n5[\'
!uE/&&^U"D%N:>`./TI5/V=nkh]AQ/.)_cb75i(X=kkYfV@f+#B#=8H[YE93B]A;/1=r_.%[M3
u)(jXb`o6T:F&V?lM.K5]A5YO_@iO1<-n\0UY>OG^HZLQcBf,=,-4cL?e.!12sVV]Au^eN'B7b
!!h_.^'EFkhPD1UNYLRF:4ja6uoClfb/9hY`@kQbc/4CBYg<AXU]A<sJ;j50bN>+3=tSOemjU
<AT4gGR9Iu+jdI@gEq\5Ip8G1AQbpqKDX'V@n[qmVRe?=UED9"-5An[8T^>5#6g[Sbs]A-UCX
O\]A<&1,ppZ'9HMb(rr>B,60humUA&NPi3ZJRDo;4NLaOZ?@7\L0!t,h=2aqr;h(:XR>liPXQ
#9lJ)S=EaWj*3K`07K!4JB@9'=k8kP@IEQXSWrp8Li5,j^&*o;8HbG?cL?E&FK=Pi^'\l2Gk
i5j)@#h:`Ye:o]A[Qr*arG+Z9*gpJVtp_5*=2\R%p^CK54Y9=GOKFOhJZ$Iq0ur*UULRO=1<I
R2;[Wb4u`Mb)li4NZ)eJOBj7?gu<Eb,BLhF-D-`0$'DLo/8eF_R"K>hKF<%SI$+f`U!$tNV4
]A[_&%?W#!]AqL9&>FLV:R6pP,<IVc@rH$qLRWSIpSJ/qU/MAQbJ9rc2=d<[i/.j'f\]AHq=Jbh
2/b$h.sAe:/H@VB?*enSRHGc'@fffi*Lthm'um%mA2cq6JdLC,&bd?XOi2gO(k;D9oj6m:cH
knK*%r2O*ETG^:@Ac\\\Y>:<`t"l,kj@_'g^UB9B6sb07[G+%uV#1GBOg#iF*_G=6*RAD_CE
pcI5[H\Q@Ho^D2bNoBKC`6tO:(o=Cs*5*$9)&gt.VEk1b*ZB;f]A7:OVF`e.M9U78nAfRdt$O
14<nqBn.O5O70FT-dCI^Xo0L>-!4;M^#2po%TlQ9;BO/R0&X"l1!^/o.9X.-nI2$9Mf6cRoZ
1)r!^8_^%?Y.AKU:rc@qq=/1-%=\+l@k-P>tkdq+6[6p*.5UrX66JRKtl#Q&68osDt(7sj12
W3^L<JBH*%r0_BR^#.MOZWimpd7SMc(1cuD>3M%eLLnon0g59@$#--6nN@ViP@H42I'@omAV
r$A2Ipl`StHQbb]A<M*`SooN$f1]AS,pF`m<25-XM:ci5CbU?W"Qhb"?Kl^Y!27'4)_a(]AfGMP
qU*K$Pie9)6apdl@:CNoaAGdsBcbQYYW,+?(Ud=9_0Bg3@6"J;E^o\pcb//'Nke;Pln<l+7/
45CWMY`"-FHe:OQAot!c>eSQH.JH/C\60KF.uX%o)-#mFDD4WT5[tb6S_[`M(rG4QbKG9Agc
7qMYP/o,Z??iL`(LN+WT9fZ``Fj@tZZ6:)CStM%[!%RHRc[)3_$5`A_mFmE*EbNXJqL\C(08
r1:7(Z3.\5.GUDTimlHf:9n<S_!77R'<fho+$`uTD/ti??/mMYOWl>TM4rTA%(k$"Nodi(8n
;(]A^$Ee#^B(l!TP-^(`K=%)Rt(*_4@KnE$UYeC*f^rW)i;:R@d$qaC[G2)@GaK_99#XN203-
5(s/F.gP6jQ(llP7rBP%nH_V>,=:fs<k@iA4XJ4$?E/nB'PSZ@CV@?t+WlB$+IVPNO7Rj_)E
g]ApI&6XT^$TBJNID!<`$mqdcMH*m4""eG9XDbe]APR2pGHQQ!u*/ZpMI=FR8@dNM_Oobt`WA?
^9Nen,*O:1SR'r7i8bWZ=lSVYc)4s58'LBg-)fm`<G'_;>^;qii3Xq.t`[`H5BVhJ_=i,BBk
F$@Mt_F>H'FHnNSoO"FDfp@<-]AsJio?8CrBf"_E+D$8lUN/g>[NX;a8+_UU!EJ(Bjef:P2EW
3^bhE2>VXpl<l&Lffp"s^ac1Lo>:,)#;n+/;,YOI[q6.:b)dZ=Sl)CtZssI>!_+b*jp81Lp5
mWonYST(i3^^4/BIRQ5HWF5Q/pYNrpJ3Tq:mX]AM0q;U?2X/Z,rA_TB"ap!En('!I%hp$94=<
p/>S/l8tOK+tno:rA#![=UFY!hYbhh_e4>ijlUCmsaTS^=,F6gD^$=jCd?+$>6/\6[QhKgZd
FtEibB5X5Wlmamrc8Q[sNQ'ZM<040DbDH.EZ^KFj$@'S8qQo9,_lgEpa9di\[O^rBu=PnUk[
*SJ:]A]A0iJ]Ap6or+WguJ/;d,@,JFm8%L8r\g]ARm5C7?$,D<r)dNQuA5P>ISbg2>M\$YQ1$eB3
?'rR<K;g+U/70cGNQh.&ZB2;0.m$E>'g:^tsle>fj+*')b:OX_Pg7jP.mtTPohMcBZeBOH6T
&b(VnWJfA.\FtuPDgc=5&/OA[,OH/YV;^k_)NsYLS.VY&2IqI7!BiFTdd_LnDd>r/b(I;GQ<
^*VmB.`N"VVs)b#"m\f/]Ao=!Rp_TC6>tn1\k*e@Q6Nuc,n95]An2TAPdR.FC=_;Bmgi:ckk3$
n%'!ZBrmcWu/"?c!nS%p/$'2V3u5V1h_a]Af5LH.X7Ti9O4`0^J->K$n5Gk[I?8K6hRn)am`C
-4[FunJFJ17bsX,KV[lfUsX>7?fm=`RrN1:dA+!XG1[s![g&m[T&9<Bs2@hYE?a]A?10no1Po
cc[+i.dZ*Z@_eS3qKP4sj*qj*tH37;=etM??u:N!gqELFFGs)MK/F:%Y[dQ6k5o>?hnj[+5d
"67$eieH%Lu>9+P7\s\sV%1^:l__6r2=*Q"N$<AS#]A>1t`+#ns1h:*0^artcok]AWKbX.'FCF
Qm.e"XYZ8JN`f.7f32l@1R&1dg1a<Vm`tk%]AG$?:1aN7Op%5AXi;5oXZ6_MQ!5s[+k\7LUZ%
/`>RKX?Ndr2qn>6-[oP0g]A2G^t/oUGo%3H:J43%DpJk()fgj-EKOF4q@J7DtQU&RTl5]A_enY
,LWQOeg*"1a=e(m;g.6nTN#:hi+F'#%1M0:)]AV'k7n)"$9H]A2smbr!2dgFoP#EuPFFEpWQDn
W0=UW5u[K+m7O+eq,L(s<lW:Y7t8r.5`Dk&Z/4F0+rJb%]ABqK[K5_)#Tere7354%6Yd_3*]A7
>Ua_OUa+q8ABP7?W2KkKl_HHqo`mPi11Yot5DsF!5@m^^`!4DM^Vo+X#K@L]A*"/T*REIu8YJ
&8LNHjuaaTFUleJmnPX##H\\j43Z\GmNS9BY1Q"ITAKUm';eR!@F#k"$88kXJj(B*I/P=rB=
U\NX"pD9dDFYja[+qYlmcRo_-W>`ecUQ>.AdG_5k=1VA1J+qNZ;kr7E/-]AJllE8684WPNm+u
mhn).U4g5Z$u$V$,Y?Tj<I:Ek.e\7)7NZ8!/VBM1U50/(=R#[:;H%:IZm,H!b-OWa!jh4!YP
!C9fl3^;R-'`?H`C2JY]AOH$S&V+#&]AMX""=&*YTnTu=,V=f2C7orhFcbnOh9!@ofk3B-#6Wj
oj+d,V<7=#g$3"]AA0+tsOEt4K>CWQm.e8VM[8T8Ng5]AN_Q>ZG109>4Q5Q?_3HE/qD04H=ro1
AV^Z60Bo/bcCqZD<9Q/=[(\(_V'#N/SD`!S;G:,O_q$".,ER+hF\A8&TrJgeP,<%M=Jnd6pZ
l6T^q(e1"^V--'m`-WP02&'g]At;nADQlX^&'2!@#TL@;X6l.Jl`KV(hKA_[^?MNn?mE7119r
3Z:D@qD-2f(*u/(9_$HIRkFLP^n+%;*[7&=I(aW>qQ<"Do;@6#d,^M[H?%2]Ab%9Ld'SP\WI\
:]A\>^W3=oZs-9R/SctCQ$k_'6p5R7#6`ea'o^p`t*(kJR1YQ=\X-DaLnGLeGAQpfA9Z8I\Y]A
%hTml5fr*_1g3Af@g"@eM`jJ+`CM%9LRJm]AuGaAn+/S81UQ7J\;!qlKdU2k*\d5C6G8Q@"UL
l)[*%ODc?Q,0&C44^knXO_.RNh$QX839#H#*r>/&TjTVpCh`Z3)4G+q_(l?d!GmNaY5U+``&
E=he\u;fK%!USG.'>BQN6o<iOR7_`\P5[d![Ue?Cq"9B1H'<-KODN9i?R<?W8=kRC]A04794;
>1D%nho.7U>KUb<5SV9:P0j[U"7"R^lNI^E#%+>Npr8o![ThT2rFD)#Q,*&9G2CT&HG7ht:G
pM)O,YdF5??Yh(ZAM[L)u%CL>!O<pT3Hkhike8D<td]AN=#887Sm/iY*om%af`$8OZX%VfUr0
"e.`had."iYn2&4%BW-PKJLKLNo'Zr6QRf'O/=SeEKt\"!hCBl/XS5leL//j,\grWL96G51Q
`ZP;4/+Z[IQUgUO2;p#%$'<l5dXHA`#-3<ck*L?ZKPBl@5&PK&h@fG&PFu-.qFKuD94$dd9*
[7d#%52I_c)D?RMWB_`3Y)kB_Ou.+qgb#3,sJjr.f+Xs"<p?Vm)W`<CjT*bba%d`4Kgq,g_/
(#Pc0@H3bq!\)a7Y_Abk\a\%Rn8MA$6`0M*RhfR*NUIDP^?#90Gs%&e?Q`t8&R$Bi3f'`bAg
DkNjLNcqPo>W,kt&C"%1<T(U7Hc2."/Tc;6K=nKp)2K.(th*2/k]AWnu+;2"94Y\lq6C7o@UA
"h&&<DnW%A-OTT<,18TT'^E2;)bSrH@g,,S^>aZ:e+0lrc:W:\V9I:ZaU&7!E,X%RTRXV(LI
&,)&JpQV%coWhdT>FC4]A/j]AM,e?u/LC/=4I%5FVTZ=VeH+K7=[F,_8EC&A#BMepE5qOh*dV#
A0H;N.Yh87a'kHg_V?fmm!9mW_BX96LFh!\9Op;"L.diAa""bBOmg<Bt4B.d@\9t4\#c-X?t
eB@WbII=f7:n@omAu4D.TX]Aj2=l]A`u1<M;InN52(cmtX5W&udrgYgHl[gpK_5*b038Y8W=9t
Men<!sLFBlu*MZu_),("W;uc`M#7@ggL$>KunS)['RVRhm>Qp>M(J\&q[$jfnrKenfKQDh?.
^G%J=f#))@O.#1l;p"I'hXDN)cN@!=2a^BaD;ZT_>raZq<5J.U_jh"[nN!XXSi_buuGJ#hW[
4k^CCS@jR^+7rfUS2AUm@Sg/MNl6"SCT(`;Oa]AAOdB8(-`//T^,&QHd=ZB.5>W-HfjAqa;"1
Dk^Dr"t3MeB"DKi_+GGZguabPpj:9L#3$8ut*k.dm44hN!<55UUGmn;?[QWn1)9T-M0dp8f\
B_Bq@5*)X:Ot%0=#DYUA*amN=;t\9rp7HU[C^Br$p.+W<SS1?\RCLmg3h22*[k*p^p)Y>-`t
^A`DsqREFnPH")-[mTjDY1VkPGX`RNi3'5F88@po2O8UMq7gBL.'^L1`g,O:AX/+,WT31Yes
q^@tSW8QK?l&[HRqpK$^JW=dUC)aJBOo%jrQl.r!1[,.+^gpN9=U<D=V6eZ(3(J2K!(89^K(
'pYV*hZj:E7"stb=5]A@I(V$]AT$>_dGDI9Zf3J#!VI&)TX)UeLe97-8]AF4Q+",W^0gol#RI?d
CF=RFqn:dnW<o+,%9d4XXl&dhWMK>dG&o9QPDGYQ[".ifLrV5gMJUj^c2c);rh>B3WNBpq[_
6QD)lK0qsp#.9s1hsB*X"NhoV;>Cs\<TF<j;mkeB;D_VNH'*XcUtpY63)r972<,(2pUH[11o
40!2p7<C$YOi#U53I/0mc/26@;Jsaee_P>l"[Io\3qX4g3\7;McOVqDM@l^K1+2o4;m6Ks(#
MY_GlDHqfk=D5"1tN)$_$2Hei+A9Hh/MK@d@:HbGER6m>fcs;W^F4tPAFpi;0U,c*ie)L2ap
gGI0T;"JOgeLCJ/*s4jg>#,Rr/R-5cs)=.OZJR2+MA"<Q+1`adm<#?MN2f.===#9e(-(;r^n
*2U!ONc458.\qjnfm#'hiLU3r`+TT`f\m4=";"`C#aO>L7sN+s`X8ajFjSt?>N97*pU3ZV!&
k99o1nuVc@9fh$3YA._@WJpp#e^bg5!D#OLG'N9.9t!7!TIUp4fuW!H?I:C.m%EsO(c-P1ZN
Ra7YS/u'.LbAXUbHE:GDt*$::1,,W)8,LZKAX>Yno=(KTEirEENO^T&B=H"EA:d6m"WtLrFD
Mj_2PL_>Oe^R2tpJ9I3r<97*E$otp%:HcbNrGcu<s'XtPc"pnRe%J\RVS]A%VQ!aeK,2H_V-0
6I**o(^)R5V6uOOnE-5\,..<q@Z$i.Q8lfURF;X1Gt'?ZaDjsSK<Gr-D8t$!ZJuoTWRPg%h(
!:`R-DB#/2=qrhW#c'"G(mM[jS*R)'(B@9?H$EMIJB7IYG8DJ]A>V/kr)*aJ)5;-Y^A<"YMs,
ToCl*Ghl\4pSuO8*Q+DLpklf2QEb:ZI?JVm[-qnCUjfWMCr1r3<_Xr$(M[n!r?c&#Eu_srN#
bX$Yd[T.4.DfIIaQ&qN&>l$@K)h@n]A-KEoD7:RL7IGBYFS$;:?=uN%R2bj+sS<j(X.+OI2ki
f3`76F)>eacg/`,e5tQ]A_$d#B`$8B)[3dinU4jl3eHZp@c/]AVJ;X&UWFHm;7-m2IL\@uF0_@
%!(r',2j]A7)M4YQ!S5[?n,I:Zu^RB4lrWV5Fc)V7l9"K7S??acafPXr2d'rTdmhRfP4-f,Xs
plS1k?5e*ue$4GHZ<,-g@Q6c17dM3&R]Ak06dJ%iPJUH:?`;aX*=E*DXtb.!/"nj[1iHKugki
(Bf&V/Ifc@^>2\X_U"R`4Oj1AO-L)`GiZbN&'U(p[aBebSf_>N:)gki'[KjYf@>!9N9OR>,]A
JlG>Eb\-#&ecENCL-kY7LmUkb9uGEDDjM_)LjF-qO8Vs&/,WhIb6W.@-3hc84loHRZ3OBbV&
0;6N4!k`JrB*L+K:IN/K/,O?ULSUFuJI9d54@FO!F^@L:>8p@s:>>t*N0Yl%NJnM>$$-KIn+
-Gn%Gcn(-]A<;pR-Hs*^-9@+^!)OV7a>-rnX<D/HLp`Y$s48EMVjZfqULY,"4#<L!cA<Z)$+Y
hESD[Nk7HZq'V!1GHZY/.s"%>>W9efP\0,45j7mfE/Cfh!R*>'^!,pJqIOE]AZb2olCr`W/-&
C7:Na/@A%W^R8&nQt'LS;S(0i7:uB0r=#M$q-h(]A;P!!l\`:d'.Ime^b/!H6QY-tnpcCfmG@
^WaHZ@F&q\VF?[X?mOg+F'WUaN8FbVjSn=Fcrd(sf)iR2lamM0L%D/$Q)NLmQDDD;YIeGim$
Ne't):lj;hY!9_DTU=@E=rCQd*f!f",GcJil.[3nVNA@i[O0%2u#%Q0C`<ea/21=S0\15RU<
Kd2iff7Bbo2pj7$b2/W*6BaNEqCtF``fCWS%N^FT*gK'WsL5nR<3;O`c^(\j,@Fo'5eWhL>Y
;k7FdU8<DNbXlj>'hIk;dq_bY,Ac#@,lMB3`'ngjPe.H-XW7O02?gl\;K>6sR9^k_T=5#nQ.
H_UN7;b)]ACdt0kaFGt`Ik$<V!-R64Vl9JI7`)>_Oe1KN9@FA[D]Abg&Xd*=F%2*.Q/4I.'&E1
CeK>lM9aq>Y42"ek>Z(Zm.D1YPV[Jf<r2A_lou.B!4^aS0`Zmp:l9N#28ZT0KR.-oZ42S"]A=
LZb>"chps89J";U@RUO5>@C>/NXEkR*Ac['HYIYG?2Ym@tM[d1[,OM@3V7fmmQEQ)be6Em(V
Xh.m2<V-pEirH!:tVFLf@&%1ZU/G*L]AM=*"Jiet>XB+LZ?W4Z@fU^p&(CfBg$P*T!D#^HEZH
X]A[VJX`/d=qsm!H?YjIh7*R!]A]A3F1<U:Bl98-\c&54/O#2H(elWTZVV:dP\MA7@?7EPqF+FS
loR]A"<jg&Dql(UAc4iE1O/nI$);fcKdO'Hs8Fd[Vj='N!=RJ;s;38$bqX?Y3r#E2&oiHCqZb
GVirgk0o@2PX/)T4XS8MNIQID8%%at7_L.+BhhE/T.[r>i_/>/EHp[?31,NHBP5<n56ppRb5
gUVS#G2tNY@*]AU`l[LfA[['(##<NAMthr==5JeF:Yhe?%QhEH`Y5(;:hGJ^f&gWLcRCm$LB*
UV&i/GoPD7,19"9#@J_r[r&5`=Jt899ql!Mmhdgk\Z9UDt?i;r\]AUIa?IZB]A`6`4.XAjCS>8
"TQnM?%'uoIk[)gsU.kQ\_QIi`6TJrHmidKLJb/[p._0%)0Du>$-\>b%Q;jZ:X/@iJO\)sRG
#ONH6gdH!4e-uuQg\b#LL@GE:c;GCpNgZhj*i15/JaPWmSP8OQkfd0h;Je:(FlJW/&?Qp=Ug
7D]Ai^6e,9MfVW9;mM[C#6A]A7-@CZ["Xl+G4YD(`mF,o"ZZU2QX)u-`qW4tjMECa71aGPQq'=
j>?Hu1KG+nL%IA7uhi6.@!$sd8e7leFPkiLenCiLYbQDooBEC*6=osd_G)J0e!Vp>cnWWTOL
,F5E^RZkn\#l:9\(Nri7,R.X"A'f:kJ*l]A%/lN'b3",#^Xm4B^@kl?'bQW[MsF^9:l,!#qEf
eaZWX>%MCh0t/dDr+TYQ=&J)*@e+:$EAi[_7C76?BP#FW27n!C*K7hCV`[PFgV!P>a$00E%;
325%K*)YIL_S#od-:ONgW;:i/W20[2qj%r65==Lc!-2HOXODh51uA^dr3"ttgW0G+6tF..\b
fP8Qc8DL@WuonV,;n<<2%I&@OUlfcc3`G=pd^idW]AqmHAQ0I7gK$0@b#4pK?]AL^blaU!(W-:
\<BoYR3\r);I&;eu6A=I0;+K*aXIAd=rTF.`-?VfHW8T'!MLI%d2KboMhP>rSC-(VS`(;<:;
=H]ARQ<HW+IBtK9QQ/%(]ATX@c&iB&^h5lSD$3nW3FAc9Pd";5@i8-LBr&cXrbt]A"W^<g4ur*O
cX7"0j8Voo80D,o<U6Y18N)pJZ`W^M:.O-3_A<gn@V&+=\U;kE<j4.*?*bZqg1!^/h#ULO($
`Qg5qE*pNdNSOnn,,dAKXQ!)I[o]A#IGg5Wp3S/0,_$0\JgpCHb<a2[[N[1YPQtGu9Ua)'e3.
MXna`$!u5;9s5N6hA/kX#3IKh%<ANR!;n5[;DD6N0VD+7uuk\g^>;@m1oF>3XoDNSUdi\XED
ELuF,S(Gn\$:f_bhqWH*@rhbR@>/=@m*@&O5]A^*Z4n;LdkbFRI`''BB_ApG(NJX*kk/AR<2>
D+iSAufOudFtqbhEG!YDimE&b/LV^]A1VU-=nOq!9jc^:e-[\X8Ag/^<_H$Cl4WpY+)"6T('i
h0C)Ej]A.po4)"au(0hXqCB.b($O>3:o`DJ*2=g)a51m9K*t&Ng0qnon/hJH"[0,Lk=P5=b6A
`O!`$]AR#YS?$e]A.TQ;oj37QL$1rC9dhW_[j.e)'%*'f2@fYCjXk.Cf(BacN5XEF1"J5A8)hO
E$DFh#'680rQUSf9TiNp[]A6:l@:jgFQ[.IC![0dq1L2MLUO(*lKO&qX`&dnFne4io#i[Ir#$
KoU^>J1/Z>@>@u'8p$=l]ALK;+\X>i3.68D*+n?pX9/`HA1)91U?NmrZp34C)5[^mB4rgM0cQ
&es(3cQ&2@J39(-%h]AmJ2:O`AjZ/dV-"\!0f2DPB'5R:J7M#h-S;>7?f"hS##a,E_Tc(R51:
YMYOUoWSdP"6o>Sqgqo.&]A;C]A`M)M#n;ekVhJ=ESGfKE%WOn:sBCJL[u+od8^;'63O14,KC1
Ll0aWDHkf[j<:8/f?Ko;]AB)g75@u1'F`T]Ajj_20g;I)QVg3k<!G^Mf.)U>Zd3<,HIq/@19:C
/AG=SDW+AB=8,_D>$;&F9ML3-p,.H;:k<B$$X>2EV:$`I$s9T,J,5:8!+Z^k;:ZQttjA@C4=
="@M]A2b:;J5>Z_:mEc/cL>E\0hUsJd+04JW*0A@$t/(!&p&7Eqc4YcqPKIYG\@`arT$a9r("
4L,_Z@2)ERHZ&3nj6O2cgL8iP%q[%M"sk##!6*RjlfV[4o;d:nO<E4%QZrXaT0K;#o`S]A6XH
gU^O-l(CF8qf(CB^_FKa.6aj-fCo]A)AuUUaA.Rue2jW\2Ri6YZ-V',DF2HgJ7*_Ga$Wp7,62
GQs$Y0enpm8hQ4.,Kc<)]Am'd0+6%$.)K(B;$9Zu0giAsPqKAP8m7+&NZ0:fkVjF\==ck2:hf
:%4Fe@d8`U``VXPD.;n%AOYb&In!YckitYdjfjkcrff-/pr>LdbTQGf_=<I8=:Me^s=.b$l"
(E(QJ,=s,PfdW4rZR^JQN\R+l8'BBL^'$f3#2VtSo-H@u_2A(poFiBBhh5AoQO:R2pTtpgnb
OkTGNHgT`BAibE)-#&*5e@jL%V-)Bh"JMf9>j5(lBf0JngOOnl3&1l#s.dQ1t(@U[Qql$W(O
J#Ms?+)bo!+W[XAg8T$l:i7hq<9n7c29kOO<OA6TS7btCg.5/9)/M<jb6WWJNi.9A_K1+CDR
mIC@(KSr^H7!c![W5gbooaL1#[n/nZ#jL>@RfG&A+`?O8XE-34eC^bD>jGTs%kV*EMs4h7Et
Ifrr\O6+9*8HtO[1kK"rf\YTQ0NI2#\0!H""F\[fL4<>A]Am]AQal4W=f_0)]AY-&2f!Up\m0bO
FJD4.4SC4[cZhaHK.l@fU)p1k=UWKqH%Z7E#Q0;D!]AP7-Gnbbl`3[03g6"mWqOHGVlD+5P6d
[O0*VC&gu'Sc>pg%3ruC$B'8Jt(4JHFECdWDR((WR5toL3>lB-('41Zg1a67!ZsZ*7Q.RA5#
a3-<o1);,_Z)X?%:e["T,VQqaR,k:-!1Rf'(Qr!6.3U8,9`[X24n^\dnWAg%oS#&>LJBQt40
Q[,c^]AVCcUI-eB@_+bY:A)d"[1-)?RVp8r[qM:6V^YLHgD?g^,DD-M'FNmao8_BnR"%M]Afd'
+3K6F7JTMti7SLta$@lVF,t0]Au9aFBF3T\VJNd,Ze#uXmC3j`iVB3jF#aKiiL+1!juX9GC28
6[D\[5nVCX-<pD+0@sB:C*VVb37,i5.QBj7>EfT.[Au^D#,$P&_B`8XFf]A:@ga@?PlA>'fRV
:FB8U?q:I?"iPQQ!$GJ1k>XlV+dNm(KNf'r4;]A-^>0Sa>(u8R6Q@g.aaV_!:KMnJ[EQmq/09
L']Aq5%.*'-m'#,W55W,5>T@0%9FUhW9ncmsBT*A`(76,:;:Mq3F+7?:#dMuN>F`ti0f#LfLZ
<]A".kp7.le$'=>8&T-3Dr0`&C<W3SNDb/g!/A#Vq<]ATJoR@h94@BUsRE*<?^dc2V+q/d1Y9k
(b1MV/nRMAER\J>9!_F?=S<_n>Mq7HrZDJ]AYV<W[L@]AqnA86)DTF)<GiV<lZ[^lJuPctJ?t*
QW%e4K^<Neo0T_2^cKkMt)04g-5nmid(U6I<:(#-&6XQITX$c`CFub;L(ElL77t;Mr>j]A$oW
+,UL&*oAb]A]A/rA]AOVTV-YRO'k^EY&Hn'bIog*gSY$qRGR`WTi6tS1eB.]A`p?t'FK#ei%IMf=
m"W+b8Ud]AasOA_('LA[ge#';)rILBO\ABW2<u\oB@&1fGEndj9%1U#.Qcen22[&QrC::jLn2
KG`Vn`J-Fpp%mkI[Y7igRN)Q.]A:EK;LaR&0U\Rb`.\4/CU??L-/VEY<qUW'$\a,<(B+H?PTB
=)>Y4Ee)U]A2)8UEM"R5hptO%420soY#$tPW#VZ>3\!T%pWCgFa%LfG,Ie:r/WJeSfne/(Pd<
pMbW"(N^9I?:^1jb+([PQP48dUfiCO&EjN-XiD9g&6?[*BFeA`:m^>k08!-=]A5QhjgI&g_Ma
mW`@qW5mmVBXns2#]AlG@XlQYKX;<q2=7^BorW;e\S4+?>Ks^<[X.es6pe1(N!KA%RJcnnK?G
>BdjKX<^InauTD?P*1ifbs>p'93Vh*Le@Tg8j2ua9,qeuKUkK6"#+Z914-@51`Oi38^JR7`W
!$'c(cZS&@%o\kNT7.q:fW$_,b]AeKu^c/ij0)Il>rl)1nF,C2Pk(gnqlF6'XlD.0rX"`fKg"
om$qbrgWq\rBDC`l9o+1!O6h9b48B)cDFOWu\Knt/2?$s`Qa>V?*;29hcP:1.h8'*@ak1lB!
CIXutQN`<Rs<t4#\*?^G+(gbDrYNs`jE_H+!%1-(5$K(i.48H+kJ]AKJl=*Ijijbl?b";WCQH
8GDeLVNO[.M)mJcMKVaVsnVtKL,R9*8f$`dD=PkR+/]AGGsjh^$-2u@3328$HpcU,:q,Tf)O9
'eaH-5!hG3I[pD.@sr/AE8)&2g2:KCQX_Ds,pB5Q,Z#Qt6rj#nIX3hs"D-sS(m:$<j(+@hUB
F5m'$3>RiFAa((G2u'!XlVIM-$B+UA%=$lVFL>WIr/CCG9B4m.I4SCIb[HFY.2(]AKZV`p\aV
78:9<F<d=.a)HHdD&n[!WVdFK3omc\k<qMlPX(HtB@50&WIR^-M1G+oO'Pq"*In+3'hZ.nQ:
t<t%f`Df(<VDE46ZW\Z5af^iS_?^X*9>'pa?CO=X,F7nJ37`L$PGh1M^!BCV300\bX_4B<se
W%SW(pN-%3&!`gD3rdnVLQ?_2-#:O5qV0[m*@c[R+aC5U6LD*UP$`W%]AD%leNTQ$PSk#3Itq
M0rRSkP"Ct"7mks8=\"eY4bCm3d;b4K?7"or2D5Zcq@g!i?K<bpb+RY$dC_0RPJ?Fr)gOr/1
TaHcF,&7#$fQ:OJ"8]A`#eQDA$l8mV[5L^Y+Goef"eu3WM)p1D%,/HT2c0=17&,*$dS$f_LS+
-)H]AK`R\,R<p3H7(?"o\c?#,hq9g^]A/K9\dJoSn?P8=`T_Clcn<F6_Kiq[@\VYqg!Ia_0PB0
cOUUI[TFY[QK9%;>\Jhb_P+OWsk:E]A?epS)]Aq4Dl*8D=F&.M+-)\7V5mfB%D$^Tqc%3h6;r9
L]A"D:kc(S8?74p?=I"S;*j++["lsd9jfd.\!Yum?gM-4BbH\T?g:U-r4JVk4-t-bj4om\FB5
c2i4,eG$0-N=2ZZ_]AranR+!<U@>s%iQV*9ipdEM_G=VPC[$.AP,/UA30r=>?^<L5ku^dXSG7
+eI\g+@\W4EAo(Td)\Kb7C&VYok3F$S\kOcfUr8W95a8iSkGZUK!f&=pFM&*.ilAXH83$43L
5^"V=CF).6g\^EZP[0"QmE_!%o-8i27kT4VN5Er(b"RpqL78e/o-M-'sifpm'ioqdnn#QJ(!
^n"#HN*VbPk=8B+pG"-'Yhm3FSM-E`ejcTdU9?d$5+(%-5=:I!6rBP)Zk"KCn:od_"%)*,(C
9Wp6j'BKL0;WVF=UNh\(EIC\@):hd,9[4l'C/'`d*Ib%$J[#@YdbGUrLItm,F8V/HM:pIR6;
_p]AU'4N4:sO/rtT#aD#*Y-`kkB4Aa85hrM[qX14Do1J8/#G"jcYo*[0oS&YN-3io7/MbuK<!
4,@Zo5in$5;bmYX_Z5$;+3_AQ^S5lJ7Y=(uimu0IF4)'>LRt;ccXh]A8G<aaM2sf0<8nZ4\ZE
\3;>)*\]A0m<;Kl8DQ(GVlfnX#a;*HN'4%^$u99*?1g`KC]Aumh=)V]A<Q?si-J;e%`6Mti*Q[#
7'6`^Jhu'_Gg6&`"^lZ&E_B#F'A2I+APIAicgd]A]AVn=5!]ALe3io/@,WVg%-CS))FVV.3]A8PJ
pEE'j;@$e4Gs]A;4YK)mKlWb]Agq$R&VE\IaCgtBufL0-95Oa5_VcZ'^AnY1+0$uKS/<kFJs+5
*>k843sI"`1^>'pW1cG#4GbeKj$8.Vor)9kf/=Ra"WJREne!m:GjfX'UoU819AVJ'>WSu_L2
TOl?4%$:o/d9Jj<2*-,sbUgOl!VB7BD.6a-4<Ad=g@\X$Fi!]Arc=K03CNd`O=BspDdY#5-fW
u>!mqS?-_>_WtNVIFdXdF#CT[hNa2c@d[8be$df#/MCIp@FM;+Z&1:!0&Nj1`CPk.CM]AMqY$
\WTKNSD-slbOGdQ6>="s&J,,;o7n81;V2*>Z4#'`dAH/_qJ=LNe[n2^M^1<mtdB^8SRHVW@K
<e\XMV2!U'_RMmcm/.Ijk8DZ>Y%9,Q_EQ05.A-MP0iI>cIKCD6<6s;8a6]AjlkHAV2Al^u<>"
S&18<4OEB?#0"))4=;-Nb*;9O>q2L>eDn^T"gKroI1iEDag>:WSBD!3\D8b`XqPD'cdD74RF
lK7;HZ$+J4mU%'o&4N+i/hq3<Z.1R>T.M#s[qa&r*H02"lKX/-`-RTF75Fo#I$QhTFlFKQ+Q
>@1dg"h@6%$For/iIJ9cTN4kM8SE:t>1_G:b%S6&T0A3A4&o^iefP8thgaLA%<a[UMRdoV/7
^ik='*<qOB^YF,Z\_`/)1^>ni0*J@+g0`pK'c+-.VH\#4d+,VqP!tEjQgV,`43ok*0FDpf_Y
kBJoo9fLqEVi`UGF.u]A&js'==?/C?M74dq:AcFfdoZI4\#(n+4Wj':NRbRu.&2s\b#[g!40b
j`mBi@L48r!%nt#ni7B2)p"b*?.*eCo(B#PfM><SG6%^1DV]Ac'nOq\B\+?i\JtQtiD-Rk$Aq
l^GqXlg+]Ad"u?f<hc!eDp$\<BFtUMWUTE8$g8<l56a*-$!^J'02$ss?=?fp21,4C1Ao+K9Gp
6o<3]ADaFg!_R@O[?T-FUj@/@mbD)`RA-HYkYbHbLj*;6AB'Mqt)@V4bH2C4D.(`j^b(8(]Anl
pqB_fpVOk1i"#Up5`"I7(r2K<g7>d2<;)L6Tg<UkaVplAV)&oiRfdCdSCQZHJW,\i2f4/@Mh
TDuiDsq`OrC\T.1?r&")55qZf/-\l7O@V$QuHVQ3F_t/a"N[EH'J^<X_*_#>U(?e<nhMP=h(
D^6n\"9_!HD]A%\/+Sq'_:.#sj-7l5l7dcl"3bGKY<q!7B0I(d=6c]AhD!u10BQtpIACJ1,[/#
R\kJ]Ad>h_CCZ+5\?7VR`R8GW;eR93QlBq06`.;n$7n76c=uIppJm6LOHqa%":,s>u#cWb;4t
>=*e_/=EOjj.Zrek+sKB-C9KcD__H09DAm,=uqnPHjr^s,>eAXJN.`!bBn_(3Rt\FVdgc^r'
#>St[WRW?)Kpq@MB4<MJf\:(:^ND-,qaKeRce#Ol_jVm(Dg`B=c$&=J>!$hR:d)G!lC@8SMV
f.pM..p#,-K<]A@GREm?-WnZII.a2qCC-mV[EcgS:')K':qm1/WMfjfGg-R&fG1<8`sYP+m:W
\;&_a\jJ`Ap50ND3pqBeS[b?@;SqF]ARXW2>`7o^aE5l$rtXB_<G7ke#t1ZeQ7W?_TBN=/NlN
B3:=Cl\60E_D23f[T)gV:9mJo]A(\r%K-blNiWFOP*GXGC^jXY?4u=]A`OtTrZ9QiN%p;QkAdn
bXX<6tCOP#'e)7<s=6(k:i$5!ES,*X3:XCD#huBG[kdJl:pQbYU'+Wl8p@;uW+0b%gB-pT,7
S?h@l]A30LOZeaA4$7RBSJk+>c=<2i&!^q;F##Gr%#)"#mW.sPSC"?f4]AjieK=VgfuXh609c!
0)gO8Co@/(-Frc66<0sh,RCr47BYr]A0gW1;&Y-:L9M?Ti[A2^X/ul/hag09B6I1L8ZgC^k>7
&;-%+=Rh\1/Ym7-G%EC\T?7b8:!hBT"petXAHg!cF;2Osg2S&u8f1K,bX=<s]A\/m=JGo.l^)
<O)sN%D7rSI<DV*14*%'/R,,Ebt?iW.:6"bg\kl<24=rm"G$!LZO/L=.D@k#f4+'.82<]A!LT
Br=IN@+n`p;tD[.LC]A"[b0/-$aa`-,\#0qQ7.$%eJ)I'k\K3qMiaLJAPd`R7&KR`J[u_oK!m
@^<IGN"I!;CDRkWp,!ar:hb3E\q!FfgnAh+-PcQpo8o9aEjTRFV\EAu\>IVY[,_W2$G'Glqm
(8+Ro\)=,5ZJnsG`/s>PLq`cVMhm/UEqh8/"%cXL@bhlT^"?S!9$^\ql3\n`f8(>!r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[144000,1064029,144000,288000,144000,144000,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="3" s="1">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'sepm'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'sepm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="3" r="1" cs="3" s="1">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'d3'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'd3']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="6" r="1" cs="3" s="1">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'rm'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'rm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="9" r="1" cs="3" s="1">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="JavaScript脚本1">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[_g().options.form.getWidgetByName("report1").gotoPage(1,"{temp_para_type:'solar'}",true);
]]></Content>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'solar']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="SimSun" style="0" size="96" foreground="-1564121"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'sepm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'd3']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'rm']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="8" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="2" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type = 'solar']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="2" bottomColor="-1564121" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="11" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" cs="4" s="4">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="7" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" cs="2" s="4">
<O>
<![CDATA[MWH]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="96"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom color="-4144960"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border>
<Bottom style="2" color="-3092011"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1513237"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5850655"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[c$=XYe,0/pVp">O.Ap-?@Hqr3Bq,f&32I6S8BYT,*4\J)HT&3OMO\`;\fl_HNKEPg3bI,47H
Q4WD:Xm9fP8W>2S\uIAF%kCI/BGZkPP4js*MKSHG/1=fAl[O5+^*`CVQCD2HqWF;1?oe74ZW
D*O]A1Zkd0bIM\^g>`TP#U<2`:>U.*u%QleM:o),%5L=cC[cK4uUU4Zf)?+kQlm:"bW7r1uRm
W&,6l-W!Nh[\KL[_?#M$9n)aATcC\UF5(S%(R,p?Md:R_Da)'6((EaBjspl,N#.SDg$54hbR
#g$'5REIT-J[@^NbBA$@EB:6Uk[>"D"f21FdNK:C\I\lP+"2lANf<]A2iJNH<Uf6LnsikV9^Z
dd.t>i:@`h]Aq0kZl?)=**@t^8\RF'6gt<@kW1MF:pA*2pA/ZH=IQ(G4m&*@%X_T==@$.`*eu
n*C2Ph#@<%)`leJFjMVOMW'gaa=Z7nVa>lH1(ecr*1eO13'Ir<f&6/1>/dEi+B><Rgk"eJaJ
AcVKn?4qmX2`/r%dT8JR>*`7OW;ko23UMq4Q&!ME`J_V2Cd$r\8[BZJkTBoJ;rB[J9n?<_A`
eIKkXUo<-c\WF7Hp4FKTpR6Ei5G=QEADp(8\5:1)`6uZ@KV=A*!1bmj$178ahrlNl%a;,@RO
9loPjXnn1\6T=4l!]A^Od2Chlo4G(_j&L/\7hUW^ScVb,n*[[6GR4+>d[J=-hmpi6:+]AHHs?/
:!0EoX5rjHn[H-'io>+1';L9NYVC4A]AgRq,`dO%kGG9fjL?N@r.2?`QkH_4<#$f3XSVp/--;
iU@B>Wa6.<"ruA4BG$_K4K"]A:TRfOo/Z[G.F]AaWD-_-brlo`8*R_&Wg]Aq-MEkk!!ESoNK@US
q2jk@%R7JrjD_-/.Ab`gALuW';B.sY!3tdmib7"$B/[^)LE2f[&*lG#brVj4b&0MHBSr90TD
NHu8EP]AtYH:gnsc#9F^SjF:)@]A4_@)!kqpV9d?TB)ogMGh3:A+i+!/jaVB&b$b)=ldtl1>u*
rX9!GPr4`1Y@R;iacDZoXoOG*(BnTo<SRZe,V2IJQsQs,#cC;JC"9W>SfFSe8$\Qe:k\R9Ru
=Yr$_1LoS/Vulfic&4n%dBF'X<0/gr1KXdLSYh_:(/.HOQss>g,9r/=]A.J7?7Otdt/t0j98J
@(rbT7%]A;O`)542hp:`orAQhABHlnB@3`lT1Wc?'NWan<hFIo0fd=4NlKR2H;]AR`1;CZi<^[
t'"fLI#T(r4'l=8K!qNE@hiF>Mmr"-mRs^nt5+hF->E=#p9ubQlO#:/EfkadOlc4a/'Xk'8,
0aJQJMuct;am3qE\@\E+>D846KYB8<1/5T.]ApNO,YL/"g]Ac4Xc;QA)-]AP$`Mo$LS.WF\F=^9
IWMeW]Aon_:G\SFa.C9cO;$d$4MZ>.l*W#npG/1-8B)A#9opNbCH;8+H1ZHro_oXb`l2#:CGm
U;duc+cVH=OH(U7"QhF'C-7dWAc%N(*RlX^M]AsWRbTEarN^qE+$"hrh"&NfH0:OBH9s8L;NS
u=;H;J$,*]A<6N94YXC)AG4+ne*UNfuD?=i>eu26-qo(&p`WY_;G2p=bSKQkFZDuPZ]AFtkMR^
A>"413^buCAQI$5U,%UaPk?3qO=$SO"&Lrq#4P#8S,5Mg=F^aRRj??T3D6C>$Rm33Si[]A"\!
4(BG)C!4`OXg\sX7g?<h/X)A1(]AJ%*!up_C(1H**::`n66@\7k_,j/5Cn;On+`=119btM$kh
?8-O=G1ca<d`"n`F)crcJc7P"',5/'7#2D*2h%Y(4(PfJV#1t9ALpc(+1b>[ME.O&EI(P\G"
[R!\JbiY_Y@_;.$+DE/ees"WP6Y6Ct'_&?"3H@Ah.4I3)DZqJe9s=Joe\L<+J2`/kbgn)8T.
-<1,<>609:$a=DSneq"K*Q#--2YLFYA8)AP,cech*2q3\o:AJI-\%".QW3)i_?>c.X`8/;1;
7%C!*_7MO"^-AeYJ"G^aUbtZCF'q+?'#?L:(ZQ39HJ"-OeKtC"j+su0rRRHg$\$DSHGmO1W7
Y"CT%g$O+1P[!RD8/B=kUc7W&:-AA[&<iBMJs+e!GVAq4Y_VLH%);u-TjmEo_&D_g?uqMmOV
R<eYihOd<`^KS")bBT@m^q<2VT]A;tZng^sQeDb#MdP't;+":L%;"oemHc</L7C9jGLeT6M3*
*58$DC7h`Znd-8X70&sP*+C\ii'Vke:^mB'?6sCK3#abYR$8r_f0\f8-R9EONneKPk[0+!a$
e\f-\2au`cqM4+IcuEBmIm;!/HA2>Um-O#>>:Ib>TMF7h[G\nTupq0*tLGi/DOoCuEhL'4Ea
tQrQ0tTm&8[]ASk(Mh(kJ-C#kMKTStkm8#-HTRj1'D+/p1aJo7F?I3:1&-(MZA<9`P;bJb_N-
Yh/LE7.i+r\56EHR\pZM-Ul`=',OB*O5D#=n<kqN=b**K9AkmL4iiaAYM?86:j]AfGs9`&2:U
T:,t40__?C88[EF`#5]A!@6>W[9G]Aulgq%5uNH'OFa]A`XDR^CndGWSoJm0G#;#t>8Y*&_*p2`
E*X8pWVrpC-Di:K<_W3h+[SZR@\4*<T!uVdB*S!%`WZqCMP6r7<XAmS!HFWqQh5#3*BfO]Aeu
8RJMHmkkXH4fQXG1J^igX_EpbRHYcX8XUDMHj)bIZ'YFZp[d?&:%+S5pgM`Jm]A]A38=hF6+#H
QY@q=^ngWp)Xl)qs_(1ZsV!/@odjtr3:%s7u8-;`P=P-9\l>;aaM"0F>3#[SU6aFm2*Q3&$f
3pG7R8\+3(tIMc?iUZSmO*`0K:9'uCl9JK,Ac$^VBYc/g<B/E*tpF,<C@5s]AjF^[V,sjPZDQ
Om,q&dhe_!RN(thmkdR=3]AAIQcNYagltp3:W:"W4Y[UVL6W!q/2nXtqjD&f:5XCj4_B+eMbX
W;W0kb:"PfIO*IAg^FdF%0/aMiXf2m4(+!P3[/8(5Y^gMW^XB14[?YqZ+C[1(.WKS1s8Bmi7
,8!$K#^MPrmNT(=-eiN9Vr$bN40HCro=8SVO[T6i$K$N-tIg6cf']A(m@o,Rl1Ot\g'>;h&6B
6?#n(Fr0I0e''0ohp%fRnoYi2U=kMFYPI=k'n+FOZK*MT6L`ui+T:q*F=`.`lHA(_+!?9;]A.
,8SF9H6GU8T[ADKbNi7QJr>=m4eN=*Z&c@Qg`6O'd>]As-Cm2LRl>7\BtJMC&^=[@JK3+R[t(
).HPT+QAL)OTi)FLIL4mM\#Cc7;"Ru.B</>q9AC-#.'QZ#rcR%MsnX]A=!M/1c%Mot\T(FUTs
5#rtp2k8G>692,N@@pDu9@k]AfmtSn6J^rtSYVLg"G:."?CL7$4]AJ$@geW+*R\R`X@afTdXcV
7hVq(,8J+`[J!XN('a'kUn;j9:Ch9U%Fr,84PJ[&g+W+OX;qN$k7blkHm4=Q*%-/K#eDMS,-
OWf0a4o:HJ;R0^FF^&!?i6/ktN0_hT-S0l.9ip5$"(W55#]A3GhbU$N5/Rc\$XN&6D(cEptk7
?.`GaTtgL/`K/#2T6/ue=YLaZ%M#WGMu`]Ao%:dnHXHqV6ZmInfJp(2+0g[k5bT`@Zmgo3^>5
oaqUJkN!B5BNj%%l/NY41EFb[riSBV5CiHi>Z<G6@8EQVVM<)`S-Ek>PD99t5R-diNj+/`qW
3$,+:Nm#`_"Ae73#;tY[WDuTgPnAr/n(DZDce6c,m#LkZg^U%HQ]AO:c_Le5!Pd+9N'MK?#Z*
gJ`mWRmu(G5M0Kn,:YKZ2:f/DA^SV"4C]A`l6hEi95LaoJXRs&f30`.2:*GL<^t\>3IDm"tiF
E'G)Rm.:ZbmS%757@Ip^`4m`D-PWZmZ/YG7?GJ=E%Z>IU'<).%k\jaZ+!hT;l6KHreFpX>,?
l$V;l-[t*HnftgGVTC[Fg_:=jCb)l/IIG,dV$EICt<VD2(F[t:#WH`m%I1"`!aPsP_2/3<54
`YcFKfO3Wt>@P]AMY=mC;tU-]AV'1-"eg-+&`f]A[HhA<kSf6<9u1WriNX(80220%7%T#<0V2>X
hg4U35Wg%$Z['KnolQiPYle%589r0bmr'7NFaP&jL?gRh+AX1ji!d&03/E33N(Hh3^>Jh#rT
4Dg8M;";lJl-#gSD&/>kR#<f;*"<S[Br[CIIe6FHR^tr3\+7WIAZ=g(.O0cufc5=sXi?L9WU
:gZ\R]A[YnB"LNL]AnQ&n[^!iaEW/TN`?]Ag)&1+hmX3XJCRXKaQUrds9?-6!lE'r@7+RYX&@W.
gn%NNYP#3XX]An<_+ggqY,7L8nc1lJmW(C'OCDO]AT0BpYBjno-S&kNe_[f8'fG+[")6,(D6b>
[**EZE0Dk]Af36]A#<*ltIQG\M=W/Ogj'QN;f^(RD<6,k,>[iGC/0"U0.Hojh/eU-q8+WjedaI
7E,66JHBT-FSsmrad%2iHMoq>!W.J4dXNeSp?h3$Z?in5jA"0^?Gk>pIC9[:j!Qqah]AH#<@h
_7a74Cj)=#%EI5IIL8'QRhk4MsglTgb#efsu*\>K+.27`>em#XnHlq?33IRtJ:B\CDWW98U>
^^Y0bc>n,oDL?6WhZbh+_kp<ff@h5'lSK,qCoH<QF\d1gZP:Z&9gPITTg`+j^l<.D%R\4k\^
qR/b^\/+GBB=]A$7AI!d)0"jR]A;2?0&.NcBeN7rf'33JMBC%_0Ge_"sPJ>^5K@g*N4CZ21FXl
kH@A>kMdIm]A>84pq,JC1G^jH+WM5,!_E^Rq:V9>T8:ph?Xe@uWiJnm;09HTu0gmBhq@;g#_X
hk@Pnfcbnj5!qj_*%5:hlXa5YI?Q7@)E9=CHa@$W6)nE@.\)_[p0IsIBig3@:Tp@?.>d&Vi-
moG?<]A_\Kg-fi)!P(ELtOE=T(l,c@^D_%M.<d>/r;RQTga4Oo>bY%/qNiHP"]A/g"(Ol!9U'!
3'?)Z&o05G_Qd3-]A,GdM#h9R4ZU3m9$IgWi*pFMG:p6r`$=]A"0p2@PfSrAWb0:8*X#'GF)Ig
A43-3WsG4/DW,RbJp5DPI.u?-iK9G("BqY=$94Q'apmqXuhE?nq+*8@]Alfd_DY(I#TF9C<Xk
IK+%f)R05c6sbfOuqjPp)l8^$R^BaelrHXKLDqOQD%'704(:XNHCJ3']A#0;8E3HuE$<1O&;e
4ru&(\MO*6r#4Bf'Cni3(@uogY*dXd(oNPQPnoe7<qpH0%R^?EeE2>Wm\%'!NS0IE0\1q0DL
]AaP2f<b1?X!"+,Fl:k3OEAc0CiI/L(sBQ;dP]AH^jObBnXepQ.H!eW!JfX4[T+r"Rcf5sJ9[R
I*D=*@&BQqFA34fh^[P)9-J$N>1RGT`gRlgWk?d*VIs9EinqCPOs3.<FZ11#,V'd9RG*phHL
^Zuc3cf`HifVE@f(GMhgWll^N;/Ck3RmSi*h@dm1W6bfE3"3?DNo2j1[OZDff6oYZ!H^Fp<N
o<[c:3sL[Je5fBpk&.u5PER^UNXN@]A4mKWMj::?4)^:50Zd3WfgmTL3u"6#Er>[l]A_61qV3R
bbiB1`@du,"D7&IL`<d0NI9<[C=&9A>\oj.%:t_?>+mOIm4#+>4j.u\l#;3=IcGhsb&/!G1#
l*LS\'?MD%4cA]A;C-a^[i]AD)*Q'Fk"q$8R\<rC"p%Z67j_VT<gH5b$>QlS>$;VY-(<Gp"<D"
;1IC2)K.d]ARTEaFHBV0qM&qlrPPS#G%!b8/'+SsEUFq#hnj=ZuQ$[dt?m^&`.ms_WP]ALnQn2
?UstgAQ;$"-OH_>cp-!n^1H;?/=nFrSas%@]ArO5bL&:_aR=dOqCf_?+\s\/[2KcZ3C.u1VDH
JUQ_Rp>ki=lr*V]AZ5"i%X,#f7%]AWmd(oIWu$_Lp-5D9i'"khL]AD5E4)SeWC2=-(JdAn7ZR'8
QdI!i2Olh*I`_Qa]Ag)C7E4`QB>kg-co&8b1S)DH,,rW9k4%PjkAl&+ZbO/m%b)Q4436%DI_u
0*r,WA&X#;tBW$*Nf[&=aq7H/m'a2^HC-2*gPaqDnVKkPJa"P`23tWPc3#RaW1aq<91??VZ<
q?`pmt2K5EJeZq\?J@EDqRta:iLgD.hFgU'cjgF%^OuNB/B,0!:9\2&finI*C/o>%5k(YE`R
9WY[S3bgIQjTJCJKdV,=Dm>e*VN##b$PUO+8T-[-lS1N'DX^0#7\6=_O:fK^jr\i6k:B9^YH
ZG)9C?u5oXSmY_&MA;;c`Z^I;@W^]A4"XK^sIdH8O(3g"WV/_l`I:IaoMs5[3KhrlOrh1Vat1
Z`jp!f.c]A9PPg0@d.pVD&9'aRIe>ok+.c]AkkSRXB<r+d>/<Z(iG2VrqZp.'V_;f7WQ4(U<@&
L;b5(B)WrK**4fC&<5Hok63JSLq`A+FNWM#p330-.,`r@I>.FaBZ4lc-\PBN:se(QV$,%$SI
R\t1I,PGWi;Olj`E:KSUB;K-:)?I#.6%ft'XGeDado<<#U4HHE.W]A1i_j#_J=9e9@V-W^(g&
-]Ao4$d^,E4#eB*FP^oHY;D6#^RK,,H"!([ip+DTAN'.(%,r(TEV5ir`)tiD>Cac-m*icQ@Ss
m)JF6b=kCs:,pq[]A!IA!Z%DHr,9k+U>lUaaY51EFC_Oeu_o16TBMm7M<7XHO+sAc1RKZSHU^
?Nlb!FR5%2F\'mnfYU^>l%+mP>bd!O2qo?%VTL@>J`e2YY!ECE,s<#7.Fe9Fe.`cF5?@OoZh
g7%>?2(T)dV^ro)`n@c5#6A(I.G"]ASk6FV#__4C>J"hkGBgR]Aa&Hj<J$W[fnU9>V=-"-<HCM
tZiut3WTD"VJu..L)GenJVY=A'Nm;3M?i?TO&@+V6R\Omfcsj9PrXQ5)_csn-Z.XG&b1iS+o
HYE^mSY#]A0IL8rQjFhUU_^$[VHXtJBPHISUet-ORc:;s(!@TZSI1N5pW62!U\C%FS,6<Ec$a
DWj<5Onb1u.>f5P9Mq!Z$95/#tMnR^O>rsSU6St&(#Gpa9pE`-W4,M.R"l$@&ugBSCAU#jOQ
c12]A[.I:6,@dIU>mLPk:(M.N"[=hj-ruUY/777.6WOtc]A+ud\i$NP,\oM[n!@iW<tR-:H5*%
9*[qgT"4.Nh<t]Ah;aaMGe,:A1f5hiGf'k:LDX9PUE"K!=Z6;CT(`cdP]A'c"TaGh.a3!id"gf
4/_%\c1UTZG3$!'ECoouXV5428N?]A")L%C`KMnJ<ZBpE"IV80'&-MPH^k<t^&pufuDN7$?%r
CZ>DpW5Cg>4Iq^rU1Sii?mb2"5aB&;sh96';h:)?@)f9&,V:PdP+>G$3.jjJN$BPq`srbM!D
j[62RfiA#rWU]AWc"n7q)pBW^=4%.WlBh$]AgK0)05GthIUIUa6ilm&*ZYJC%k>,pLRONLCSIs
Ot]A[id[MJ@P_2;]Ab:9[;+@u"p\Nb3@4"8cIb2X#)>UQ)g>MqK]A:SmK/KWWc&k_9FY[]A$=id*
c:inVXmJNb#GLGbPF=2(pY4?4.7o(r877^H4V%ZW*k>9r:NiccIP?csd&J>N^Xh38-2GM>]A\
,9#AJ,9K/=&q[BjQq"DIfVZ8T>cI<c'RQHR^]AYI/<98_Sta$u]AI]AeYcbCm6P8Y_B]A-_W-af;
F(a?DW-@RLLc-3&9fc'+5Jr?H&]A[5dud8`J7_P;>Wnc,rGg1J]A'oJkmo_!%gjf`-K%iio5GF
X%ki:5DleeNN!(K3D-Gku-c,3F3c\b!q$;GY17Xm9`c)6KUP]AQE$p]AC+F"T7m#d(4XeEI^,;
WO1*gUf(6)Ar9)6*^$XKr"F2_g3b"['E&\u4Og(ng+hit@gC17lVlL4*t_6f58955?"os,i4
6L3h>/%&kbgUDjT>'*ZLS3aZ.*FSCdTaOJ97(X&2a%uPA,?7ZWst]A3W,_p[8r2hA85@@)QNC
GlldbrKKW'TblQ1"S7rP_qGEgZ7iG"$..PKB:0u*icSN?mWk12ll7V)$'j_7*O&TS]A9l<W3<
KS`>030%.Y,R0!08+G]AR+V=c\HrBGW+_c6YsOU1Bq$$:46@Qb?BIEeJ\YkJ,b3-Y97f_jdCK
ACg&QZ/!m:[LTQqRt=l?8@UfI+5)'m\QIm\.'HRICnE^fOQNrGT<'.>X[Bs)ZP.#$N-Y=p\U
b+p1pe,UU^Oc9;ni[81^/*n'lm:A>MC*JuL3,8CYaZo3e)X(H&_%m=%'Hg4-U(KCNMG+-7GL
!+,`/^1qn*fF88M.0gOX]Ac"Q#?M<]A?X5OiR%!0Aj;^SGRrj$,3+4Zf,!YdM`!o]AGQmhdj4$E
6LR%'/qHrouSJ:o2Ffc%D?F\&>7n\NOJ"G,.jokH=,tV+FNZI^d%LpM1KS@N+>U<MoV,L3@:
RC7r1Kh?AN:P%\G<o;\@d75/aB&N]ArKgDa`^%B1!Qa-PGFZ.W/$jdf.^a!e2#I4Qoe"hLp>X
B#QA6BKM0[&l*?[5*m8]AF6PS"[fbq0)l*uBI>GiAp4.`gW_*L1r%/VBmmpVV_-PLe*.2>Ldr
PC9+RKhAe<7Ad`dRS0*AM!Y-Cbjg7QiR4"!n1L4KntajY.sb0LVuZW2)+*X<!_4@q-c9?T@-
/a*UuZ9$Y+Qs]An6D[68u=dV__H#rO\'.KAs=r-N(R_F$"T5u,#+J^;*3&oRZ3*Y+&Y8;24:(
_EUoa9a-3Gke.VX*+:9-b$<jXS#GFZR3&8W]A"f/);mO^2JbUesDR#XpfRHRU.9)>J_,<>sr%
d\WC>/?mN"[+N@,QO:EbJHiB=ppn$Ti:YMW)1'GJVm4P=d`-q!qSP3eK*m8$Q%A,N;p0VlNk
3Fp1'Ol>uP$7h0kJ_Y8`#Emi5Z2q`]AKW+1^V@SpjaG)XjR;9EN64Nm"l94Xn7\7EmpA$]A+?3
>f(BXMjO?T@CDqmf.:/W1TtpSXeBB4#8u`1]A^Ue!PpEIU$8M17r@]As<8hlb)!mm>Es6Y"5!$
S+ljJl`)oBg,IQ"s;I`.cB4$#_'\s6skD)4"j9jAMf6SbVo54!o9dG^"Y(!,kUudbRP40MK/
f#aB]AEGCHQ"qsb$CHZJU2>H:Ls>W4;-bJ)DK04pH*s%n@A&,`CP@fX0Ch4I)[YE9)E@/"Bt/
F<m&Xi9;SkAHcCcf&,K-0H$]A2;;pu>MjYQWA2Jpn,52nO-[MCJ]AIk_?d):'3(Ke0!)DR\I`e
[.RB.9,gn7<K"?+pon$Ue8r^H^9AZH<oFstP/e)@=k2_n*=[-WhP?M,Y6Grkkr5BCB\TGDZU
IR*Y,oP&f*/rrFZinBnGd`V5LCnc^bjaf_WaQ+Q'0gB,q(jj?k_Z']A~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="5" y="2" width="949" height="537"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report1"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1440" absoluteResolutionScaleH="900"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="540"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="absolute0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="540"/>
<ResolutionScalingAttr percent="1.0"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="5"/>
<WatermarkAttr class="com.fr.base.iofile.attr.WatermarkAttr">
<WatermarkAttr fontSize="20" color="-6710887" horizontalGap="200" verticalGap="100" valid="false">
<Text>
<![CDATA[]]></Text>
</WatermarkAttr>
</WatermarkAttr>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="34a512e4-6dd2-448d-8fe9-d27ce2b6926b"/>
</TemplateIdAttMark>
</Form>
