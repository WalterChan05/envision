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
<ReportFitAttr fitStateInPC="3" fitFont="false"/>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="true" isAdaptivePropertyAutoMatch="false" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="true"/>
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
<NorthAttr size="36"/>
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
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Search" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[查询]]></Text>
<Hotkeys>
<![CDATA[enter]]></Hotkeys>
</InnerWidget>
<BoundsAttr x="225" y="6" width="80" height="21"/>
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
<BoundsAttr x="62" y="6" width="122" height="21"/>
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
<BoundsAttr x="15" y="6" width="47" height="21"/>
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
</NameTagModified>
<WidgetNameTagMap>
<NameTag name="para_date" tag="para_date:"/>
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
<![CDATA[144000,1097280,133003,266007,432000,144000,723900,723900,723900,1143000,1143000,1143000,144000,72000,6683432,6912000,6912000,432000,144000,723900,723900,723900,1141920,1143000,1257300,432000,432000,6683432,565265,144000,1296000,1152000,1152000,144000,432000,144000,723900,723900,723900,1141920,1143000,1257300,432000,432000,6683432,565265,144000,1296000,1008000,864000,864000,144000,432000,144000,723900,723900,723900,1141920,1143000,1257300,432000,432000,6683432,565265,144000,1296000,1152000,1152000,144000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[360000,665018,1008000,798021,199505,1008000,1008000,1008000,1008000,1008000,1008000,1008000,1008000,798021,365760,2743200]]></ColumnWidth>
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
<C c="0" r="1" cs="5" s="1">
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
<C c="5" r="1" cs="3" s="1">
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
<C c="8" r="1" cs="3" s="1">
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
<C c="11" r="1" cs="3" s="1">
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
<C c="14" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="2">
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
<C c="3" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="2">
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
<C c="7" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="2">
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
<C c="10" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="2" s="2">
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
<C c="13" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="2" s="0">
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
<C c="12" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
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
<C c="12" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
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
<C c="6" r="6" cs="4" s="4">
<O>
<![CDATA[SEPM]]></O>
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
<C c="0" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
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
<C c="4" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" cs="2" s="5">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="7" cs="2" s="6">
<O>
<![CDATA[MWh]]></O>
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
<C c="12" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="7">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="8" cs="4" s="8">
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
<C c="0" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" cs="3" s="9">
<O>
<![CDATA[SEPM]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="9" cs="4" s="10">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="9" cs="3" s="10">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="9" cs="3" s="10">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="10" cs="3" s="11">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="10" cs="4" s="12">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="10" cs="3" s="12">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="10" cs="3" s="12">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="11" cs="3" s="13">
<O>
<![CDATA[计划发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="11" cs="4" s="14">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="11" cs="3" s="15">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_bgt_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="11" cs="3" s="15">
<O t="DSColumn">
<Attributes dsName="sepm" columnName="sepm_bgt_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="12" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
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
<C c="12" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="13" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="13" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="14" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="14" cs="13" s="0">
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
<FRFont name=".SF NS Text" style="0" size="48" foreground="-13421773"/>
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
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
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
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
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
<UUID uuid="bee3cecc-cc2e-44c4-bf39-8978d90c5e56"/>
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
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="14" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="15" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="15" cs="13" s="0">
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
<FRFont name=".SF NS Text" style="0" size="48" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
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
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<UUID uuid="e7edd9b4-8b41-47c8-b571-d758568d7bd2"/>
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
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="15" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="16" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="16" cs="13" s="0">
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
<FRFont name=".SF NS Text" style="0" size="48" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
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
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<UUID uuid="056252b7-4d9b-4438-b191-3e24b0e60be3"/>
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
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "sepm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="16" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="17" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="17" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="18" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
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
<C c="0" r="19" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="19" cs="4" s="16">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="19" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="20" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="20" cs="2" s="17">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="20" cs="2" s="18">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="20" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="21" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="21" s="7">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="21" cs="4" s="8">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=TODAY()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="21" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="22" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="22" cs="3" s="19">
<O>
<![CDATA[D3发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="22" cs="4" s="20">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="22" cs="3" s="20">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="22" cs="3" s="20">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="22" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="23" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="23" cs="3" s="21">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="23" cs="4" s="22">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3day"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="23" cs="3" s="22">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="23" cs="3" s="22">
<O t="DSColumn">
<Attributes dsName="d3" columnName="d3ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="23" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="24" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="24" cs="3" s="23">
<O>
<![CDATA[年可用容量\\n损失(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="24" cs="4" s="24">
<O t="DSColumn">
<Attributes dsName="d3" columnName="year_annual_avail_loss"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="24" cs="3" s="24">
<O>
<![CDATA[年设备可用率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="24" cs="3" s="24">
<O t="DSColumn">
<Attributes dsName="d3" columnName="year_avail_ratio"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="24" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="25" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="25" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="26" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="26" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="27" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="27" cs="13" s="0">
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
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
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
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineWidth="2" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
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
<AxisRange minValue="=VALUE(&quot;dic_d3_min_value&quot;,1,1)"/>
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
<UUID uuid="ed41ecef-2aa8-4caa-8548-acd3aac8cddb"/>
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
<C c="14" r="27" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="28" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="28" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="29" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="29" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="30" s="25">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="30" cs="4" s="26">
<O>
<![CDATA[负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="30" cs="3" s="27">
<O t="DSColumn">
<Attributes dsName="d3" columnName="lodarate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="30" cs="3" s="28">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="30" cs="3" s="29">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="30" s="25">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="31" s="30">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="31" cs="4" rs="2" s="31">
<O>
<![CDATA[热耗指标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="31" cs="3" s="32">
<O>
<![CDATA[累积实际热耗\\n(KJ/kWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="31" cs="3" s="32">
<O>
<![CDATA[累积协定热耗\\n(KJ/kWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="31" cs="3" s="33">
<O>
<![CDATA[累积热耗\\n偏差率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="31" s="30">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="32" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="32" cs="3" s="34">
<O t="DSColumn">
<Attributes dsName="d3" columnName="actual_heat_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="32" cs="3" s="34">
<O t="DSColumn">
<Attributes dsName="d3" columnName="contracted_heat_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="32" cs="3" s="35">
<O t="DSColumn">
<Attributes dsName="d3" columnName="heat_rate_bias"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="32" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="33" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "d3"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="33" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="34" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="34" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="35" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="35" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="36" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="36" cs="4" s="36">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="36" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="37" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="37" cs="2" s="37">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmactive"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="37" cs="2" s="38">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="37" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="38" s="7">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="38" cs="4" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="38" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="39" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="39" cs="3" s="39">
<O>
<![CDATA[黑山风电]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="39" cs="4" s="40">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="39" cs="3" s="40">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="39" cs="3" s="40">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="39" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="40" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="40" cs="3" s="41">
<O>
<![CDATA[发电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="40" cs="4" s="42">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmactive"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="40" cs="3" s="42">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmmtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="40" cs="3" s="42">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rmytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="40" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="41" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="41" cs="3" s="43">
<O>
<![CDATA[上网电量\\n(MWh)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="41" cs="4" s="44">
<O t="DSColumn">
<Attributes dsName="rm" columnName="ongrid"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="41" cs="3" s="44">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rm_ogmtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="41" cs="3" s="44">
<O t="DSColumn">
<Attributes dsName="rm" columnName="rm_ogytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="41" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="42" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="42" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="43" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="43" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="44" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="44" cs="13" s="0">
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
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
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
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
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
<UUID uuid="be71550a-ed03-4b09-b288-4696d7bfea72"/>
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
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="14" r="44" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="45" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="45" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="46" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="46" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="47" s="25">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="47" cs="4" s="45">
<O>
<![CDATA[利用小时数\\n(h)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="47" cs="3" s="46">
<O t="DSColumn">
<Attributes dsName="rm" columnName="available_time"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="47" cs="3" s="46">
<O t="DSColumn">
<Attributes dsName="rm" columnName="avai_time_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="47" cs="3" s="42">
<O t="DSColumn">
<Attributes dsName="rm" columnName="avai_time_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="47" s="25">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="48" s="25">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="48" cs="4" s="45">
<O>
<![CDATA[日平均风速]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="48" cs="3" s="46">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="48" cs="3" s="46">
<O>
<![CDATA[本日负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="48" cs="3" s="42">
<O t="DSColumn">
<Attributes dsName="rm" columnName="daily_loadrate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="48" s="25">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="49" s="30">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="49" cs="4" rs="2" s="47">
<O>
<![CDATA[平均风速\\n(m/s)]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="49" cs="3" s="48">
<O>
<![CDATA[0-8h]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="49" cs="3" s="48">
<O>
<![CDATA[8-16h]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="49" cs="3" s="49">
<O>
<![CDATA[16-24h]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="49" s="30">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="50" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="50" cs="3" s="50">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg_08"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="50" cs="3" s="50">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg_16"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="50" cs="3" s="51">
<O t="DSColumn">
<Attributes dsName="rm" columnName="wind_speed_avg_24"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="50" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="51" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "rm"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="51" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="52" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="52" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="53" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="53" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="54" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="54" cs="4" s="52">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="54" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="55" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="55" cs="2" s="53">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_td"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="55" cs="2" s="54">
<O>
<![CDATA[MWh]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="55" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="56" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="56" s="7">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="56" cs="4" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="56" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="57" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="57" cs="3" s="55">
<O>
<![CDATA[光伏发电]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="57" cs="4" s="56">
<O>
<![CDATA[本日数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="57" cs="3" s="56">
<O>
<![CDATA[本月数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="57" cs="3" s="56">
<O>
<![CDATA[本年数据]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="57" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="58" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="58" cs="3" s="57">
<O>
<![CDATA[上网电量\\n(MWh)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="58" cs="4" s="58">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_td"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="58" cs="3" s="58">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_mtd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="58" cs="3" s="58">
<O t="DSColumn">
<Attributes dsName="solar" columnName="so_ytd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="58" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="59" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="59" cs="3" s="59">
<O>
<![CDATA[负荷率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="59" cs="4" s="60">
<O t="DSColumn">
<Attributes dsName="solar" columnName="day_load_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="59" cs="3" s="60">
<O t="DSColumn">
<Attributes dsName="solar" columnName="month_load_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="59" cs="3" s="60">
<O t="DSColumn">
<Attributes dsName="solar" columnName="year_load_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="59" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="60" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="60" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="61" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="61" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="62" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="62" cs="13" s="0">
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
<![CDATA[光伏利用小时数]]></O>
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
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
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
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
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
<![CDATA[solar_chart]]></Name>
</TableData>
<CategoryName value="date_day"/>
<ChartSummaryColumn name="day_avai_hours" function="com.fr.data.util.function.NoneFunction" customName="光伏利用小时数"/>
<ChartSummaryColumn name="ly_day_avai_hours" function="com.fr.data.util.function.NoneFunction" customName="光伏同期"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="436f2ca1-51ed-4ea2-80ed-7187fcc5c63f"/>
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
<C c="14" r="62" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="63" s="3">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="63" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="64" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="64" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="65" s="25">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="65" cs="4" s="61">
<O>
<![CDATA[设备可用率\\n(%)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="65" cs="3" s="62">
<O t="DSColumn">
<Attributes dsName="solar" columnName="day_avai_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="65" cs="3" s="62">
<O t="DSColumn">
<Attributes dsName="solar" columnName="month_avai_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="65" cs="3" s="63">
<O t="DSColumn">
<Attributes dsName="solar" columnName="year_avai_rate"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="65" s="25">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="66" s="30">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="66" cs="4" s="64">
<O>
<![CDATA[利用小时数\\n(h)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="66" cs="3" s="65">
<O t="DSColumn">
<Attributes dsName="solar" columnName="day_avai_hours"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="66" cs="3" s="65">
<O t="DSColumn">
<Attributes dsName="solar" columnName="month_avai_hours"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="66" cs="3" s="66">
<O t="DSColumn">
<Attributes dsName="solar" columnName="year_avai_hours"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="14" r="66" s="30">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="67" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="67" cs="4" s="59">
<O>
<![CDATA[天气]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="67" cs="3" s="67">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="67" cs="3" s="67">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="67" cs="3" s="68">
<O>
<![CDATA[/]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="67" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="68" s="0">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$temp_para_type != "solar"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="1" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="68" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="68" s="0">
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
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-5850655"/>
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
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-335924"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
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
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1"/>
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
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-4596573"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
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
<FRFont name="SimSun" style="1" size="80"/>
<Background name="ColorBackground" color="-1512984"/>
<Border>
<Bottom style="1" color="-1"/>
</Border>
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
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[`4C.l;sX-8MN-J>OY4<TL_+kIl-_l/'IglF6:^8\'r;6C-m0OETaM!b.S,>J&paqV!24eV^!
GBpr9bT_\DJ=eNr)VlaN@\-cM*lN50l%BPo*eD2'REoHn6g",5!>+c`jWkJ[)Fs>N0+%Y3<g
'A78pB(oo/;)#/R6cGG31FerGrdR?2'5I2eldmaua'4MW[Y\9,A;SS#tj49=$[h8h>Y&r=BU
Fs;c]ALWL+;!8OiV4gj2eK'!%Tp1nXS>0spSih2PlM[hBkhI\d(2]A.c6j7,IHhmgqi)YSL(73
n7L>Uug"UWmF=8FD4hQQgp+AT'l51GQuH"W!5QFTDm3SsLJPo:r,Rm&NE[#oP0#isCGf[-la
UQ,dc4ja9F6?!(c_V(Yhn3X_IQl7"k-*$MD6ap\/">+6[nD0kB/-Jn/=/YKu,riq2POiu!6m
("U*_?/Y*J#3@HMWbjl4#P#MCoUWkn;`momN\9k$CtMUim"!YBNI;d9Or0%e9$=IB$4u+cc1
5(aZ\@8:j]A7a)E2i$JZp#]A;=f9k,t%I?sB=_QI+j9Y?nshVS0:XEt$2aC7mkF)<1+MfAP^<'
=RYS/<(FPE:11ifc&:!&"5hjBG?=9fnhqc_(IOep$$pb8a=3nF^Yu:O!PijQRKQMZMnqGl#7
4aJUY^m^e6J37Ne8^Ms?)q'RZJ.OnRSOFFsKj"k_+585j-2Gt0cs@E>+hB<=Q*juipld[&H_
F&7OLo&04jd/kUkNuBFE+HZ2$SV"qBkJjA#aGhoV);51#pR?s-gF!He*`?[J->/YRgkuEjCS
<C=1bFC%m]A1YBBYsQT5`aSeD%P@pPuiM@B^u0Z]At=B-opch\mI\E<-%3T"DD,mVedm0GSE>:
O#,aJP-i0$N9G@=TdL:;7[Xfsl/@Z;d)&8O"&raE&k1HV,`?A2eBX1M!.8\*@r,s\sddb\Ig
8mX12C"3(,8qj32sEmdI4R7icpA&)(tmOskkdR$?c+ueOX8W`GJ)%=(`O*Da57&5WXlRXSGm
A&mZ!&3A_R*7bq0^X-,[J0\c7Kk.6EooM-56M,`2\&,G*j*FF'reE&suXPP6/JHV8$LhL@7;
YiY+*djA`SRZn:-rQ@Qm.YslX@W7JC2,K+6R]A?Z$F14.Dmuf]AdGdsc5bBb[D*1UGYjLlJh3q
Ok1HubYjq/paZa`BR.mWIh%Cjg*7e0HHC"ek;i^Fs[j@nY@pEN!AgCRYs,_;u4n2CpG#0',Z
AAEB0\)3q?WML3%*4u/O4?$S'Q"O1-KVXjYfQqkNUVV.)@^B@0Pn@`LfZ6T`K.]ASbA0BmAGs
3%?6/7;<LJ+Ke*jn'PDi+\*5fg4[HaZ`B)3gk0Pg"@jUT-N61]A5BKeU:(@l3r[35$si*nok'
5k!M7D9==qoaS*nZ13S3/,R_KPY53'clA=Eug*]AI-W'hpp.lmQ.36>O$>9+%e[IuR!gFo-$t
#I"93biObOQ_V\FGn$Hg/HNt7i0D$;?$8dpX#!`n!`W44F"QOC).G]Aje:Q#qp9$[BQlD[oU.
5T6\@hW#f7pXj"5sJ.%pQZ&L7BiaHtn`>@jnj[bZB-N4[CiM5ORS5iJi0^MZb-o@*M0;-ER0
Ba^=^FH'$$-j2P,!QflC'AS/@24#=8Y@G"!:,PF2jjM^?]A(*dLW/M4<^G?`JV4$Lbk3[lo7q
b'*=^W#!'#UXnTmm"7("g8E_\_h%NOb!PW.r/p?IYXu;LSkCU6>kCP.iKl7A4f_;<'.GZ1]Ah
8HDeVsI#;b`SN2mu+7_Yg"fJ31jG9kQ`8hmmAk:5=m$@O[Q_22]A(9Dl"0))n[crm2]AY,QT-l
D>)]AYSS-X8O13l@OXd:NK>+ob]AA\_Dgcg'(Df5hQ's\J=ml`nl@S`CT>Npqd3&idr#J)c!I/
nZc6m:Ob'8m_m)SpKDC+8#_'[B?8.GADu=thq<Z>h@iP6\GCaZUnaSU-cV520!oXqF%`7qiR
nq:6Zb]AurfXqE'hiSQDfKmuQ79BP/2or5V4e+H'I<ZGh.cOhRm\Nd4\c3CRi)7V05!SDs/5m
T-YO\t0r*HMOR_r<m@IC`Z.e9ibA!`@_iDQK4Ti`U3$d0IJ$h[jk9i'&egUEAWA"Ka(hACfd
%r(TNeEk&miqqA5P[5,fjbIhs#H$/QZ^Gm`<8$GRO-FdSr4,F8I?-[^?5TbR[f<?Q-6=`E#=
J@%_fkui-95u-:=Y2t<:q<JRgJ%W=udZCYGlZe7UV/G\i\h/%P,]AE'%L\36%JDhK8?oVF%*&
Qp_S(Nfd1n[>nJ5:0.Wf]A^fk>c[gctG1Xki"0TGLs_$&kkn.fY6MTdag25+6=t@5t?(Y"GAU
?O"6]AZ.kJeSDc&,sC."8K!JuJWY1A2Q9R>6g[)7ui"J-.(Ii`abhE9&'hZUQnPI0D7>Y$C3W
ZVsGhKIU!PkY&X;S=a<CXu&*.U*W/B;<`XK0jFp.f\PR,4EQAcY70#-53Y1@P1ARfsRP[Uf%
gKS[t6ci_n;<\b#KA`"6>N_c7-Lpk.<!lTCHB]AT_.V8-nB"F7f@o%hKnB`j$1anBMFI2@1&3
$3_.j(C2m>h0\GE&WZ$o]AiY*8`6'iC8)1:.JO-"?NWUR!ohb:]A(-TANRE7k<8nB./306U1A^
S"C.h8SW3-QZ;8^.!RP2:+`O1'NF+g"[md?M]AX:ur3J?&VtWTSfb@nF6)BbWko\DdF7/Pa1n
+;!ERZ92Ff?%6p2B9f]A)"U&+5TFd3B=_P;0ZPuQUE/M#P#IE"PZrJIQh4Z""J@)4#D*(GI>^
YF>>=iR+WJe'8'hoKT\Y1>n_q[:N^A!W$X@mu"`\OnjG^O4QLFC6[jR''N`-!e?p/\,maelW
m6>4Gg#[<GT-,S]A2@6$i,h*O*j6NcFNQfLM&XVmNR,g1+0*S/+qV8U-D-peh1YJB%_U,83oJ
S@JNkH^'u7`=..SS]AtZtO&a[,87Cbnr)^<8cq-;[BDKSUg_>!"]Ail&tZQGFACY!>J1.SoP&&
<]AiN%5'6)K5.W-$XXZG5AiL6XX0FGt3XaWIEp">p]Ad5*0alXSfsT\$CA`o.XnT=r04_;c>O2
(N+CiT`3F&1%;n[#DDI=uPSK>([Bo.8:).YnY#QP\^knSY9\Gf9/gR2ni#b?68Ffu8e.fJVT
#\&&F=/dN1"Qd\!$Dfc=V8,M%Y%MeJMKt7lJt3B(JGUS<cWR41QNBhY]AiSU!*\SL)PQ&_q*:
lS^NVNM9^;^@-&Xr2d089rEY3fFW@*gj5qdR6VCD11#<E`>W+<3o1f]AsuSGTf)VbfJ@]AtNk/
q+&NS#3A?(;-rK(c`6PdNN]A=a8O=L0G)@H'/d%HT^M4_gM\6n]Apa=5.Bkjuq"Y#]Ac?\kkbM,
cq6L\"O7]AePZm*@i.tc)hp:1RF1saGbIjlu6=Q54em(8LE4%fs$b_]Au'^mqHGZj%i<oCd;`a
7?q&Zr@]A8c++X2$34cDdpp6N%-&Xdq0(-2-l7nq/#:uPW0%e\O]AhB*\]AOO7$qG">lcKkjReC
Z#QQTB]Ag"IFRsXkFONV@P@>O;epJ^L;1&#K47/ei6l]A;>(aQcXYP5?jb[RXJ5D_<e02P/WT;
DB&]A;RG;oQAIfPS31;7mP,#8jf79,2L)-:&U<lQ5naJnq7;`<>_G`6cI!&p@G4;*P$u0ClX"
ii`sV/A]A6oQ.g49*GG>*c$jIjnsLcCoaQ?4i")Tn.M=X:#fHK]AhW4WfIh*BSc4G2&p@+kk`i
plig$@1G^'geP^\oc'q^&n%oQM)=mkH6s.&Gbe+9"%O/0H%\JC\#%k5qW:h:fRf+^f8rQi2G
.j(i&OS6<=ec*&c3^<Xr(@`AUf@5JjMmtpmDlJed3M`rbMN6dIUnfp`>Dum"M3efs'@lT,Kj
JYkHma"p_*1nXgi):edAWla-"p&*Y<CDY*U)d1CFa:\+YSUFuRZ;A!\[1DY"--'T%h,AL5Xp
#.I!]A7;PQ,LI-up(rhHuP6FFA@`ME\(#TR-GX]AJ]A"q,5-j]Aqj=a$#RRW;I(>EA4D]A!+IMVtY
_2bMoPPT7A*ol<*KtP`)pIX36;h+u>Q[iT:VmQh:K35P$SqfO5@[d41<(fQ+$g+231(-d4=N
->(ELiACBCp5efS/s&TFl)t5%]A5D_u`7G%#Fa!n"YB=,./X+6=Z;6<XU&Gc$Aiu?iscT,/]AQ
X9!C.N]As--42Dl%t2k<-XV:.;YgWpXWW,L:D82O5uX#L@Hg\7W(FUdXEbYs+53dW\AV8mP2/
E6`UKpu'F1sqJV1mFXS*)2WmNf9S>7:7UdoJ@T;AJJ.3\FjP\BkuAIKmc!HlepOT76(Jo:Bh
SJh:jPXMH6rHj'MY\<_J"u9Kd=>M*#%daJ[k2`7J-fb!9_hWo1K;gAK(.7Q#.W8.!_LEJLIO
1?W@=2sU)X?cH#.:NCE\HZcQb)]A,e9MBl1g.IbelI9->!ROSQ%_SE*NoI\4`9k">*GK4"2<b
ikLHggXc"p7/a]A*^4u+H3pjAVA(s-c:0[Y)P]Ag,'J?IU01&TAi(+;,NWNf_U^)u'NYrn]A"@n
#M089J`F[X_cl!\Fe@g:BPAlQTgIoF]A:CW\_SUlmR#i"/M$<sF=$NG/^a[fiERB*9A[_s]A14
4c-;b%.,-/"?>g*<VZJ?fVXY/97\L"Xrq8&PI)spI0)2q9lh(HM)pB]A,1_D?:h)_HfF&EZf-
E'-Z`$ni*?as=ON\U(R./Vq%aDNI)<(/^01c6k!V6aZQeFWq(;sID#7gpN(KX:&L<!&qbQ3-
9?ueDBGqenmrdKF2Ii8uCt&3R:TaQdq<<^QoL6g%oBGZ$ng0;LECo8a#WLCA5K&">\9u["&p
'UV:DU*HLrD]An.R]A-ISn<32S4FZG$6rbT9Gf'<^q6`^<-&X$J`Q\RgA_io-[K"UWs="T4^V0
'md->-R:6e<etX;=J[V*(d#F:jGLL&6QOk;^6mCeuP=P=p+/2gV5Z,Dor(Fb8Cl'$jQ'o)cK
j*Hjo=6^9AuoVcG/QN1<>1%*PO>]A(R^H;ph!L)ALP;Y("&'gZ9)<9D:q_qVC4Y8e4X&21EU_
WOhY4"C=39I[lHf#-6g*==c7[)q$-kiq"LtjOa!uHM9Bs!>8e%j98En';WjhhR$rrHUQ-0C%
CiDO%%m]AY^d-iW>&pf/ua.4rJ-L)SOLXSJT=LrE<)H'L:3CirY;Aa-U,6KE[OUheLLeQp9N$
Fh0=MB'?\5JhgHZ+p1f!\M[.JC`1bHGT;l\cWJ5-U?-HMcFm*Y(fDGSd!M.CdX45)"t)d/-8
_m:okU'JhFeR/M-.n&(sTK'ki%)[.g`HX(m+E8PRV%qn;II31G,((&4+'R.4?i>sEHg-1TNR
ZKgk0.3^_.5q@V6ZAjZn$="II7!P#fT8LhE:H64q(kq#ffF\fSluek`Fmt^RQc?JV:s!LVm[
#ohf5W5S_hPd)#n%b_lo"H0r+YVoX-+V<%ZuEXheT3qkiRdog?EFBE.XR?iipQ#PgJ\;6uV<
FNt+):K`-s74,C^5<tN<kcU5kg=%+ojL)J2/HgNE^R9CQ%r*D!Y;=i"'(/s>$:`\+hTJV"Iq
;fpo0IpAPl-7MJIi,\O`eaqRWq:+L;"_A,JC<*jrCU>c_J^+\4Yd]AUmL!;%E^(O+'l5K=b'1
[O?kVYrt$YHaREl9%fFKq;@mbkjmK[`%MX't,)sDC;GKYjidL1P+'NnIjS(]A;I=`C/B1^!F.
haISoR(skP:$$<8G#JqANAPiEVU?DN]A+r;s1a$Src@KO(Db=8:AXs=B`i[k=k9kIEpH!g0Pp
nr`!sHN%(9^CmJOoS.@1B1Lc-j'9Z4Kk@'.u]A85J@2DU,3?'\"<akD^TMAjn(+Z8$#H/V)3k
5s&qN#MJlFL;.jTB[5a2g]A]A,W<q0u%j`P(kTX7(]AJu1Q<d8\FjkN!#pk?1(PK'B!V*OpkB]AR
eYZ8-Q;_Rt5uCZ[A^K1BmC/?'n3;#[Zbj_:&ck4Xi07LIZWFI(KrqGVA;0J_Kd7C`JUopD`T
_/h@*,(dm8t04&ZR!QEdfRh7\(P$fV6Mp%Gkg6776Phhu@,M0WhN^=#3>Z,nD'ui(_'1cb6?
(khj#MK+"Y+S/mZY8\qr(E0oU&KuHYcsW=:#h>'`_iH`OJ\9rT.Nhf;%%.`UZ4@W81t?pJYf
q">^T)8'Mf=#CmWB1^S6Mn^dbH&.OtAV4r'49IX1We=8+pQ4s,;jrJtp+)BhhA&*-$k?ru2A
Wf2/@s1Y'r`>H#A;1KYM4h;!lD[k:Agq^W1eNmdG@>me7/;H$#pQs/u^lHs@A<_U5f#p9">M
9_,#[gi3bs(JkCquWm.jf1pZLCrC!@`,XBW3(Vl,,o1J9tQW"ILG;@Znfb9\5EbZRk)E1S%.
P'OhNd)mM(,]A45]AG;a#HgI7CsP"It:2>C0NH8G1REH%g5]Aiu8>p6Xg),&0*=t6<jLJI95!*U
=b"H;5-+-j#9,gqXEYeT*qn)e-oXPGtfe2P9YB.6SG7r1MKFa!a<u,?2iN8a=>l)&^,@ucY<
I^M,rf:6"g?#HK!,fp05I@e7E3eBZ[(@b22P!(.qMXN^+^;]AO\Gl%h)XI-@b3VnY,?%[s;h%
E]Am.YTeW'F7`rTF<fp9`N"pRk8m=7QC*+`6TC,Ri=mHrTrkV`?@&a$JDS=B/0'r-RE"=FNV$
]AP/'q(q"kc1QIR%_HsiTQPo'+=0ZJ5(#,o#hk5KOsT?*L49?^/.XKSZ8aifa4>;:0CLHTQp$
)GpY\!15R!i!9=o7W/q13W=#6kCC#b+Y[-4Ga5eTNBd4PN,e"rm.TW__-c'7*P!s7Qf!49O`
Xl`oeDal`5cB<P"N!_kTm(P]A=<DZRHW-Z9DP$Oa6iqRq&D7MZqCk!.mu:PEb@?C$#8TBg9jR
)B,0FBrg";RdRLKL4Z_)XqZDkn0&i.73fu2[erI/81;/\g($[jJ9.qWcfh@+P3\0"kfjB92U
MdYb9Xg*'Y/+deJNC@@Nq1Z$+%aE2(qNo[5W>AhHpOkY-h#fJt1joacPShO#FiacYiS-5Ua#
"[kn^3&Iemm8HaAP'4jt5T*pN_s">\+D2V:X]A"<NE>8!=UbGs1j3'<js72dE6<kHSA2nhl49
C5.YdQ/u,ESUYrVed7ctOQ1?*^*#h*Y2TsGU-/kaD=IYl(MgcqY2eke")CfB.$cE*\P@=]A"H
D3XLlDV4L=s(#;*ZCf=#;'/^/\L*Ug"(X^MJLB$cj'I&^>_HPhI8>DH&O<oRNEF"+gktE@5o
chioM@k]AQICsQ6/tuTRE2%)2o:bk]AEI#LO:c/)ipSQE;GP:bMNff5t9c<`P`N+,WS;nK63Oa
,=LGt6+QViQnTu-,5<`.j!if!9\kJb=@#Ou^Ur8j>pQ/dm@00$#Nt)VRkPD8B$;gqOiK92jS
QrL/t&(/WbsI2%-h7Vn)pr^)GTg_=#lN=FFZt8IY[P=ke+2&Qp3kp$RH&0-BNkpN.d/G(6Pc
p0nmk'XTr'&XUm,[ld51-5Js5"lcZsgHc#Yr!67CP:<s.h9G2CF3hk\5#X`-prT+?98,pnDj
kj?F9$7:':A1&T:TpgX!@4aq]Alu#mR/1`ch2q\/'P?Lg<,fW11RS=_,JC_taoLoQd7lM_G@!
7(@klY5Jr`]Aa6'I7b57Q$T;'NmT'\crbX@Q7pbV's*'D%h26,-ZCEm[X7ii`rSD'J_3!/fi'
oO69*E9k#aPac`(-8BBHY"U1O9*JcGFg[nEF6kbR6mK'),`7TK$nQr.#Y&P6&.-0B[]A"ZfoJ
M#e\@n$7^QM^=,Ypa41D:d=Hu5C=`093CVgedaT7A0J;'hRh2]AGV#Jj?=Iai:r$YcF<&mb,0
N*j@1ZdC>FB[l&R.?pZu#c_ekJQ`25X+#[;HC]A%W=*LA9gCnbj3&;ZmUf98`u*ZjBa-?.9KG
tStVOrt2Nhn5eE1Ll;'aF-g3-m.6fCT(+NOPVn&5!mPtCbrbm[B&/uH`epP-,]A;O8[gG45)j
:)C(8fd"e`O%;bTd\8m%->EaD*%g.)En?-3:Pf^5n!k*?4o3ai`M&S-.QUCM^*d9VCAh9J;T
SoT"5>r$rfp4Ik?SRmB"!M'^ZbLWc%+bg&5gc&@/@`KYsrU]A%D^d#(!f3QLoX#6#J>i9J^]As
lKQrisH#M2*I&5]A&)b7!dbe)"X?$3.Ejod6EQf*iT8<Q0;eAe=[<kQ+0tg&hLBGn+kVZWFm;
,Gh8tN7A(HH(!_+dJ4N?c-?XhN$7@8Z<,'m#K&b'OO&Gh.0<Jl<A;EVi85SRjO4I['Orgas5
L1`Tr9C7J#!l!$5$U^2T]AjA%/7!?u#,l+;2,hG!COAS1!'dhSgTD7F?>R5r/Z*]Ab=#>k@P@!
g(EpG]A8,Y/aoK94"\7)(I!Wn']AIAu<T[&qgAOKT)Mm^Z9K@M&TG8"S<]ARJO1LC=+4=h(SSDC
.Cgg_p*;LdhBgZdHWuo"!S7lf*VA[0(S0`]A'D`tq7,lDR;^.&/.3`*C['^Sr=F0+eGRSFcVo
-g&pZAfZMRn`Nb;n8WF<SRWUp1rB.$!t5_df1+2aZaT&R.F)@U=[V$fL)I<*GDI$()V%ZUn[
(Q9"-c2ZiEUXM#)XiHMK-Ra["R2852Kb,cUBM+eL=Gm$G\L-o1rIdm9gSNeNXP>dkqHLo_G)
=5[U;:KmJE3McI'?L^FG5)LE`u>5RWM/sRIb(`:p+ee-]A?e_?rcZt@0WP31Ok.u@,jDnFGpA
m6.DSZe^>BNOXnFXRJK`u/N#'8%UmMla=4U`a%GM6`Z;i(a0M5l&,;e[.UYe/COdZp12aU%T
KX.F*W.AQWLoZ+Is&*@o$k>iLg"uc.IQo1A0;h,QQ![-O0d[82O?U,,TL',MRfPT19sDb.nT
9^s8TG0?V?i;0DlZeUF^mq#\!8>0@QW)qdM"p);&k'R81HrQ'_l$2ah1mU^RDGVBp]Ao2n/uM
2q;_EGd2aJNND_^(E,VU^o_[!b"k+lU"@i31pb##Frmu;Z$?nP;#ufPF'3#*Uar`IHL^!^;!
5CiiCWuehDh1-J&[J&>`l<:]AbPFKp[^##.caMj9ik98$4']AS:Sb!_cgK_h24"k8fB1IR,8gE
7T_BeG"'mL=P/YDM'\1TZfMSJQl68gT:X*'e(?/@_lh0P5-+4gX#49&DSm3C48rOJYVZP$,!
>8>BXO,5M,'?0Qfs-V`]AR)gBWYH:4QXkjE=&Z8$ZP#$0B\^GGWC+".48l&+dRW>KtL*nR<5U
<GqK%ioR68Zg6gF"Z:?$rrVDj[\"1n-P@_"DP/[Ca2m<FT.<dIIhWEB:k%N3A1Ko/D;GcJdn
d>YFZ^G<"VN7e&o+kA.Y>-It&)nO(K)+Qi;S91&J%"&2FE=t/6J_PFSQcVPki*lFQ.*l-rd)
1!hJGDmS@gR`5Q'20I6g:G!PR`[,Nf!-1If`))B4_Cj^LOgd`7-LFtVTZ*RDZ#KmbQfr00Jt
SoBiBsQe/ErrSUU6e8!YTj&@X?R\mU><?["*SUX?]A/MfI8>G@'s.Cp,VCK2%T4<DD8g9qPK_
lrouPl!8(oHH=!1.D=Ml^86b@S\95Qn,U#VXl8ZHBdadWmY"*L4T/BVnjs'21?+A\ND"'hL:
ABj>8;!VfHA4fJ?IKKEHr5[?!Fj,QO2N8W^A1Q)]A]AXI]A!t]A/d343A_<eL5>H7Y`@8jJt%FMu
^,1EDo&=Gi5+]A.7MpA:$2((KM,?1<TDol6Da$i3@t/GFs3+!"f5eDhI'L:STB&#Pd#Q[ZC]A@
C.MN#A8=S=ka]AL$A7;c>;VP,(X%$9]A!\^>H'&bXeTro%C7.)LDI\[u'h42V2@2Mt_.]Aop[h"
Od&nB`G2a__s[No2M\Zh:g$t.#SUofU)`9'V_;9>>B^W@`<qV6tjA@a$8Xr'8:T;S*K)*:gp
Cs:r8f]AojW9J8Hm`9Q]A"P7/UM^E3jcB,0L,mU1BD6p.U?T-6hSZLUka;m'kap(?fU\p1NFmo
i&h666uP;cR^=,5CNDVO/kEe#k*7.&R'oILDrj$]AG5rg&AEeLDJ;k%h+4QB$QGYHV7Z3Lq4p
n-"3NLKaX7?Et6#&MaKu(qkmogZI0_n+lFJ$A#=d29\p_V2\!ud2JaZmfp8\TL^m2iAJH35]A
,3UZ'P6kDWDu_aG7hdFBeEFI<)g#u6u*!;pM,R81F>]Aibo-8Z?Z\"TndeDP(VU:4mcoZ\jPX
+.J`+8jN&J)g@b"LNlMYGpS<B,jQ/J3"!j9fV/@<hJiFitTS'/9#)s<1NYUsjf^qCe:BJ2Sj
H55NVPZ8^/?_RsEeCc#aNAnWK$L+hKr-daPqVs)bk"c#/[iY4^"uN=<:_NQf[EEXFaP^i]A/0
80gJ7_k;As9s7q0%b+J<bCgQldDScq'UhD:s),:?=P]A&PS'tDU[aKfn,@;P*b`D4j3]AJ5hmu
19(DIOmGU'gd]A[;^RGJA#0E]AKMcas"MT1nT\+VJF(nlH_#?iNZTi1@VIel>Nd$h4;SQoFfAi
[<O$Ui(NXL^NBr<3*d\!9mlWa5>>8=sit8NW\E4-i!DI/EkcCp3^4L,amUA8k]Ag=1,:Z<QM-
!qlF.jWPK<;.gjM^"[YDb#CV`:4c//S&cAK?h-5RQ:9_/paibY@:a-0QlVo/:\f$rW_pBs\4
)I:'9ft=Y55XqBqYpU`O+5TcH-GC7<`qC=V0SM&"<A&O6J1E9g>l&h1XX@T,Z!G%UQR0=CZg
J7)AQ=Pji`DUm_[ILMVl.,k)o(dT,Slqb_^"Df[Xi'..E1:go#5kU/)j^"4sE8op?JpOQ_*E
8@sglRf4rq:b\hoZ#!c#Uo;%C#)NM1Bo)i&$E".)t7=BJ)=h((_g#oia-,K8*TW$)ait,,X.
BU)_i71A1(S`s"%78oMKL=Uq="J%=k)<NuIoH#V4[)]A<NBOsmqm.pY]AuRPl)>/.>VRYZ&b'l
=L^'BLa_!a>>Z>fWJCsV`b'3"!U">\BP<$aI<%R9G8^+r(VJQHr@r(AI^4@jT"6"J\]Ai'JR$
NYqeep7<nkH7"Rr3PJ3f9?jZ)1&V)t30F/?jN2htN1^TQgR;nE1ON4N@]AgB1Nt0.3-)N1!JW
\a2]ARhjk0Cn>4B!?!T#"nIA`kN`R-<`MuGbncrf^0!5nR+MpT,!I_IakZX$4J'Q]Aaq'C_lgG
Ec>u-b@VF<[C$Uaq1;ED"'OZE595XUIFM:/s[4jE,'Fk>nHLhIl@kDP7#S^*Xo@E3`I1^`QY
j$BdH!_/!nOH"8C&mcO2O?k^R#>@0>B&b>aEL%_TTo)g6EbHK61Xd/r3mum79U&hgWg#9O!O
$-ma2V2958JCRen=[N'eJ=E+&OJ"ZBa3-!"t.BY'_QdsH0`@prBIBm!$fI1$ZM*^GAndcou>
oU-@q&7Y/BJ&=NYa*?m4"W=GlZ!Si#oR7K3i=:N9P(e!A>-0'Wo]AIP9'!9MXL2dYr"&E3PX@
IN&ejT]A1R0>GMePXN-l//a`5;+c@?e&?cAXbYa^#GdgWM./OpWSS!Y+/\W(Z_%BG,p9_$:\$
M^S5C9[lP_M;]A&QkL*-?I7:_b28$/#h$heNdEo98Z0E9SuNb-YOmas]AfjP6,a'NLuEfAo6$3
nprgjPH2(U(q)5Wq<\%hL`Ji*Egi-$=q4P*sjY3"6Yt\Lg:BK$5&oL>&UpSg+;->%8mj9%/T
2)R@]AYOa'ELa@&i/9_i+/W\=ZA,e%D%laBmc'A^]AreVi4\HN58!7bgKuJBc0=n:UTA0SNJ)P
-'YZKp]AE$g"k[31+#ElPQHs&[MLq,8JJo@bI_oFLH4\HUW]Af%t"3'_aXB;#!,\-d0Gt]Ai>^M
l[.dGgUV_>Zf,E=)[RQ34'UMc?3Ig=1I.Q-2cY5:,<&R@q2FM.&;\:dcuQ<*e+"ncQ1Yk\)&
K5X`uJ-t>o[95!e]AXm^d+3^(*NA2%:#Eco@C-)(/-Y:?EgT<?4/80NVVBFa)tb;(M1'L7gB\
BI2,@2\j?W2GVmcS*W.Z28tcnNMB9\mD4kI@T41Inq63fog>ugTY=9WU`^mK%8kfRiNaPA8G
>Zl6M_5kc*@H4hJ:H31gr;VA2@_5[n'0AP]A6t-9Sr,^u-kk'T)AQDt-4;)h@gH0&f@+55;U%
b(W6srO8[#J+ZXS=I2Kl7#nhjm%kPI!b\IG-Q(,(q62!&c`M^@nE0YU0o1r-,Z/:fAF:baG(
u@WD^hX+MJUMjQM<u2rP44O*;$jm7,BUej>@']Ar$1c)0d<eXk<D?U%h]A/`@i)Cq6(r#U78(-
##^l?cC#7]Ami&Z)H_M#VRg'^Rk$Ep^A_p,,_k;NJJL.98^prh598AO5;pf+SG)a;AsG'C@EM
U_Pt]A7h+B1N3CIh*(J(enP'"GnrGe9gDQ;VDM6lfdl%%O6T.5W"_gTJ6+XYBh'2FGh9K(6Q4
'EC@(EFo&FGa6qdk(VsS,?k4.&%Q)6N'^JPXf\i2r.d`JXk8UOhA28nq5p7n_U=KG\ufRV+o
)1#"nJJ3Z5$L__XiY<,6MUJq;\.O8@Fr59b+YPj&8I5_<^@Hki&W$j5An@e!kJXfYYWsln`J
2:r?phg'GG`l4.mP_5D<g7.0#M.,2hsnGD]Anih5oA"XZG+)jBCL?aM`l\'oII8m>^FDdL,+G
J4Q/;Yd;E>iKZraHH_YHge+h#]AET5c=%,?6XI!*`-*"cs'^ScONiGC5%gWTp4H>t5W8[L-J+
Ya:%kimq]APp/!\8Q1Uq\aU&DoX!Q/frb^$/sE7rpjWqR!Ql8E`]A8H0c&E]A"PMnCj?5KigA(/
)39C3q%j3nLkX9)'kUB73;oo=gOnnd2HZ(q?3$4K,9#PFUKGU%pR(_K=mjZt/Qra$f*Yhb?V
4O$X&e^g)cGu)I>T1rae3GsRT8.V8%`_mo^?u(uB0m_mi'hbSj-jkoi`D#I^9.=sLjpVm7%n
;9=1JF8s]AW"\5GPnGHZ:[jUIH"'/HU/iD17WNPFOqBm-_Slj.=g^mR!QVEg75OeL5@GhCmeD
Sl+rQ?99/G^LDXn@S#Kmn8MY'uBL*I)0`5_"R,5BgpR=M5&aNOr'mM[f&NX#B!8sII_L>p_p
m#dmpXb7f"FL-k'5)9f<Og9V;N_P*7[eFGG#?fD')N@356(=5dGK[FjdTEM[(![f?Te7i;+=
E#,K`g=.Y%fRpVT&T2ZK4UNfo%p$oj@+PeVJUq\'h>Qqs(;I/.)&H;X+*kc@R9-\8,%%>jSH
Xdlte-XXCT5g33<iiU[OBZe6Cit`W*e:'8L9.oB^+A90jhhQ[30pD/t?B^,e&'sA(HZ/_>.[
;]AtR%5#+4;q/rf+ph"ZL=s&Pc?PpIJ75MDX^9mY[-UET@bpsM6*<aZ2UIsBsQRT/6U*"G@d>
7nF2I<&35!0Lcr^WC4dJ9*e6Dp[D,6u&?tp'4JkJ,2WN(uV,q:A"j,)a$\TQqkqB0/o>I@!"
n)kd#shc"4+j1]Aa%UE\?7Gi/dWJ_c4MtUa'Pofg7*Ob"^X,'d<`PQQTV5ITMZ$R^ZT7FM(a7
r:2gTK&.R*XKCRdLZqWB[RSY=u]AfWWJr-IDn*,nJa3ECkX.&L6/.*S9@7St,JnL9[n>VL8?X
3!QUE:/']AZ&T1.9YLDB@Kr65ms!-[8jZ87?(-'lW0`f@H_=-#shA`r$#DF'&F:jAkra^0=P@
Z)%gir6+"O==fg;JBfMkQ*np>?N%PH7<+"L/s#LDKZ*s0W).Z9(3,jBt]Ao044YkAttp;j&A]A
]A!!RZ_C@6#l<O!%3Y\R#R'?p=O>Qu$\"#-/"\oW[akgdF"L`%.R/n:c2Hk(kVj8Ji)&>df)i
iG*Y-HrbH]A1/)q!4KpHs69,5iHmP=rhjQ(@aG3VC<EktkO`=t",K@GB[gZ36H!QUP]Ah310);
3)B[YR'5B4F[`[_e/'Kq)%$QhY7f"[mEp<cJVB;4L-2%X!5-%Pb<lG^Dq^ij\\h^,>K.0Nl/
R*<US3;:5acQE.)CDeq0j'I1Cr_rZ#"YC\h0*n7,A53uU0sWBJLa"u`Qi#CUT6EXYJ/Oo-H6
nml%+d[OppUp=KeA;[YfhNnIgRRMjNdA*J'J8d)Sq`F*hP[aEDg#K?am03r2$;MX8T"hM>19
h0Vg27O7>?lj[=*Y8.oo$B"1ddcL7j!m9GWW9ZDS0-;p,m\1kma2nC9&\A]AaJ,sX,tb7.hp%
D*o2]ASAici:@bk]AgZK3N)BGg2]AqAlFhCnU,ReEEW?9?!:eCQr*]AuNI5)E_J(PUEA1WLR_E6!
G/eg3F^\#fs,f;#R:b4<E&^!LHgX`=q`Y$/:XW1chELf.p5Gkp\k)U>?'D72/,3kiYTiRMVR
#PH44hogbsUaN2tmuWuomlj".`LZYW.VIQ_[3,mmiMr%52oL#u`&D7RaiqX$\bA>Lmm]A6\d#
7cj93`4_F]AAXm^;OLhEkfPtTAP!!@u0Dh2NJ=b#<9d'S&J/%>1a'JU)BV.7"ooukbCQ8Sdh:
^H/`FQJmZ#.b:9JeHsX>>4'fRlBQ\11>j`BNaHnOQmh:OiZ3>m3Dr#.3TSsL?i>sqU*(p-Cf
X*Yn0n@@,:>oU%bGdG2B>_?3DQph!0B,31$@`7)McBa9(?,4t%!m@j-Yn)k[rhUBR7PaG1R\
6GbU.ajdcZ@I#/X:!iFD.,Wako%'_J94;oY<O22bZ]A[5.@c4fXR-%""dS%$KrL;@3%,qfft-
i6C88E"+TM;a:7f&?ugDNh[!=4M\ja8!ft51II:rh=;?q6t0n+d=uY'8Jc9ik7dUJI=)eUAf
0f]A);XH,d]Ac=p,qEabp2X9?2,.X&8*=1s2AIlME4#bohN=r20:!>us)unecl9l\AH5jS2:Kf
kjml2=*.M'''p`$V4"C8_/0ma<0`^K+$6K'r1?:P-E/BEO@7tk@3htqUKb)<cbPpEP.-f<B?
5HX:nu(Po@[bAh>ds"AFju^]AW56h&4Z>(o$-HpK2[8:u/E^9M@7ce'Vf0"C.&K(r)N-'JFR_
&;YKkueg[Of7PoUbd]ArHsLrktEO_iZ[Z;68',71S1<0Xpu_itb]AT=ECc[-d7u7I3eP/^%_sB
#F`iT!6fmCV!Yjn:e\1h5nN@]Ani$fM.Nl%q8UdO;3ZYs?GZI%q_p"<:0J`Tu3`90VV<32Hl9
(!fUI[#-aZ9E#9nC/B[ZJ3odTaR%5k)l?an^\!-i%W[gU!W>bh4<q;%NVTGAa^K#q+EI8I6[
"+b&Rc?[<JULVL@Mc:LLS:3cX?]AFjr9.fK"a:2YijQlDEGAG0jh'GK[2fMEfS-Zh^o<:.'Y^
4u1@Y8UsQ%/hO946+EVD7H.5E).]A(%P-#A]A$>sNc%M/:O%lK(EW-63pm@rSNe]AgrZNgXE/.*
-lVIojX8$qmtJsKYQE`hM9r0-,g9c0DM-alV+?a-sQ")6cIV?FM\c8k1&WNU28&8I,2gd#:I
Gs%/*Ji#?<f<K5VC<rCL?OCl=WW&(o?Q;Gc^)i\Fhrd>6)C'qfRR;QXm`6,dc3anuB*mOb?V
3aecb8FH(SmMTE:a?/c'PG^#a17K3W^sN8@\]AJgU!7;]AF//%e3!Xo3MT,HIbXV96ni:FD(/A
]An4,o#j`AtjoGhg=%DD3P3MT`rM77k_/Cd\ZTD&,`#MTJ\Aglj8ErJ!fO'H/=j=A&9^kB"^r
nH?(4YAs@U$X/1er+5RM06G.lZbAdgnWt1TBLLk,c9As,6YD,B6llXU=6FEh4j!["_4Lq/>B
]AgkK_u%k,q%XZF:ehW,49[pH]AYJfL-H_XbTtN*!6t@dHXrYc)\bIXdY/24N>/U@Q#iAn,=EI
*&Ea:4:h553!lVm)sK%%/;U>Geq:$2hFM.-`=5^42;uh5`#8,Yet7W5W.TC\=3rg?)C!<C+3
JY-HdgSTPXF1KBe]A5%_VaBN2G6mU4*KUV%V/c;\iL$kaMs-Pi[QYcS^3_F`&&Zu[9?#[]A^O*
ARrUKN#&m$lJCMBeX*tln5Q561WOsXb<AY29NI3<bP$7&LMDDGHPToIYQ9+DHNm7$d!(/]AG6
N4mc?!:HqXLR&Pq;bp:cA@a/Xf<\seW;'q7"U#lE"_[Oi?Z^XBkj&b"*QP,".<GRAZpjeVBD
buVGh\Xs43:mT0n"E5ahkg7gAAZAq]Ap0]A37;rA'TH$)/U\L`anjP<%d,+s,kD#d-/+3I8?(A
N"?\XpQ57L7A&\B9Qq#n5@pBboM5tL'ehmkr]A_S9&i-!'k(!0@q1")1'UC;h6PEl/?@Cd^XW
V+"="rhQG4Q6-4.*!fp76eC4=.LK@oF'1pBr$@<hs_\i&f@>`tusk3aU#DQX:9W]A[U"I_-q2
E)k0as_Q/1d"f7ZI5FKlrUV'0hS2L457VP^%QX-BAI?nhM3I)0;pff;gs)1(C.!5KXiXVrS7
A]AIC99s+L#KMU@F!JSr\_?PmKDJmgo7o4JqFBTY3-&IAE^?VlQWqdm&iKsE"B-u-Zl)<bh#6
['+&:7%Tp*o,+&Q;ZNooXqMs*qbJ$D7!cYQ?K_2Hf3cXn,?3q[eO_i/bRd#%'s#jj!m\f1"c
"j-(NJW3F"=*eK^fsHh5b+lIDF:V)'c'o*5^_hN(%=dbRZ"#*a?VJJ/_Q'!WZC#gj?r)6)*X
gA6"V2CS5u0TjV.oY*30:1pYsde_1lQ3oG@VfjItge4a-,1>s5<Sf)_kElA3<c%B$E,NHLE:
6;eBe,h/l6J:Uca\!.udjfW7lAVQ8d'bbqm-4c6)&2SYa;Ccb7sCcCtD[]Ak!#%fjBAV=#72S
deX"[L*qpob;.[pC;j-Y+ID.h!)t-HWQepNfBD0P"BJD)+9S!e5gGRQea$i)$+`<(qYZO94$
s=[!btYA+')O,HrB(N7>G$on1"1WHX_lXD@8;ahbla;0),Ja>SH,LP!bT9^8^6P[NO(C?)@+
UCWs^_XM"qPJan><#D]A7C9>O6ootED=HK>iHk)ej,+Fc[p1L#k#sLV?3(J.$(-Uk965VaQG%
00GR"Yo'7X#q'0f%4BBnC^p#I4op=I=nY#HRuuMZII^CThGVEHRE,P1;>@Ot?=V?mGcPXP`h
L2+3_+&k>9c['f%e>)V[rZK2F6e@m=3OkuimJ>,S8drFYdd=,]AGX?*HM>+X[@*@JU#'5q'8M
PhGm)P-)upSEd2WstFhRQB]ADoSC-6RL<iYe#*SYC-i01fA+q?Pkapp%.rV\@e!>h>1*WkDZg
KrBHi:A_UP.jG&B@km$q-RS)b4T90%hkP#q^"pg)>J8"XJ4<l:K:]AG.ka8N+%dnH\L*?$gTJ
D-YZM2[EkF8j%*%U&M+t;j^]AT`[Bi#@q_!=PKgm83%9H;)ej]ANh0'Y9%6Vr*L5&@HC>APA]AZ
<]A"QTX'\`FDn[TEO;*KYU4^[X*iaH>LZk:C(gmI>XMpf>$P4.F&2qat\uT&&k#rW"P;sRj/2
%N+A'(#OH``--"G`,#u:cgN@5Y944]AV\h`RE^ob'oTe3qI:9DE]ABg?tDS9s@$+,7fC<TB\Vl
[<0rf=m`^Q7Y"GZ8aQWo='I<FCgRa"tED%]A#Qu$[!]AC+T`(7:Fm^\pBdX6$%'/`37'PLo<qj
S(ZO0tT%l4'b.p'e8*W+K-YClfVn3UK1_XU$jAh=me.nU*M!Mmp`pALjN1Z$r)05u>\<]AKF]A
LSfGMCGO3SC%Ydq($jtV^AcuW+8,14KL.CS8QX\;I"&d(28Dr3G*&V%QQr$-m7qPBohoFb^%
O#!oCe#rR&'qIg9tc6MHe3*NT9F7!k&:)4HJu"gt2Hn6Ms(bQ`GCLV<H\RHbU\PlRo3^Qee9
SPY9ChA5"gSZ!h1tMl-N:mp97I#p%GUpq/(#Y6Mi5DVGgrgeMFI;g?!UgrK`e"*4u'T):-:H
fgen$X$H:bA>MkO1B;i;friJ\QkRpas,(k1@^roY!?+mLb)lu_."IjXB*sCa/9ZL;&kD_+FL
K3C=>Kj/I(IV@]A7Ue!]A:79)kTJ>7\bHf5-j!0#0eD>^"!h)*TbWU*rEsZd,s1ZVtXqSoF"8#
`+AZ=D8d3VgY)3Oofgt0-dA'C.Yn'3cE0p**b*,RS(%9q1DeJLh*7V9I1,?/.V:6URn1V8<=
`dCBnTdGB%fD[jMo_!joTLaZW)Uk5aM0-c%J/-Zj"8I4L30iFCC,BXkRb;-SnuLD=7tH"QiA
Q2oT%p&2heJ.W9%e6uS>L=iP*%[g]AM*ja;1-?R,9?J:4m3:-D6\@\JJkTsu-Q>%BmojAm\p8
TGj,aYEOK"Y:Ar+0EI;c1cqR6oPj08gHX<\'sc9BqfnK%)uC+^DrNJ_]AG'#LFX7T)tH#5pWF
JXjQ4cudL+A4jE75d/;c+Id79'U&hqoaA-.U(9Ni,uBF8-fj%T))]Ac*"m,,D(DSC38cm@;&%
NBLKVR&='VN,?Hn5"M0TfE:<-jW3W?#*8c5\%SeZgOjKS3iEP+5EOD5Q`e/N(iT4mC'[ghh3
EP!Ku",3G+s6K.5Fbsei,M&<r2<p&^Q^8emOch"Yjr%*a0h7qjsOH*=BjIHj*cK*$`"O;s%f
,0TTNFk8cUY;[!%#6q[e>*rM(>*]AQpq\R!ceJAj(TZKGDC'u%$I?*M\`V-&7o6Fs]Ap*,$iF[
P3PZDE3`AO37Iol^,LEk+V#+5_@=RjmFDebj0)B;?E#AI-VQfT-dY.`&?G>Zik#9<F.nNaY/
_J]Ae"-gZI;tDgUKQDYN64n!=G@Ub%r[lZa.HK/d[\O!m".(^-0a#QYCJl%hC`HR(kKD8E<);
_]A`O!H1l.$[;&JmC3NVRai`KLf*?Q6-Ce>lI/[-#!frW,1QBQ.:Z^X)fbh(kQUGk%Q'>3?d*
Jm7gXWa-,JRu6Rcn2_#^&S(72k5[k@oOXQm=fS:'M!nq2!k*)7$YRYZ7E7='@JQ\P=p!\ir3
H$C/]AuC2muO0;;T9H>Yg;PN#alFtQ##$MI=pK(D0$#H0?_4c==qe9T+-ndR`C6*at.+uqRa6
$o&`hfT3uRrSUU7pYheN$$>BBUf4e>tS&.6"nl+fJo1u=$5M'Gb?6sm8^a-%V5)!rir`lDS^
RarI>PsUt#qe:rc8)YjIukp&1cH<*d[td:_X&ED+u),lDYXB=[0,4SVLJ+cMjcMEc=2H-Gd>
/I\\*"HVa2f_]Ah8Qe91B]AU7NOFCFIj$A6[p:06%Xj398d>(5B/l$.0N#i;?9CK$0UKnU_X+*
LH4V6VTRk"[?'&Cd+.B['%n2(fi_?+dl=Z/]A:eW(qUYeZf%=2!<s[T"g&(:lUdTC-*r/Rj"]A
>%\mqr*!Q\.U-O#.(kVY(oD#&EFhk.t;Vb,DO0,N"?R6Y;f4$=!:/I(o&g_"J*t-`A9G]AMo[
aOlh'#l<an$lh[Xl9#=VS&>WLq/XEd=Q5r9AI4nb<q3`lfOl$I-':8cY7V/lR5!!U"@?=UNR
-7jk!t<^dlSQ9n77\C\"LG+JfQbe"s./(BH8^JQS=NJ1%sL0Q[B3I=N-&33sa=[BSX12"l4F
V3pT4iH#<pfJ7sYLoWXs^4q#)ZOWB"P:MJ0V-M=TBoLj7@WWP.mnmjo;Sb11K%C%!19/@HA'
K/CR+Sgi%C0_j9_CPUNsIrMmu(N>)#(n!/PoI5OU1@;\!YjtRn/9dUod^\$=msncEhINWjBP
f91nfoZ[+^)NVjClcs^u1YAX'P$EYWM4p>Z`F1ZL``s-*MOs'E8P$Fb)-bO3f*P#.'W;AT5Q
R?K$d^EPd\$ZQ"07]A8)#\0O`[8X;C]AH>+H':a8<]ACS(CcN`L4q:cXZ(Ot=s+7n@3XB\ZUl(K
5u=-g8l,itti+&1J\g7'RR\^6.qam[i<#nHVJ2`;5ALYeB)5oO6B5J7jPE'#+n\#rV[4O334
J^K.*VE***<@>=nAJ'c]A]A2$hs"4tX\G`n[8*f6u5%#ID?Lg&G4a7Z5*VIP7QQ61jZHSJSUqL
XU$d(b5.K0p5E@I>:m"l/r%SGQ_lrm;te&h/mb%!Y5[7k#"/>NI^;"f7F90iGmHaefI3glj&
W#QkfE2LbT01LWb:2=U2&)=n!?$i0j8#`hsV$R40@mdNOUG`OXUL=F&Q@MoSR'aOg]AoGL"!S
BifZ]AL\6HprgG+mVTR8Zj`L5n2D3W^'_+A0RR<A)O\ZG&b`U[4.`hY6AEPkGR_itLqX[U'Ba
$h_cm,rH3Vi9hWlfJl#q2\_6.Hdn]A`e\EKS`/b*MXJ`]AkbaiYiLNG%.?jWT8Na9mVs`'_q(D
pB%r7roUe7/JrRX:u>n4PubM"o\B"A+#p\OLT^_danQ^gNrUBI;.Es_eM8L`%`nU7<*XTWEr
%bCSaH1=ZmBP<+4mdipjr3q8f[m\CeK;@)bCJ04d>.sBQ^T3ZHSRa2^@,?WBCQnPPC4Hm*eN
*l?)]A+?EoP=I>),Nh(<;1\WR8nm`dbhWu`?O-an@Va'%5Kj;rUPRY7H\!u`s@X-g(>oA/h_/
t$[Z7`3)!iC*8c_lIcmd,C0D'53T[AM[($D+.T55ENO#?6KlTDAR,`+KG0NJSNotro'E)Zi$
@PWqaqsi5:]AO\8+sILP'C4hMk)OI;jUOL+ns:=_]ArC:t!K62MKt^;c6Gi`7$^G"LEQ(Et!R)
\tdi]A5aQ=(,sTj%:BNTTA'EoP%\faSeI0D5VB!%\$_+cNXuY$l$IJBK,peQfBp25RJe<Ip86
O]A*+U><l)?]AdqFRIj*.tccr4m,XIfTIoo8Z_*uh2!un8\_jL4"J[j?7q@C'eA[!OtMY%F+#D
ml@YgK!$HD@.LjWiQ3I2aSpUA"KYM[@4@t@3!`D`179pR?b/b"9;C!G.(i@0Y`sE`TZ_aWL_
7"?I2rOetUur^jAS\CBV^0d;)/GSP<!&*F!g[&G;)68o3:U*"SF6r*aPobh_c8D2G#lb`;+p
82m4%kTe#c9JPKALq0[9Lj!o,OO5HSFD+I]A*2WYPXY28\GcV[gs&G@K1X-BNH^,CKi1V4VOm
Jd4@'cu$L5/2$:/?YM*SR2:irIRAN<X9Vt@bX#pK%?F`'5I.%F1\_7u;3!IXoh\al5tQ+P"q
"-Gb+C+>cOY>5r'I`7JUEo%Qn)7_4_E2P9?56@+>3$2\.9@uS4SIYqrAGXU4p3M+Y-q\i#qL
,mc\h=?th7^=a%VB*]AlJtD3oTZ"17^ge^769MW&;hi$Tp8hEiS/K7*VgIs%CPgC*15.?[Gl%
0m8`?Vh@%V&q41@-?uR4T"R_Dt%Cun;^)pmeL+?2LCW"9HINsPNF')pA8g]AHH(,rU_":9[eQ
!`:+PY>0J9ouYf[:26_?E1dr2gB!M/J8n$PN3AG!,eH;e@WFMS]AP:`GHGocIn]A,)"]A]A_*^E^
++/W-d9=>H'rO;AF-!cE7^&0r!N-bGqtK0M,Y3Li$q)FE_G^7XP4DrgS1`1_>T75A!W-D<Lq
/H=;0(7E[F$M^,LdMC<7iI-9,_[4QlOdir,0OZ4;f$GfF;#AF'5o3b).Q8NM?YW0qsIa$iI*
*,!'*TT=68W(RM)QNQLJ0VGB`AMPc-#qBS?n2&[L7[&]A/[flb\MrOTYOX=*=j:,\"LW+Rl<'
"+iT$uWUc9PIL@Sp86S'Gg7aC"s$5HrYB:Z:?WjW<0sL8r[jEUM'5nF\#rs/g9AEeG?niKEL
Bnmg?X^/Bh&dGe771elIE8UGCO(#]Ac7"nuVsFO:\OlLiWNn##Oo]AU&WZsG6^"uIJ__0&<u%P
U*..%FQrRsM+U9)#O)74+B>7n.S)3ZOC"`:h@ku'dNQ!EU]Agj`!!2YB\,>ZbpZB_i\M'@2s/
]AMWfk^'&qL%usfsr&Z[+$O,!u=:$]A<n2^<WDQ<.U<-5++.h0EcgEX]A^_0re^0X'7?9$>)r,0
Y>/\;%J$1r]ASLS84o1[P`HLi*-nKQj]A2Cjni/R]AiJiWUh?PJsX+]A%e,_(Y!X!GJ@sC%"#@<P
4PCt'IVIF,GK;7nHK;ur(V<uHE3.Yi'uIL^<O*A`AJZ/IW@]A$km9;A+sLL#Gq@ZipE54Z^`0
W5G9IB+C$^Wqn$-*]Ao/`E1QC+N\G+rGMH7V=@r@g2q[_Vq7cHpW#43s'sG0,PWn4@5,4RT[.
W-u]AoiEes/CGuW#'Y=JC0IN-fG1cfV5Vj_W'N_@W/T9c'UYs^Ip69t!833n+Y*m/t6=GAeS[
a<s`;^X;^TFLfZ(\*SGO/(=PISDsi\^K<]A"9on=Ba#K?j?;,d[I.<-c0_bJH83tAgCTq'TJ3
+]Am#-tHK(XqRm)9aot-`<3?mDQ`KC9]Am:M9*nM3e&]Aa44gO8%3RG!5YE(\!5n6;Us(;>rSMm
T)(=M1*ra6XpI^%m4.2K`,<;LoOo,d_a/&f?f&&LVSHgk(hU'm$S%f*d$[eUpf9`bZ91"*;1
nfO[_03VTJaUL`I#kk4G]AtjtYgfO,ADq>.uP/]AS/iM?>KrtI(Crp>OU??CfMBcTKi\?aY.N]A
*rRg9C^6X/r[3QD/U!mIZ&3a0T2j<H5TDVEeQH4==js:>S2Jn+:o@m<e'ASBX\"DF@,P?HQL
B\'QWqgm[XPHs8d@ZW/8dj*Q*Q<Pr]At:'OF)FsmSn1p%:)oas5K&m6bYB;1-&Xo`O"7AcW>l
.4>h<@Gq@j9O?k>9(U)RrX?#NM\]AAC%cLL49Mggmu'hb2Wpdk`51@@.[N'mGfR"ipY)DX6$=
^\@NafmnZ_WYf]AaA0IY@LYlc8UKT.]A4@&Z"j)g,;:gsi'D*QW7kRG/2a9CE=!/Io-I$i('HF
6apk$XOb`pO]AGnrU;g8=Q.$2B[(9JaJ2^OZ`[/*C3ieDMW%ZWK52bFm-^<F;7AS9N[?HU:>s
2n6L!&V.UW3_R[8C2WUME*pqn^T?08$9LB95<"_JNijRc,:9dI*./"\o0H^b6XIsTB>3018h
1K"3+W461)sqJ<i\iHZtsqo'=An#:_T<Y+5^dS*J>2*&UD$pN[o*BAUdrgo*59B4($/5[&/#
Bq4<1"eKhtJrfb">g%7>81Ch(9iE6s,^[(n0Vl*bV(+L`&gAXHB*d9%5>W!:?*,50^;rb\^h
!ss0'j6uBC2h''eRo@Bka=`V";H9V7_K2.OS,h[QTW\$f452g8'*h7nl+%YF%EsT>a"51c"2
Ceoc0+3C.i'fF,7"b.jT7`lGJ!R`:O?A[/E>M5[j&r5s)R-6`-VcQnO!p\r(Qd)Gs*2Vt'=V
5m#W2<tWlkTdU\>;t?[!:Lnq=A+>XO>^Yl@+lUM>'*Ak-*lCW+?ESbd5CKDeXU-6A_ZtLqPG
@l%[?qE"o3U.0i*WC2n.-)Y%'uV@i)!LnR6pEW@ICm<Y6b?gS)*_mBN(+Q^2E&R_+Pu,#AWU
CKkMP6b*rcUi#a]A2MR"P)+ljGGB/MRZV[I`4<\nG`k]A[BC>j.:C"o.m@AqH.eqP7[GT/NPUY
7,%0Rle>nlf,MoT2+85fiiBFo[f6ek/A'$B`/`WKBJ_^2*Wf-H8b\@4XD.19^@`MXk#:->]AG
%sfM?!F0M$5MlkF,lkk9ou?U'8J-<q2%O`l%7JT&<tb9WONW&`5R*`ZjD@&$l5p#E\f_K,)<
k0G,$"@9-f[.t#&&>ocs'BM?lru'EiSJ#h,H!$"]A+bAej.YCM;j1ro\flclm4S4q:o!djuBP
KJF&!YdcjD<pQU2C<rG,ettP?A0>d2LdS%#m0K/,"*TC!,UHAi>:k.TnBt-$IK^hc@X.hH,\
IB!pC7':`*_+d=VoBajlEVM*C&U@\D[PHh%<1+]Ap5(q#2)E-uT*?6prPk\Z_iRL'`X]ALC30k
s0C5[m'PC2o8:#+'^rIcI,`uH6[cOIk'WlYqSC#7HUZrS+AO+q4Tc6dA]AZIRm&N'G"#.2=rp
ubIgMt="IFpO5-bV(9'uP&_.rlHrIDqe^Yl!=">l4hS`q[p1]A`keH=Nt=:u1-O*KA[TQ_;-O
$bs,:K"Rt,^qi7G_O0%nAnuc.GA)hI\2MTlZa!'L(udN<qR'ujipEWZU&sD4Ve&#T;#/WtW@
(K,Pjet?m2O.!TS&Ml!R?(*J@io/_rWa*>geUIiss0FR4!U3@I,^h2/kt#g&>1$![KGp]AC8^
[o$uTd7E"n4gcoDu.;Y>>JYcqI6X+Ch/jNl/Bg.$chBhI,Hi1_0#0Z!PRtWF#=\i"J+O6'g9
AkWeb]AdWd_3B+LS&Ntg4/Y!omT#$snqt##Sn)?^co3!9Aq=_^B"4M)rkD\Zm<T@4f#cY26^7
44)u&8[9)X"Oe?+rKZC'441g;A#o6C+\l@VuNk_XX]AOd@V4dfJ[<iU#*(SjuuBYTGSQ5-Fbi
^L2a.nia=3o,X.@m4*-LJ"siSaHdKpkkA:@R@\aHIm*WO%I8(GEl?,J@W+8$?1oL)&"3NF[S
cFfhU&VW5HI6H>jM/P:<^VGJh@[&Fqc#"(+>-lK#>o0+qf8_?C4=;!mh?m%TrhI<;Ut).NkV
sO&<^Go0%HWPqm[$^S"#1*97n6>VnX.eOf*:]An-C3a>+Yn*I#HG^NkkpIR*EX9%9[.i$Rnj\
Sk*u(Nc6Z#L=OqMAKrk$H=[3r!*uhaRQ!sn$(qg)Y(!filf&,CW<8a>;_l:9&HBG6b^3[pZf
0C09"sJEl.;ke*h_MM9B`.5Q-'!F7jR?<ss1_>>,8G8+RA=$32oZM8#/@,'/?QN!(.8hX(.!
-F"NE7eL=Q<G.5%1f=sm(PY=`Ze;)VM*&'";TLU8>(P&qF<B)-LW)Erm,o_]AO(s^cLB'i7aR
)f9.<g>Mf4f2mqJk8@=eQ6ccHAVQoF;CFYn`@Qg.#0&4Z3/Cm?IX>;X)q8FYPWd.E8>KP+]A;
GHdctAc:_If"4X/cr977h=sQ/Rm@#u8Su7phZP^nHTF)YP95,k>"Mikg&V5S"hr^%%);^O2G
/&E+H25*_<d.IcPbt.ap-rL;JJH,;Jh814V*[b&.8gj69`?k&f;rLu!)4Y-Jk/;sdOkeoaB_
Jsk+cTX)`7`H)#3R'IRN>P&'t)U@bunUXJ@h$2)Hf_Z+"H&kL(D=UGEPs<IeRc)AP+N!Ns7P
.459a'G\%*A!H4k(L9q8I0KK"(&-]A$-1W*/<oE+Loe^HGb4("tjWB"!CIkAIQ=9B`r!`hQph
`GEPpet@:&@34qJ)53jl@T2KJ^N`%=9*hNqFASpXOq2Z.H^[?!]ATq;9,C[<W3QtgI@&P0"0K
H;rh@h(dgt^l3C`I-3-io'4lcPF75HN)AYlCE_[$E!'`"%=&RHBG-tVXFmVDr`Ee/YAUeO8(
7)J)$Io*/aN/s7IP)_pFq<Smb%tI**`Gu\WDN]A]A;j5g(s%Tl+jG=Zr+dZdVVu+Ifc!.jW+5R
>RGC0)ub'`cC?@"k4f0O>6Y]Aa!Y<'XA2%jlA[BKuN6T)0Li]AWU<.W4ssD85=!T%2Rme*r.HI
]ADqSPTkGPmQFm%/e9uW0"+,/Xm'9aU/cL6Bq#Bna&Bh[jn[A)n"*3PLbJ2)+B`EWNIT!R%AA
;P"qVW+&b*V/Ep!N%r!o@1:6QHS%cE;W4ODp=b?n2]A/9,`Z3C0%gZ$fh'&aC^/2pCEdYMV`g
B2rD%\UBTaB&=3ieS`3#I[=Y$5q$q42/:6mI15^'g@\R?TH"sNX6%d7OX,W@3@/4Ju^n8id+
_gq_Ct5=Xq4RDg0`44d?tRG$.i=*>BI8L4s'AI?[*5t?UTZftaY!Y-gA[WAE)8F^8gb8oRl%
?SL&odBSNf%E'UTXt[gZC26!b2Id_<G-Df7c="0,\@N6XT"YJBV`nb'lr!HEZds&).%1.TQ>
jN7;41ua3XF1ef.p+^W@<4m=ur`b:WFC<IWZj2TK!oB_fi>Xtm7cC05-U)8"p2YnaK1]A+b_(
>U3GY%FAaD,XqFK5<k?BqE4;**.!ZB]AE#6[t4SS6k`#UKcMHDu$1`UlfOhD625q+4n:L;IH\
VZ1L+17!s=N15ED92Gar]A[&7-dg3d!ABso'a6a;Hs"ZEeEK#MMTY7RBfm+l0Xd*q^BdWr3lb
5sQ_IsQnG(%uu@>&REUD[Pa9G8r8AGRj(iNK'+=mohWAG=*1uFg]Al3KLC3hOka:ro6,L;3j&
L7Wsf.^lRn!9:/8rj9*i5bL2g)-S35^K0$%FMe;WZjG7q)lYEp1p2=h_>bbS4^dU?PWe+"]Aq
E0N2o(S51uj)lE6,'`0%)_DjgF+AVKe0VDF**m'LFubUGDLlFDh3/)n6-BWV5*6@s',LeXl8
G,FkB&[%AHX.G7&!>/EdI#POOG/N%:4de=ei]A),:qQ:^)`LU_lX)tqk1dm@'6Uj%+mp.GOVe
e5P_&jlZ["9QIRTIW`^A1YU7"5,Pnf:qTrGb\a3Uj7C@@I;n6[5g1ub8D%h0@;-hm]Ai5'ZZ-
h?,F^V6o_5h\*2rOL.4_pTSrl*7G&\6?.)aYb_C+pKW&m<9J0&i9hUn+Oh64RnC<pirJ(d&_
\_f:<F[&D6dQ2=3X!m)oE[U\'/6;;^</CEjjJ@"khsM$Zl\]AC[5(F"NpEU:20?C[^<R`@D`<
MJ4OsFY2E]A.M'B':<b`q$WK;!Zp"(,WUXQE1IU;_DKk``fa5C4U3XtUP9)MB?M7P/KR')T1^
(LV5`(>aHnNMDlVU.:XkS>3=Kn]Ah",rZD]AYX\*9OF?T"]A?IA!L5PU6$)k,GnWW[Bs:]A#9km+
g-sS5I0.NL214J)Y+3i9H:=P^pT8UpA"D]AHaq8@UqQgN2?a=cVHJQ[=hn"QTPrAfK%rkm+_O
4WU`Liu;`@&4JNGaaU]ASDJmLbH!T`pk"lQf:,94UumGhi`k&,L"tl]A(?"fDl4-8f8/rjE8p;
b_#dp9?:NL:S[,PED"<T=W2Zf4S3kqaac2+PE^nc96oYl]A,(d[j=UZftLpStLl"5e9NZ^]Aj_
VmJMcZjAoHE)W)5H[huV0:/SZ7\Fft^ZsFW+3Ph\2"rWgcs?X`JWRT#g5hA9<6:0NE@+:$,M
(-+!co_=@89fqkTZ5%U]A!N(cmDB<k4b`SHrEl88WJU2o6F*k=^jGAWXdMO?s=AeoC*fX+XbL
lpTU06cUktI]A[eBm@Pt@2'2tp+9i"JI8J#)jl.PTEp#7`cmHS6i:<-GH#&EM]ADq[=Yo;enLo
g"2o\]AVWDL_*36fqAUAa*W/n3n;a[%eIr?!Iac^al\)!jn1q>ZsRt:7"nL<I,a^]A">Rr25bb
I$"I,L;s)=,Tq^ui>e:W]AAh649hb7RG,P99Qs'$P@f2Io6N'3>>?rVdRoLq,8SNBdDXI1#dc
]AGC7nG5^<X5Q3%MqB,=`'?+bThLBtlTMN&f(91QqDLYiG>`X?im%o.[RrdL"I)LWVG2a7",L
qN8%1mIKCJU#"^usm3cPB`4indctqWpmRiK'5m>jVIU8L6PdB7FYK-jKEZo]A>NTikaZi=4@2
bST6,QQiRb?r0^F!.<2f4`>BAr4&sRVG0+`2C26"g.op+%*#IM]A'nai%IZ6]A=Z^9qs'@)4?#
C%Ad,OlqD7sWH5ocYKqIAkds.%Yh>5A^&M@\05T,U0#8iq.@WC[A^4FIKBd/HKs:W(#l^)Fo
Uod!P6(?f#==iq]AFQqlsDIAQoUY23K25p9G^N"?rf^#1ZT1="-HalQ!s@2YD-%+'kG>3L'3s
l3u8"l,o"Ng:Jn6he`HJNb:8s$@dN'`p<6Imto*+$,498arNmtnJcm8X3:R6,8p?R+IWV9.]A
7!OkNXcWHQ>'[GZGoE>.cq'5Q00KTg,-n7@rcP`gpH1SDcBq@&c>KMYcrXgF6sii;BP+i(27
24j%^'ZSChF:#^<QDsiN8!rrB<hS-%F^V'@<R,;KK>Q-WFq.;#q4oHM=AL(r!n2#*n`YKH;@
$u8SaEN-j?FM2KI[LbqkGD=Y[?>q*i_8O_c_VXS'r6Co`)0%]AA"tBJ@$e[%G6)rpl#f@WU1_
U'<,Z/Uc)U>K6Eg3Bn"Tk+(C`6IWIj9VaEtN`^OgAm0]AVH<'_rE`D?GlpkmXm:oi1rZ;K)p7
b*'t34[J,j*:jB%'enT^bd).[Xp[G@!#C@i9QA3[RhR#[MtuSAfOELB0_40:ZetkEB9O9^o4
Y@=[@CBi>S8LG]Au`gj,R1$^.cF1DClkl701)ia:Ma28(H]AW9aJp<#DbKHui2YD2be(ce=;0c
/Qi.Coc"j.+*[/$EVob*t'6HQsJF[pI_%^3`OQOp'X4cH6JmJf#?[.u-bM?XA+!^#*rS9lI7
hcM^qUK;k+p7cM\CMH4d=kcl"SBOXA="\B8qYIY<<V87<849&LMdLHc^k(YcurdGjoeL+n5r
.W'g5*[#JE20csrdu:,L8NU>@?@TN<&eHKT/pIV#i4pu4sVTfGO>GAa_.^87WeruEShADM=M
1dHJ]AWQ)hEn,t;tOf1o01A"_H+k8h5^dLsOT%4T!T2PN]A@fbl"XE[on*S4!tbc/mB%VCuacR
1\t#T#t%VJ@sDhYhWLS_Yakj)MF/e^m_dKI+hdmcH;GO]AaN(ldJL;MZ"')+<YF6-_/EIkJbD
+Lp6Q"LA5!,U7n/PW&pe(EqT`6be7>WinXYkQhb!2YLC?7h%hku'K$)NhIKt,U/WD\p+^;26
O66AicJtJ5hM-WhWXpi-6-Mh/*JlFmh?qH)ot2c.Mr$YRPAW'XldQW242QQOX!0Ek30gAfY,
Rb/Tj%E]ABc+T`d/;F]A/o0F1R(?*h\pq_L!.++;]AOmpY"Co:]A^SA31H#q6^=]A#-j3=-%59;!h
@5J[qN#7HHl\Ca?Bm]Ame[Meg%p7.2ZWm?YdN1)lf+,h"!H6;Q\Y\1hf`AMW)UF0<Imld%ELe
c_<SJ7XqcM5iKg<3F!V^A!JG+t0U,(:edP=-Ip+TH%T.]A*q%c`Y'-L=pbg[cJbqC<O_+G'/M
/m00]A48O'_tR;]A01%^3;.N>TIo;ZQWCEDJY8='6dPq:Y'2k`)CrGo%-&JD`l\a>IZ3)]A<'J8
"1_-6c`q\NA`*br+/NPEH?8_CJ1a0+,MFE(M%9NVohVJCY($TQi9"Mi'l%FMV'I&9j-O9\]AX
NaL*JB&PbWcP__d#%kPU;]A7)`rq(M.)@^O^:a#3`UMa$'1<fDObI=he6UEWje@k`>ua&Ct9R
q#1UVr1Y`lRSB8kCF"gN`a&,U>XqW+XkDIW,j-ZAQ+J9A1lqJM>J3jhAt,sMlWtmcp5CDNN;
4h5]A%TW02]A7c5!Id82h=;Gfb82Q<l&;7p=KZ%A0B\u?Ndr:#E<"#m!tCIK%5+c>0k)bX9r0M
$#P[ntTA2*JcP%e*\VU'&\2!&u1Tb_C<3IDUX*]A>62!7RY>X]AK0h/QK8...Z4LRE4jJ+ACZR
9Q#H!*1N^K1eM_f9#5lg\uQE_lV^`\uZuBb!ecZ/q6BgpXf6/S#u@;ZKTJ]A9J=_\kl+,C/.7
?P-".g^jN0l(4e_*O,K7^(12n+sd4sqcMEo/^TP&HO(bQp$GmMcZ3[nPSLE*Gb[E3%]Afgc(o
eG0rXh6YKeL@8%EP'Q]A[cT%T[[<Bl(@eDX#c/+Jbg5tn`%\*.[8^KDrY[X.3S#AOS6uk(*Sn
6&lX`uZR?;(.YZIKJF$l`\C.f+ELgH\\N<4f$,,MZK.0fE?Dn^J0JD1gge0McqYNQ.Ph9lW(
$l)a]A"8J!g-N<[i0T"9ujD(skEmmHP5@99`$<T**b9acp*,D:H4?m6>5ISu>pYBTlWcTC5DE
a8_<%;@%B-@W>I+t#5k3Y$.#p8WE\(AOUufgs;k.^t))g38qMVI*0eK/`q-QJWV(909.NA(&
+(*JGXZl!kD]Ap?r:6K#%-8hD7EU4usG&fuWbLIOq55g2N`4BF8PYp\2:mD?!i3FsO1c=Zaq?
LIuqffFNeH,4;b<qt^bd?%2\lHfcWBqM66T]A_o\KnbgoKCLC^c8U(^56hjZ_+/=buH$D/Uf&
0p?aRoE:G3qP/GJp\Kn.KBjO7Z=qJVVWgMP&ms4Vj]ABc3e1<%rM%NV<-T&)Hu[*'Y.q>nRfW
^rH"5ec%M$XK$TP]ANKtuZ4!aYlS@ioeG9:FIQrF@qoC(=P2[[Rm,C2.#A&0"%_<i8V/-:W`h
+'I?0ku)P_XEQ0Tam'P"5+;*'io@F/ou`(&ZZm@9?3`.jO'?cbe=YZT6JJAcOiJ(3,e.3-S!
'YpSEj7j49T[dDPB<lAh82ZIs<l)HkL&[3K1Q44J$e0$.-SiW+&K4AM2l:'0LQqR/@mH>_!T
N[X#aa^40.rItouf`)r=:7qtrV`7ga+mNRSdZ+Y',Rg^_V!00++h@uT*-LB=RoQ_\eqEsu!(
YWmp>#N$q.[bJ1-Qbof2;?[njhqm=lt$M6;^'DJs#M+b>1Ra]Al]AGbc[=<52qB6`fbNXb+AW)
X6HGL%0O,gPig5hn%FJS9#9kqTK_Ku.Mr`P-\Pk4dO2&h^\b;cToW>7epOk)L\uQNDeTerHa
;;-=*Q3Ykg$[*T\*h1frMu6"m2O;p*nEH6.P65<_]ACRAXdY0]A]A!5@aF9Lr1qo$.H4Kr1Z#h!
=8:j&VRr[uD,]AMU<Led,nuUU1>=T5p_h$_D;/a;\K6-D3sN3h8fj8I"<C%6d8;Qbj$VjOX39
%M"g,%c1lg(H7U8bD!3YK&3e'S[PrJ2d[&-Lr\Nb?cUm33`r(R&s7KJ(J8M`fYu22A,A%R$%
T58T;gjr#-2+69>fl_"9=.(A1L$SVf"D0:7EC?/"dfK<S.>jDa1eD[V/C2\joF^nh!Y0CIGm
6K"p)]AKiu;9'^Tfb!RII3i'`QZ@oF)O\m%W%KJO'H-@gQ9@>&.m>B(ssh)jkImgY?N6+/4!F
7cS^&7=a$-PfSr?Q.K04_Y6JFV*hF9t'#P8&$3KUp3/,4u&n14:qVSVCTp+1/`'>,"s3YA:#
Sle8=H#;`?4M\65Lk38^*(QJ;@@i\nh=;dNlDP6bii_\O'<+kIP:oddo+GW_m?N(*"D^cX2s
!QjaAGWYUM!r29Y4]A\J%il*=,q>+`M'J*/"ZbBY=3E3MNW2;C86bZ8tF_I"EFr[Ain5\5)Cf
/k"k>ILeDZpb"d?6WTacg+'l'X*FP%eadfNi:e+75t/1YMX4>(,.pcrXsa%,MuLJDS';rJn\
+Di`Z=]A_F,"(C1@kq8[<ib0g[^U:/-iWG"6n+R85[ID%0k>7fS[GT&XCl&k[#`d;KcNWA7I.
m-G%d2%iN%u)=qRn,%1SX(:Fh:Irbam1biID/+"8'$5#Q'NkqDq'S3ijcgN\$,O!od=]A(R%R
Q3qLoLd`'@f<hs0%;*7Hd#c&I9NQLJ'1c$75O.[R_IP2C"T%.n0Up]AJ/;]A66JILV6X+[r4"2
$IcQfkDd_ln*pI%Y=htSN<((Ao$.,GiA8l<D_rU4mZ7$(@VD.G@\S;`N30qY$+4WaCrVkCUG
WDi%PA`;4^![I;p\BVK#D-!A+W^$UZtmF9Q$p!EV.1*q\Q%8,2&lfS$#toKDJ#O:mgEF",ZI
;+pjX;E5tP$779hPfPuJ<P*-GMe5f?De3*-a7<hs1P[(`S\XBpH*YDI:eQAQic@fcbl:]Aml_
mR>,r#-oO"PrQIoX>O7b;YL9Hj##8Kuo-V<GG.gEH^0\22*mGjP6P::n,FT/g6rYWj>*OZsA
l0V)@eQUG8Tu=cP`FUP,]AuJp9(XnAnL#IB#unU<2]AU\?ZoE@364ul@Q8-O8lkSUC]A,=IR9H6
N5PUG,^bb$p3HJ96TE5['$GDO<kDcIcZkU)\EP93ph`YnHjf2lO`"BEnfrA'5mXo6,<E9kGr
kSqn#2?+be?j,o8u@h5*UEHS%&(IRXtpk!6r,!B7I?!(<cbsHR?S+jeaZ/VUDA,VC%nWBBpt
M[GaradCBDn;7MmRN<aMXL+2*1=qU1FhqHO^`T8-p5ppusiT/F0r1Bok"o!6^$8^D"@cnc66
UW(BXAO/Yb%-Vh9]A]A&$DVS-#q`>ir5%<iVRH1_gB)#gWB?H7CQotahKd^\rF-N>C^a_Nlll,
<no"$4;?K4Gm!s1&[,@aaj1<p5$K/0cCs.,d!DNdf*Oq+=L4O^=kT^KBR^gHANr"8a<ek*Q9
?L-4E"MK.O?1&:(UgrqciL2T(.d]AH9rps$g3:e.I)E.a(fq1-b+.o`V(5le8?8R6totu-7aU
odsig$qqh-V4Or,8D!W#g.g3`F;^+2kZNU9o%0MUaTKP,%nV(=HETT'Kb`KqZ=Og%3VF7D:*
M13-A7^G4`+\ftTX"<t9e?M+3*I0m<hrQ-q_V)Eg_XI!rmbt8*?s7*LeJ")mQS#%&L;r1J-L
S:f63D1ZMBA`A=nZgYP7f2td@#3K/H'^8`*N?@i-/Ko.15hfKgq7aYjhSo%=q$0Z:t]A\.INb
b0@]A^8d.SK6Xg*N)-Y$e4&[81MHD3t)ak%IF_-AS.R.WqBSU>Ej%1'Ac0^7!HP0kDHK)l_0k
r<s44!um8,A]Af?P%o1=$LsW%-o1pk$[TpapBrk9&6PA;qNgJAdcrdu/Lp(1?B$?!1-U)XL"Y
'A=ZFKc2+TcL\J8+obLh#SR>SYV+l29[7(As&:c2>g@+@8h/A5UmC$-\D2\bZV&MS:">d)[%
@)3MRRglLg&1*AXDIW=sqp@qB>]AkK"\TVs;[DO0up.Oc72#pN]Ah0pFRQ%<VH40DekRpTERq$
<^92rTmE^S[&6/B5B;alO+k=cYe"&rO`C"im.+c,RsmEGdY)]Ai8BPne%u3A%$1%<hF6#IR3:
P%"&f--]AVk%H>[WF%7IL)b@hDedlCh]A@q&u0jS:Ouc1%LqD$;*Y+`f'I36ef[MY0AHLe"NJ/
jP@(WRC*]AYADaMThaVBWaut7X78M>n;buZ&0.Tk=6Q:gbc!,qW>7jgcpm2qJ_n4l]A+IUjbme
mn:;>li;2kkdN6Ck]AQ:XOW9'1%.ErR,u:K\RoB.&kW8Ni5N(A@sK31lL$oi'l2"a8W+n[&JP
Ah\d1u<GS2ur['?U?3Z)*B%:O75W'#q(B#9sj.B6_imJY#gQUu.Z-(W-r>*kN,83S&hCd*CG
>D>+gK0N9JHZX=K^0X*hiCKAJZ(E)5kYdeT&@r(N;n0d9@Bg6@6#fIN+\4q)GLcnUqnU-$mX
pVeE<U;1qr.1+(c3_A(jqmXXp5NSW=/#FLcKWDO]A_B;sC<mgHm-%/ca*/GDs"%867)+h5JDR
2;<03CAO"#n&Cl<"KJtl5*bUR)_9gq8*fMW"pJj%-mSGBnHs@_>/.-+*iP"q"!jg4D+;"ZfU
IodF.u-]ASh&KTje`:]A"2'lTY,FJ\S'XBX&CfZ5N\lmd@=&bY?AF-YqJKC"Y\q^JlKJX/$9dA
Qe8/B\2JY3^&96gb,cD``A&(+pY"5\*JG31\.J&haZ`uR=1!+Bppk)q8RpkK^iZcG#%Q4V?O
^>ON74&RjPNWe?)N1_Z0.SpCFUsu#ZSE`jBK@R<DH*p*18eN6dJWJ!q('MZ$3Lr9%\q^B'+/
I1/WQ<a>b?G&MMoYD`RoTYT<]AIh6W4V"ec<s5phNj&]Ah%l*qRe\'RL_3N&\AH.+<%?JG?r/^
S^Ym9()F%oC"#"o]AY2#;d(-\IN)YP\?,;*ZT&<-H%b*Ra]A!=E*8?*3!g)qAI&2%R*A7R%SYp
@-AMX5j[Ve,f;mC!*l4_OB9<B%Cq>5-=&GMt0(auleu4oJNlNmL)U'#'JuCu4KV?lTpe5G@^
D;@b;mCY3Dq9208[f.=[^QNdi%:<cb4%4>`tQ;)76k>7-a6;?(ocp$=L8G'E'AeJ[<'4=,qR
c*pTi/D?`)%S[+En%18?HiEO,&#%g%EY4`>C62T:P/LeT.gW1;;fnZRKI=@:L_T%7b>0erg1
;qX\$IdW%$$VMci'U?AYE*7lt//ccWa6bC#P'[q>-Tn<jL`cX'gZ\jtJ\/%g4_+Le[Sg\ngr
"sqtoD\mC`k.8Xf,^8m]A>O`,P-4"b+DNQUZ)W%B%142)1r7tp)Ei5#nPRCJp>&)Mh)ea#.jO
G"e*hGG/_?eAt^gOod3a<TLl5/)l?PlsR\oG)b'!C]A2`Ws2_a&bM>JoJ_TR"P1,(H0o=gYMM
sXFh]AoTWqM>IfBi*lG6p[BX-SqNTWC),!j=dX6@HfTuQhSA>6>'j_1$EO)):!aRjq+h0$8r)
MTBFc6^XimB4Y.RcP;lj[M05mCf%bMp[9<A'Ep&%1G//*P'PNimp]Au%4`s:0u)\M\e9;Gpq7
r7_qIN_6)FPB2claQ5F,kkaM:$T`dPAO1E0qrmbIBEfbN%`P[*=4q2Dt-0CUHm6f/?TF:jtJ
47q1D`3Ti[Q0jE;FeLRWfJE2Hd/JCplM*B^3Q$oT?Q(=%jG:#_RYD!"<U'U15cjd8G-dVUdt
V%Y&#F3K\"Z[AYi-eA^ZC]AGF`!8-r;*tpUd_Rh<E2N\U'=J#MXFX!:[,K]A"]Aur/UdT-Yi4gr
+Z'I:<MQ(eT.%9U(7,ph^foUOR,uNQk!hqjk;a@bJ99.c?6:!OW&(`Ve*a&j1ZlWe=M9qK8Z
me^3[Lip.3a@p-7c>Si"tgP1k!X()8B]Ak^V"se3b623X?1=0s4"g5G"4kc2@qB4>aLQ(W6Vu
<bIT=`SA22G:a`oFT!u_b."US@SlO;Okno>><8;h[Yk,'/$IefSbn`$;[JL4/'&'(8Q7L/R*
U@8LAq$WMcZf3huZuXOkj*$c(ciTiC7?)EW!_$+LM2,!sX1_U5_**,BR*CHOZ&\N,2j[YWg&
PCL"`g2e%B%T&MN*H&;!]A;FpdEVM'n;e'V5/enVJ:U(]A_(SGmYB9^&oU^kBT8Dmkfc<A8eO,
'GdV.DEc.4<5P*k[#QOS^OZ_0RD%UW(P1V=Ygt=ET,d14")Q&,umt34/('?iLfZr[2jl2icg
J&;cC9AQIIQs..)as*1aq\Z%1aOqA88iO-NGa_n4[i5:,><IA5J.@sDj"*K[Th!.K*U$@n]A^
b7VaS"G$$U4&B@ia3PQ3k671+&1L1R8iaW9kO!+q;DZI<I<k]AcpMiP^I@G28\7c3U-,Hh.al
Mmh:_-ir*L[4Q$)En_CaR%'NS1Jep(0H.CS3k`jmp&Ef8"58X:60=&FUJ=V;);`"("Pj)>DX
3UW0glc*'I>Ii1XPS<M3)c^4TV6-!6F*Ao2?SMBc:fh-uc70gI1%iggLR#0Jl$]Ah%jJF53lf
P2(\LAGR>R2]A"]An'Ql56&ds0B&BogiIU+=\Mm[&MaS`hf);Q8lC*\;M9UW-iDbb>B<,si*hH
kFnDf1p@R/oimZW,.%-'9hnT)'%IIc)AGZUBd@'4GA"ts"`^2Y[q'N@>_Htl?0)('^fN4EPE
VMnE9,>=\UFZf(I*t3P#i<I_bsqLat,ZH@g9[mpo":5jqBX2g]AK--+UpK".apcX/u0YN]A">j
`7,iY)2+^M9#7TbKQHH@Wj;qOFcHZW@q0#.H9&9c&o[SN83Zc)P&Vpf.t.7Cc(u3NVC6.khY
&_)0<ePCcY.n]A!.BRI%fIak2M!-U>)al*3eCK[Q=a_jZL!kN,RF"Z`m%4:Vnk+P'<N%jq%&_
q2.Kj=E@a38n"Q3"]ARf/I%K2?q[C$0N92.ZUY@Y\F!&YR$[KUC0)G@D<`@Vp[5qV,_7+?c=p
T%R:9S'8*doo%P\E\B+>2['8$!D?e9EB4WM'An1K6_@"I]A'/a2Zb^T='BM6aD1fUF.slIZ0f
bNKS225ML>,*kU79OISGHcm8-<;CB=/7*iD0kSiapZYgf?BK2:@LFDY.nYb!:NpW%KC7lC+g
W/\;a51p7IHVWCEX>4)mdm$:F_S^2h02$U1;d,MLK$<J`ZlK1#9A]A4"j=AuFrp,4DZXT\Lc(
a]AYd+:!,TRMusL!h9+*mSmm$*rYC+JDaQQom8N>,%@hG)FN2!@]A2FEHRc<G(nO?hd]ANAjWiD
*<leNDSJG!u>k0Zkhc^2?lV[fYJ^qA`odA;:8lsda`AbCjfJU?BF(Xebqc3>E#(d?pl#P3r<
&dk"`aie-H0@X7%Y.h="WDR'5SK(7i7l1k&*Mmki5DK1T]A/c;Ks=l75u_8[c4aRdP_JJ^.*]A
=i)o4d859Bs2R@c^b6.Vlq]A&Mm;9uT?`=ISkZ\jKT6@8bAKl=64EZA.Fcp=:+b[^bNfF_]A6O
$up]A4_Y)*!XumG'(+Xi[4spY23Z;=OeY2hFXnI9\do#Tl?-mh2IBRg_d%_fh+[T,:(rTutKj
[YYZ-C6`32f5ja"c.OJe,NtW[MT@[u45_0I%j8Z)<$6'=k">MHt&=]A45KHNiAUV+RHDN^Dcr
:@_m.mkj.,1jD%<%TX.OI1oDi6_%\e'[@CCs^'ia@'&L7sIm+9_@q3E2"\_DU!W)[\fIb%I;
RjbQ6%S*g`b?32qQIZSGVBTG6#2u$qkQL'>.L\Q#$5ZEpCr++9G\r)"0!$tNh%c4Q(h%O?$r
t*misnHcpZ\f,QA;6pP=.Jq_h6sZT@3D:V^Au*pUX$!HRJ!`X$GrD]Am^(B7&X`F8!3Dfc&Vs
\?AVo6MqiHAggB`nYO+Aq/He9Vd>aBpd57liAfXW(%1Y.M<VNPJ&R8$M6c6]AciGG\bu?C9NT
?J\q05B'=8-RWVLPO@nHKKVcrPjE&/@*3ZpNUr0V,&/o_U$sVdCU!%OX1b_O?T6l3^/[DV6/
g)'_Q,s'JI_'Q4#Y94(q'^0W%3SuM%T<N0)Kpg4~
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
<BoundsAttr x="2" y="37" width="371" height="533"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false"/>
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
<WidgetName name="report0"/>
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
<Alpha alpha="0.99"/>
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
<![CDATA[798021,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4056610,2394065,0,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
<IM>
<![CDATA[FE_56-;:ahElYV*j,S!2gt;>?[^EqhCmuBu[VadoT(>/7WUJH<R[TYFWi)opR\$,=80nF2"B
\o2&.fBUBdkbO&.m4NJ+cadOT3Nl6Op%;+O<X-@_uk$R2;F^*pCL_N.0Y)h;6UUj96,=,LQT
9+jO#:?Xt@Xbe9loClin`/s$s*bbM&O^"CFZ;r!Kiobn^oTBbjn(K8j-dnVRLpV'r#?=u6a(
KVb]Aj^.+MeQ8pYhrA):h%rcRs0I++1F8*6\$$2qriD%/qa*,oiqO=KDp)DXQt-("]A]Aqs!XBZ
VB#PccuJS"'D#95d$r%r5GrX\e&)F1\.*u,U3C#(3gJWp,]AGB)5to_l,:S.0]A5/uK*K^RDq5
rXT_Kh%6tN]Abc"pa@cB6/Gs9G@(dN'o)FU[ra2Q<5r+[ggb3H'=:<3FI(LQG+[\?:nKiY(=:
[N28/.",-N%Z.GJFH?+kZmP*"N?>rC[tu`'>Krm#3lS*9<PUJtM,u]AHkSqmp5uMjK#o2P?rd
C3+g_iklVnM,_4DOO[(W"n=>`fB\R?K0P"r'L:DQ=>I\)>^\jWE0S+3hA(4[b[HI]AP,.2uh'
#YOno0DjkdtBt(:j]ABVp=rTIP$S]Ae;Rt$+g\mPp=)L#t/SW+3FJhm`>+Ee9;Z=otOorS[Md_
DW,?%6&2TpbegPBhmPA"iK.,iL)L/rhen2kTHgfH6):D7f6H*J`._oK;^bC>BEfKB(eMdO&T
s-QW<"#C#I2)U*4$tD7-2o?8*PoYZRndC*q);Gub\q"TRApa`'4@t+KiUsgMep),Rl6W%.o"
Y)0P53^UKE-j\a\ciMD'Oq2&0N-2:LSRB:ED?OOi9m?nUU;a\@ICedmDfj_UJ*rWHBc6LSc9
W+;r$Ob.&*/b[^/YV9T%"Y)>C9Ui)8/oH!O1fRL2RA/,RFaeXlAb\*$67e<)N1;M.e%Y;RiU
9`VH^B[7q5r4d?M2dnIQlTWPeV%We=<L(^YNG_R"oR]AHjo>)]AJf('Hd8Z2E+BLAf@ee9:6`h
qmetUFL/8MYHf`@-l#q2Z)S3nX3rlZiLIg-@sl?)%5i=XMR#\s>=LO*115:WQ>@?iNC*\_!E
lJ#fNqnEh?*\&Y`E+m'96Eh#b)U=tdc<)^Ei6pa>@0m0sPhr8Q,1HP6T@6\_=!Kr"q(n<eNl
+m+$fGM",n\-"bt\^EE'RDYYC.YE1>2[6^F%"K@pWL_p$9--M38'"K4*_HI]Ar#6]AadoFYtb7
D,#\;&Ft2THQ?1U+`BZ7h83]Ahqrt$@jDYEDAqfZoa%-`Y$7`dG8af*j<Kq[((dKR%PWaX*3Z
)$O*ktZaY_/U=5dhSW'?q6`Y,5?uP#EndmHKK:]A/:]A"PeP))Mp!X&^)Dm!!?532pr:a4S0_p
@PNgaWK!cS)AKZ;T.\RC$3KmMt[+_biS%j#aX3Rq7F9jq?#Y:`1&?7j_b?=R&HAeT7+fedk9
4L%n1Fp4Df0^[QN]A(&YtN?'p(^=@K-"&dSQmt_@5LU<llYS2n^Y'Y;GoW6=PnRsBV[iJ]AHDq
hu'2j&Kohh@,@XtD$VTuFrZ`Lk61]A@%mj;9sFZh6+NESh4/\3PDrL$a;n5+ia7f#+GUbH]AGK
RGMq]A\QsoETrT!m';]A-Zg1GRWHVie%2SWn*.4P`!Oo%arRFo"Eh8(m>i4X#bI*)b,^.M/Qc)
_/cUP6LI*eo:]A>1p1SZEBM/g$ajE%e^9XFXk:"<!A!b5s2O8DZ66gI&tR@i\N3?u$+pdW`gU
'JW@qq+p5`#t4E%!O,?ss1b`H-n?BZFSRZhr@=>)"(Oda,-&VGae%IUfibXIoV%EXIBA5aLJ
B63\"i<^TN!tK_3-\gL?H/@9L$\8i?/)mOf^B%;G9Zk=rTjtW!980'T`'_QQ\."?Z*1&h8=U
NWqX4S0Yocfc+V(7O![C6)^?c?*1*_LRDZ2%f[)'pT73^e#Er]A8OpC(>g/iq[9G;7Jc4'.\h
$cN3'tB$5s(r:hm,Sq>uYn-:P(k`3R6&UjT0)"F[12C9-O,Keg;#qg6?K()fTnpT!j!H,Etj
E;/S&HOP7G*)^`ptiVX)lKT?nW&<`_0KYnG;?8-V/gj(5ZggGMX5ATL(!PLBk-2_h(S>h.)T
6-^#jg.J&-oEiVY`-L,"EsF&tXF.Y^GMl+Ess5W<^LMj_[Pob;R")?+8iGi&!(oYVSjpm$j/
bi?:p5p`o%>J3uZA#/1*W7)'B+Q@6*!=CJEA=]A_,$9JeSO,OL8K+F:oQkY7DMf9KV)!05($=
9&.AY,)o.-P\uB;'h1UPqd=9KJK9!1/uO1a=V3%Rd!U)(!o"V2:Lur-P$Nn@sNmF/TA1Tlhb
._UVd-Z[f)G9kEO*dM<jMHu(QgKS/+#ROuGXh'mcm#t<u0$@]AH07V\XB>d"`3Co33:_\=K2p
OQ%&&M*cVBdop0+Sh\0$r&u$[56PF9nX9cX.4E%KHAUkRs/q2(\"e'2Ts0u0AOZZe.Vphnbp
nkn9@?UTVt_jXq3,3O6OWGEa==BN`+>f>Q\M[[LW64NED,Q6#n4ue_T6]A"/%[W2+d+B<\UKL
CuuU_r66**CaXRQm-7@")3F[mTnQZZ"%RGZjY#/Y9rm6,cc2>X[8@#n6@f^d=HP,h-kX3k![
F*/OWVj#8@p(a<X,4&nPR*6;+PSD:rQ7>*<<33r'@[6#39P1EC/h/aJNuZiPP=V`g_MfXe07
!>NN*3`JhW#6Hb'$_A0C9jml]ArKtV[LS/ci<6.Z%&/#Kk:r,L"3m4bO)\qSTd$S\-8Id>`J%
,IU!>F)H+I$;/H5DXb?hd14IpE"J$=\*(&BcDO#^:\qEkK?`pbYbsM\9`(BL8GP\k,X<)(Ck
h77BChc/RkZ_\86UI5Gc4tH>M>2!EFHGd[pu\nBW:cHjoC-%[posN#fO.c1-KOrBegJ&(Q`X
#[25O%,rhB?+rMMUl5r%17:pT2R9*-PN^F:o_g7?TY^3![;1!\27J-pUA-9XJ>s/_pm*'!>[
m.7/ZHP;ope(L<@[#LZ`0AhC$Q]AV]A@h2-SUN^h<,fqlTooMTrhNlZZH-r=?U!kl^RD.lXIFq
5*PMDgStl;`8jrCnrm6PiM',s`&JAG,/&:)4.ftB`D5fU&^lR0i$l%8MRC1CQDKE=QCdA'1[
387X@"G_[,>2\Y'!cRF7m.b;nPZ$7!F:%[%T.nA>Tl&773gRKj8eYkJLK_87;g%2NSk'PT(O
93`ChFf42V,Vmg?F,kXRsIjX%A0^cf!PMrCR[hRa[:V^ABS0QGclcoH*`A[EcFDC<j;NbW=+
l=WTbq#^"&Kd:"EklYT,j\j;p?^@]Ai[jZHRlhClqCetQ.G:,UfTFWEeK6W(Ok\>5>2AZ$)^,
S5qCqhb?UrK2J'O4$[4Bl8q\?,Oo^D#CLYIdUE8Wr\bS4slLG)bJCc$<77*@(QdcC#)"4g'i
[>14!`fku\Q;/$O4YqL(>;*P6]AlbK+ge`::,6a3[Nl+=q]A?brF.*sWu)NR@ppH>m0)k^2eM;
8>LgOrZY?4IQMXQ-lGpA%i&6kOTqa(#'S1XKho:9Kn3Kf:aBk7^$ftlD/1;VMiU']A?6`A&QP
aFn%S+4\Zkmo/9p`*jfHYY?elMKY]AJ/tQj:Ja08d2"m87Q=@JmI8gs5ULYcBmej*ltRR,ljF
h/hL]Ari4!N97&_f)dk]A=S9Z-<Pt]An<`t*rm-l99q,1mk[(&BoO5t,VO_4uj24$df0mZ01iL,
=F5+4tDb_7nIs>]AOY*Ehqhr:P$^HJtflk(Z"TeHIBfc^C"k,3\HTJ_$6Kb)+nY>&"[]Aj<]Ac-
dH-kalJm'*C(F?L'!rWae&3?Abe4>5p5Mc2?=FgV$PPu>,]A-I_$o)4P1nq\D0SP<ShB,.8PF
$Ge^OtP;A+S_LZkse)X&HNSQG?/PXW3>Wn]AeM`17'K560.c-L.^NB*TpopN9EUA"S@:at@ps
7u^_7%l-R`ijJjhI`Ll-6#Ls4[11Ak`MAQcuZIsR0%B?%!(s20CS_b"&T?N)20Ouk#`B0F$B
,!ejaJ*[In/f9A\TL>pCfPVVnO99YJID"+Q%URWU7gATJm>R3(2)t+5f?r8D>7)m9oVKr_NO
k`L4(3hK7c_mklUcVD]Aq#X("BZ/gVta&9(9-&&\`QOhKI:F$d6N5A!LW;!$A3h"8c*mGM>PO
Xd)s*ghY'S3eBonQC2HJl?5?=-m4<sbht3=N4[kj_DQP_[MQTFZUfATVB4\rH3&(+P4kY>]AW
DJ+VXYFqck\t0bH96DqfL"W?@:-J`Pa=!Gi@S!A(9\!9o_t7S#Y=h8HKDH^6HQaXWlkF2EPJ
q[-=&3$1KCcuXBKRG<t<6Trq%?Q+E(+V.:[%3D.Z>Z[P\o!g&UbAAU1UNPl*l=)qhk0hREb8
^>!)JCX8"d&X,!o$LRM;$qqn%/D(lqYkFgtYQK1\6HDpiTjM8kJu;\;4o@$CVbr+!fiR07E:
!d:a:7)V%H/Rq"aVaZW'ZsEDGF$$TCEBCjIV&E9Sp\/AHr_]Amq]A,qS:9FW.8(=f=/u[0c&5O
MMs>#C7@_<AM7F<O-?jl.W;11l?BcCtU)Bq#DO=99X5VoUb:TEpMN;YErV2,,8U7dFQ)RPA7
?>o;E)JA;Y'1dmfk6KW^Qu^"?D`k_d-.V7j\O_OWhi4E!5j90OW_jF/YP6E*U`2Kd?MSMY<c
Z^'ud%>7]A?Tc+jQSV0%im"DJ+T7TkX8EIU/.)_LQ*U4aj`62g72U8cqt@gak`niIT3;TdJ(F
2s)(u=/1fcgR+\3?B<Jb`6lC.G#MWT7)cmM[Z2EI[fI[%)t%(Ha#UBN$8=l;Sjl82_rhB%Eu
@SU]Ar,*Q4IrNEbJr/D'`H<s7eG`Z5]AiF>L<VFrZ\nQsO^Cm2B)YXM@q12#o5ugU2Bcu([(UP
+r1kS/d"]AXBU,-</!cV'Z(CG%.p93B35"E-mGFVa@D%)1S6#N[M<]A72J[6.CD100hTSV!tf&
T2+<+;s\,(OrR#ZD6Vd[YE\&)h9=)N$h=bJ>Y"BTkP34q`H:s?Cm'$/X.eCTSaI`GJcpi?ii
X\V33iL3^RLJ'*[1F#W`td0$^8BQ^8?b;DPW"`Ih7tnP4*E[#q).WPa6h#J$)t;L5([Jf-*<
$J]Agr@lI7?kplPNlK`$h>4PfWf]AcegW^?qA6S7\K0<&7^K:<r+VfhS*\B]AF*Y8la&Q/@tE$"
Rj?"NQ<:I2fVmga09EETW:sdr6WU`;/doDlU%D<76XD(8MGUI+Ye1pbOk/k"`Z`S[-S;mdbM
-T)ks4.TYEO(u+5pTNknETbHbELMI-G;tn>+$$F1da]A_rJ^_*4?Bi/eZbCMX#+a!3]AlrJiRR
b1'LXp`W*\$TuH'rR3A-HK@g=G+-SJ6>Pb0KL=-?X]Ab'5JA2_bH\XZk!Yd:T!8.1X=liI5^g
($#muDnCW;MHJ&R[#f^PO,J5=_%Zam3VdBPl1S(h1q8$cm7*):>9nAdEi--&E/:0juA"^>J/
[4W'B=CY*(P6Tk&8`QZEKJk6fj0*^.!-Skk4'<E;k"72r/5A_7)<W/a:o6X-9[IHt>@t)J.D
9e[Fh3l",78AXE!3;fMCP@S`EW@26%>>,m1QL--FT.p[QJuIW9AIo`r3C%fGt#QSK)*ak<m=
fIRG>69mIsJ0Hq<jrjg>2#Qs^TFO.`.@RIXVPcu#UA`u@W0]A/!^2gAGdgXB%5iH^p#6B),H!
?,>f1\Eb[3fe5H)>\oMMe!ropRec4]A#]A@2U%2#F1Ml\0fa</2rq\WI>DK,.gG?4MOEug&i3t
`LVAI1M.B,/E!b1bd$F]A4EmW6UReIg(5ZL/Ga*ii*!Q[hu#dojElQP)(ldT:o8Uq!9V7'k7W
O&?TmVHj)jJ$3``[P]A$\=Xb[M#Baaj?#'oj4^'oI8ghAg:#rRHpT;;OlSRi[oYb9`l_sN/`^
WS!Q>'d:o9<'.9NhsPri03Vce;90;^McH#Q*2%Bg/\"8ZF/=$O\^C/%91apl-7<f2skVO]Af1
ZmTg;/`YmP>\ao'rjWm\qrR=c4`R*[d<%(d$7C4=;.%YoeP\[(Bp2AK1de,FB>PUjmr-G86b
g;NFm=QGihd4K`S(j82W:P3G9qMo\>drB@Mlup0,4EF"cfWkAX4jAG)I;q\c#\`G%&Zd;XtV
"tPE36Uad>XVA0bi@WrT81etQg2[9@W&WFZeoq"T"?%-':aCINdOccYAk$']As)TGb?i*/%JR
,W9^"n*O9`<Ci9kDodVi`Kt(4j@k\FH[SKgN6i1F*Q0+b0HrFdNo9m>Tfo/!2d+37[LDX,!t
.:*@JThP3o7k7QZ''QHIm/&gZ(j$S"I<nP=S\jW/ba091o[9#a&,:k6-Nh&@K)5L8sN`Z]A./
)p+'Cn1AAWHaPd<c<9"MHNu@si81aK87W-&s*`;QZ>tX4l6)Gji*Y]AC;WiUi!WYHdm.,26t(
A#L8Q9`Ab2?e6'V1"V_@;(RC/W(",pT*R0\dbQN`Co7&QR8u9"B7&:2YGL"Z60!:03`3cY6%
?@.*e.lDK@N+J7!!>kuE"r]A*H<SfI:<=!$]AE$iY_7n=(aF[,s1Gl2Cns0?rR4$I*@ZgeFVFG
Taiu_`sJb-X^)#geq7@Ahk?=^ihQ6k."E;=2Q@9fJJcNh$U<R_:_GVtZmqtF<"a0g;]Ac>\GY
6C1$8`Zmb[f%$61C2*.:1MYQVp(I)/_nX3noIEIlfBceIf>?`sR<=bt,F]A/s/*:\sjn1TB+]A
<>M<IVN)JC.Q=:)m3tFql=G+PKZGY$^HsEt!\N$WrII!W2g`gD+@Dm=12podP@o41$/CTTQI
YaKW>ckkjO/G>7dVu0&>,A+>TVDbFo@Dn3=J:LBBc;T473Aq#/#$Vl(`_grA,aPgIF-5pYWp
H0OLA`qb]A#,7M@c7%"Z/U-7:ZsdfZ"-JrF?Df!>"IU&_eaVFN#VbM),a3EAE7A#m]ApA2[&r,
?3#5`O`G;KOb!H;>ST4i^P&Z(LU7;or$0mYH44r?B<X)h..N/_^h)IGi)5TCOjlBYh2>f&:R
9(accIT^*fX0;XEMJ3&J5ZR8&#K^_Ko/mf!^#C]A#;*"\$ZCOHjI-$,YO1B1lnh"[\$8`6'DO
pj`Z5FC4/K!:J)X6W&LU/#UtVJ\LcWJm$q';@._a6,.Z*VOq?CsUlcR6_V.ru;4m9]Anngl6,
RRkXINHqNH:"W'LOX-1me0?q7DH_b=saEBXBa$4jX$\r,NPc*Ks&(tg,YYi;oZ'(Y@TkB[do
>ng2>0=WMR8=D0=)*&e$I1o&7HO>1P"<]AA-.SKB1%]A\;q*(c?tm;_gRT_YJ#<?gXr0lqKgd(
:Xt;rel$Su%,0D"'\l6LYqdb6F*e$E%44,!2')t-JJdc^mR?G9N@:,7M=&0P^d#T-4`F?[l#
:[BM\DjWD6H,0ioVs[(n.SlIusJ_>#`)9jaqGB1DtKpipeg'a4oR$W'R,X]A<.Dl1#3l9bCGa
`'m&re>-!m`_8_cWP#kabVF$Ra0D%@i`a*@ID3+'('?#:K5]AIVA=_d8511Wd]A`ZD#CmLNu@[
-'/k29C^Rh:Pi@&L\iWcK^f*l/RFh4@pa<MD<._5=CV;-ic`YUrXag$o\X6i3BL!1GadD&'p
C[7/gY/\J41D6Ip!I.Qf;W5!SPT.)#K:KdqJN"ofjUU3XA0h$/J]A28+S<4gK1tU`Ubi^W#K(
`*&rFTl,H/GA"n(%o+Y<Ws\SC2+p^mR62:iT(lN#UecZk8k+c9i<+3FleOOHb\77i+XcDsl+
7gBZlm=b4<&g,`R$_M>a4+*R91fSUt.,,-'0`?M_#Y(`.F%:Zqi)]AeDjdg_MhPf+gIfMd$]A3
"+O%<2&F&7T<lhhIP6j;`,]ARoP[VR#d&iAV1$2?42!L7(ZYS_pGjXM2a]AmQeiF*(a)fO0GWA
.;("&S=uN%=faaUXBT\Q%XMqZ$8E<^S)LFBV>6eo.T_C$4S6P(^1-[4=&daDMuSR]A>ArM']AG
G9NAUZ4ff$*GfBt`RC)rM.['[0/QX(OoT,[^&,$TH*7dfjVRC;SRq!>]ACq)"00jq[Z`+2&\Z
=auDIn7tP4W=;R"%e3VtEk8#P>r3"g/gt%rVEldM]AEkJ]A%"!h,ZN_)`#5Oe&U%LB_rMYVWBG
eqGcEgPIa1al8YocVL.,Ltf>R-J<IXso,ZC\TIU!n;9X:M_PC@RTbr\V:;Wd<P,`:Z^73)ST
[c$02TVLTZ#P*WRUd\modDJGUT$+FWA=gX4>ahZ"N^od(lGGq%6=S`LcJ(fC#F"XC!K_Z2)Q
LM[9i'Kj0N\RD\e*bcJlhCrOT<(R&1f*Uic%gb^''SWlLHm4^("0GBH(X`p,:Co>LrLsgJHf
'E;YtU*=3g/;VPYAS9ulKt<Z1DTdFT%(?r4Z/k<37[T[jeK,Lp??O>2Ra*P$s"CWIDcA_Fk.
kU]A3XgmE+N0t"8-0"q33r*:Rrd`_rq:"P`1OIOrt%R3"Y`%qiIgc&Y$i%#?/9OTk":3tE?4:
hTJ1/TPimXlGkin&F#(47fe.!<7TafSf*bMNTaj_>_jnRR,iE?(>WEHFRQA"@oOkAG)p26_l
)%'pR$]A3)A`D<;aEK*uK-,N>G<%FE(tlg1!Bn\3!!Z6%=dFWU45\p;dK(`9d<:>S_pi:*7e6
snHrS*e6GUh@8!l%RkIb"lm`lD(D1`[DaLAk-E4b=W5*lUMbk707P2eYtm+`HWC2Iti#*R)-
l)E?_V`ckEmG*/":5LRO1JWQJ)7;&F6:BQCV/_6[eq$]A^4i>3e#$&`:tXls8Xr0uBO(pG;ME
LDDeb4$OS>:fLjpf(js:I4E"=E+'LKl%`%-gK\$*Obn5@"Y\t=iIf<.PL8pMk=WE*PP@(Rou
mU-$`YN6X`mcfOsYP*/HIQ5?R>!?iE<5[7!l>B[r4RUT_=SURU=.VQ>s#=>$T+9WP_Y?6D?0
=*)(fq9!/#PpNnX%@SXs/-a."D[_?geho?$k2BQMejaO_0^@R;=a#Ebc^*JkjEed3S^;u]AGL
Sfr\'5et>et7$tmVG(UT$MW4+)h)KO\jA%JqW>L]Atol7*rm\.T-'6F2\A3n\,-p_pi;%>N'$
L/h\U374hYb?-(p<*%0_3Qjll+"+&UI"7n."'4Bm6kBaWgET>R)h0obY+)K#ba=R42Vj/Hb8
%R0LXVj5Z[$fp:XU%KQ,Pc=9KhPW0AJqUkG)P>t7VQYT:DU`EFa(1Xk67'k;,t:0V4E>?6:Y
84C8L/2&Xk=-.a_Nd0crKCU.6a6,4N##*@GfQd/.^UHe9W4#>\s0Yo/9rKidc&QTL5;ca(3=
_aX@pG<aOqpdM4\;"M_R8q3F_f-4mD+hS!kq8M(7'L75N]AkakqIKhKEY&Rn@\M@'_]AQDU/#k
b?^!\n6q"o4(7n<q%,"5@J[h$t!jp)but:r:hWo80>/to.J,ls+[,=T8l1W.!H`U$oF]A']AXD
O\T<"-VXN=&(i[\j=MWLoWcVkAR.X>rrC_PfR3#G)2q[P/n:fLK,M:rS)Hre]An@6?T9;3-ok
a@KIqS"J1]A6t7fWlGZ*-9&?!R>b0K:o^2?TeWI`c,hO40M8^>#g0[:;Kg]Ad#g+GDpQ'qtS8P
M)<mP:`IGUBtGg"!afppiZ9lc0a9[iR2N*H-NeH?DeZC(NU>d;:j+e\C\)YK5gHK"q*jVtMV
iB*Pup(mD_s$U^STBBY1%&7H107!]ArChOnIXflW=;WPCIDU-(fDcC\-&0/]A7r2CY>`M_N<UM
TcO:Y">,DKT-^rPa*fi"l`IB"T3Ip8-1jl3&_[V_X]AHZBA7d)72tDqJSoqH5MCb_H!&[/k,i
`T)tnsqe7YX9=c'H@J4D[-<uIBcktA0u.T.VccImTO4XI?.!RXd42G>t7/!K_@#?V4c90Vr@
g<&]Ah]A1cL&/Hu61FqjKI=BUdbk1.KC[uEanWa5&XKUO4Y7rCCV*81GL+/.rS'-`@^-bN<;;F
Vg[-#Rq?KiH.X#`Ckn6uG/9't@G/c@[u6#<kU=bYm(LUZT<1c+Sp3HW;nR,a4\iLfIl`gJ$[
CRndRL.<?Xk=/foNp(VBh^S5k;m+Z9cK/b=O-iROA2XkW_Ws-u!.mY2Y;TmuBRn641Rk7E9-
UCH,,--s-jnkjG:oGiqZ/In2o"Pjn*%jKA,KNN(BJJL?q/lCs*=f!ujFDgAp_Lumk#s#Mal'
fmr<B<&gQMi@`WDR.8bCbT5B^l)E>?&,1=GGCATcm_?f@`f/F%@1R.(q(N5f<VnN2f8N6*^E
(JVu<&*LVQgk8Q[5SSS5a<U/G@Bb9"1\[5=2]AA)2(c>MH;<8"]Ahi@j0JKa!Mj7E6QFF*`cD-
VIZCq5*YZO2S*X;N(H,7#l6DOi=9&WMA^*5[Wt1YTCPc[Q*^]AU#)3g6"$)f]Atib=aZKB"+Bs
_=)._HX(eBd)Ik"`\8I#W09L;)e*4)*$@,b^_TGj(ZX`??nN/CkiB!ktbc^SJA_Zl(,&^sBf
*EFFC6gGCmjHK)#+-d>o"*1LJqOBF\"tC517X4GE@om4/hm>qD^U=kQYEp`ENAkl6nHPt.'n
npjk;dWIK^DPi\>%g`fJ?rHF1U#Q[hrhR]A%Os>LA13Q&YI@-Ere8Mp#f`MLck5!1S8;[_)h#
`"\S@&kjbg*sM2+l"Do4DM,*)fPR:NNX`IXq!Z+W=ZZeB@c!iP1+p-tI(SotQRrboOsMA<_D
H7*:OsLq'1?D,J:\S]A8(<C'&cJ8_&7B8Ilf?6d2M6Fh&r:XGb7X#O"+6MCCcI,J_Z=N.]A^Ao
oc$$3oZ7ITuVKFp^^+f9b15+P8+k=Ei%Nq[(%WbcB=tO&_p3Q_#H,7H+>6lP3\<0jr3Oq'A6
slK,*K$ck+k*2bfE&fb$<"pc+LIN#aA5`9ZLY_U)B)JFJcoMNl]ArSddQqR_q"C3,43s\uE_,
MUcr?,O>)k.8>Fkp+cL`XN[KbZFI-i,E0%X0<VFAh,3JkT%p#kQu<tU8Ka/FX8]A:4N3X/Q.(
dfk/:Ub).W\$LB/(tk%*"'["6fO:E/9R6FuqV<oq&E#TYMU.%*X&Qk3Bkg-ghX=eh>X9ga7"
4O//+A&I(tdf&P>o3V^B_Rs0M70QFblG\-jZ@q"/U&-@k/dh7rS_X6,A/'V(I9#PEu;>1j2-
UAp+Id[_\(P"QoPG0EINg@&G=jiseR(_ms2"UV:]AAIFVg\.D*crRuf#@he*4``YNR/$'`nlW
YHYm3/G'O>m!L"R(-Di_F0#92qhSa\]AadLcFcX$Y9qagb1Z!)pM,Bhcg>LWbT,Dr<,?n!.He
;Z4#$):EMah'Xc?K-&`oV!8sEUK*ehc4V?V9MQXU/qAC'>s*7;NLMoL&E,=#=r@Y]A0i3RA&l
,"pgQLkjusJs(m0FuFg(E;<l29]A^@'-SD`<(-Q/%Ta56$`/gfrkEhK(J<@HK`/rK.grpMt[R
q-Y?,#k/q!3Wu`j@mr16+a9jVR_gEDg0d/(D]Alff)S@MV`rdaWtidr&KMOF!S?EHCKpX89]Ab
`VhXVOc,Sp)OG*\G(i;"poIqI0e`!0SmL<e`^"F4$g+pS(O)DZ++Ai\nCUm.G+aDNU^e/a?f
\\:hs1lNccnS\p^%"0oTIW+50g3g47-7?ooWQ7V9o>ZN@LR-#]AZo"TkXjQ2Zs!`E3]AHDArj&
(S9tdi\qXi&#bc-61)#XtGT+qaWfa5;AKXKT'DlD7\AoTXQ#?3$.q\;qQgp_mHG!S3o;?pQC
^lDS)=k58>6\^tKUK9KR8Uc-N3B3DK:O_cq/'2d)Js-s7a"j^r844*21<%GC4ji<Er-OJbDP
"CW^Dk5jh;^T?S`0A8?/-jL3:n&*D\OXEYlFlJ?n@Q.%ujNTWGCmq3Ae%\KRsliOu@pF>X)u
G(d4;B#'aK.H"':\8/')`eOG245=A6A/tot`Y4jSlGT+9bE1,Xc**W0`OE*(N_K8-MQJ6';l
SIXoaEm8Ni3+FgCPREu9n)h9GS"_4LMSY#j8cJZc8nIen8eGna5_6a<Nah/1?;_LD@`@WpeV
3?0$apJWU.'$3"*V%LY7iS/5?79\,>&,jNum:jd"OIMbHF'N:_Pl\R`:qbIX9a4WB:!RW=PS
^sDEK;*,s[-`$\&#Dr,MKe5^k644pfa#M))A?oT<]AGLHkI\&+_GBUSL<%E/Jf.2`T\&lK]Ac/
5K+B9-?9hu+<,*uecLXZg*J;`S-GFD6F*A"d#W)u_sfk7.1DGt,Wg4q5M&$<\D/c)sT>9[(4
VdSJ.+?2eQ_mT/(coo"&9YBp[K*5CmQ4>\=2dj=BX`SP3(-?5`Lq->M3V1n^79B*FuF51Icc
X1>@TTU$.&)[*,:8HW@Ut1$YUQ6rjOrE=U#cl,(f#Ct#A0']A<pd2WfA#(lo`B?W0*MZ,jcM6
0LnSDcDYe)R)ZK48QT&@d#5EZSg"9uccb)WAF44E=K9kUTK-dEIc!IU)TQUsN5[@qM.-'X/S
_3;^mMN\D1]AAV:?OEWIUPJZ=fUi2j$-.XrD>V?K2&UR#YE9&Mk?sZ988sq88YJJEHf'6^L^0
h@"GXcKl3B0Vt)0:;+L9ZQ/AD:Y`Cu!@?\6AKn?[q"Z[j^sX\qpK\ecW0=>HoTSc6H+j]A_Cl
GA_9#TYqRj?\"4XSEjngBb>jtGbtV$$9I]A;H_2`bUPHXI&k3L=f\sq"?S&K;1,a7h2;0t8RZ
!m)`G#5;K\Y5i1V=:(VT4(Di/T52'8ibNAW[3It"QqHjVTofs"$7^m"k1M&2_qD;m'8J4"1U
pfcA::.HGoWt"k#,W<<b$gEGfR6Wj&5X`JIj6H`?3uYbJp5pqlPoC9:i@lO93;J+.RB_i2qI
-V6\g*?A3rm>6eD]A_\,aa`2T2"&1,=6<kl`dfp(R1)#7De);0QS@GC>-7+V!..^#UPtdSO8e
c>C:_HZa2V$6dm;Tuo^_2k,,9.V("GIH,X*c\4UX3e]AE-[=fZDR>Vd,enaYYE63,o(Yg_t(i
#@MEHjSinDUs.V,I$P3jCV.Tohd"gGoY:S5f`n)P>%La/KaGu(5M8>@<2U%JV!H?9Q\V%iQl
t9^&8GJ=pIOcc1&rJbS\MAG"`/P&!^$)(>hn.NY3@;Ok1H;VE5N5)+s$jm7UC^*;)&TfI5g5
>#`"YKHZneS7I+:rM9>Sp)TL8Pm&"nB`>^,BEh;7FPL6jS0g5^8ta@V=&aiP=+qNgF3G";,W
N\2=&,,[c_M>J6*_TY%4:Zj?YU"->Mkee3t5Q5oQ$1p5$GE'0B+(Dl/O$"g:S#+29!qtddN'
Y_j-$()AAmH:D#o$M$G_)AIbo+WT:#_U=)j82C&Wn-DHO+G8l4poo%sR$g)N<u9e#?It?@=W
K<]Am$<1unc.q7.Z:W8&[9ZHnA8N.I]A3c?iKrQ7'1^3D]ALjgX`h=au$mYR9s[+SheGC_:&5)I
%f*&E)@&ae^Ve>L\Jee[^^0mWZW^@Ip"dQ/&eB*n4YeTMAm`DLVs_F_)RJ'[G'EN[oBd1*3a
NEV#t!U*Pl*4%]A1FHh99NL'gf#l`1P!XUj#8CSjH^uGWM.bM">"!Q)k9VGS5nKC):df/R6m0
Ra,:]Ajc_AHDOpr7\(M<[m/@E^(j8DY$^r;l&i::_?EF"B4hhanamNj4"phKRn8@N0;W^ShH!
%OOiG5F^+RNDZC<kFpJ.E+9+_\8D1,RZlXpR8#7\7X8LA4?2ZXa+anQU8fPaG=%IhG>&/tup
NHBE67@B$2O&cZunGCJkRf")8r@-ii"Hn'U-Y;<kWn`,s7KV\m0L,g(38.-iSG</lL!sF%N8
9Y/tEAHQK_QV%,3.n]AWB=RgOP8:AdhdaXc5>V\[d%gf"OtI8AR,*JaMZl:JNNi_EA(<@BJV"
.CNe`BN0mNUaKMs;_n=_1Q""=<s#]Ao6AOO)N!6Is2o&),[6EmU1P]A)A_O3jA73F]Aq7dq/>L7
k]AX!;A6lbUGW+BY_2gL1aR^@6lb3TU:J"51iZdj7otKmmhL`5c93#3DlkN=9$T$SrCL8/I#[
*t2rnet&qSODoL:2<Y[<@T_7AU6H+M*J@kQ2l:A*':s`Ok0!.He'1[a`/NA%-36i9jJ9]A5,g
g>i+AV$Mp6cAAcT;$]A<u)5+B`!moGP4O;rn<:Y"^QF#\-.kD"I\(b2RdTkpALQMcEerKi9<p
b29II(s&jI!$Yg++O/U^bj`+[7%=gm6e'&7FW'cp!E2[4P#"tXRO"X;1`E$>.ism'?Ef;+P1
XhGkJ<Cd9H5H,`8B`n-h]AbZ7A/of0[H10b`+WGH%;ZH#nI^;`.aQa.l3eaFK7Bck+QOCW$t9
G@R#28n;u@9Hftbnn:bMI4a+mm5L'j.nMXrb+g(m0Nl/JJB&0.\Oem`Gp?qs,t(4o7?4TF6L
u<2SDR&e;X4\h2Ol:Em#!I[QNTchia8Ia7OmV^/\_$L*f)usSfb&UkMp>?e"m<;e#>*,Bgdm
&D:[V/a7H3oU;):'dK5r:0pY42/-GKe5^t&a3MoSN2)Viu7OU0e+7o--%Ka'sPu1n>IK[njk
;?UbS[d)<1k*Q,FLG#6*n24R)13,=7>7'kOouG$@>[,p%L[_hK>_em*du2uF!_o7>g<EXJ&O
VX8ZRH6@`+DkBo)GGVb%7D38ic\Er"d,&L)D)%iI;L[\-isU6A;4\K4%J^tPai'?[cPhSK:S
QfrT3s8<PYXp0U12hJMmE6]Aoq-K8+.fga`['E<$Z?--oRDlRN)1,c$j&%>o2kCt7V)D*Q.c-
;S+]Ag4/L[_,844H5M6`8KCEi;Qo;A?5V^f!(c;jU2WE3o'")&-1\t$RIaM=5qs;]A,^WjX&E)
u;G4Hrpi,%u3i^b?fd[.&@$Z:%\KNRJ8!@WGG;IedJQH3B*ufEdf#&dFMR@4e?3h9[faGgj!
&kn;,h6E_8Pb8tSQ1;N1NXUp&G^`\#8UqRj!U\=F*pP?h8lQN8;#ldNc?\.lNcrbW$uP<Qm2
nfa6G+[7H&9o]A(F.+52MUk!`^>Z4tuI'hn$2i2?WcKOt;"]A04`66O\K)mdD)l/?T-ZG(gBuL
ZX)RX53k`7HK0ql/S16;HqB_X<,"!55(9d42]As-,7ZQ<*Q:d[#"FR:G+#aIQ*RC*IJe,iWEI
D%obM;9K>il_kLfr<g9"^%6<>@Ad7g!-$@0e$^S'9q+r]At&>M2VhOVhjPrM46]A4K=5jd#*!d
c'$UQ0)@jFdINZ[Gk__;]AYY*&!hR5UKXHBgEEg@d%DU_p(Y$(`F3d\t\o:Hpb4ZhG0-QqmAi
O+5oQ<XJ7bU1NNUM4NeOJiA/-'"]A)SdOpI<qQ@eDBb8<<+d;YDW0<DN8MEBYJ]ArF_LBrYGa8
aoT.nW%?fLY,C%\=`#0>hV&tcnr0G%GCI4>5N>!&[?S.K+q&[1d)gS8DST%'hI[o07j@kH?@
erT[p3BMhVrj$Q!,L$LRUM0[!?!1;k:_m]A4(8GXoYAbh?e9EnV+r1&U8PL^U:P9l`=u6+hR[
f+MalN8S[FCiN9M^eQV<i3V%T=(r2MHI;TNG,FXYOi.H5lqF%oZ,b%Ohd.$I8rWA!CeWHEYa
"Hg#%#T:,d,qcn<]A/'_C;cuX9HTqAk..P'9(QNufT7C5<^J]Ak`n!U3Xo<5dEhTaA0@>T(VuD
Jc]AJh,JaTfsYq]ADmS?h^X1Hlmh<Q%Y_;8EKS=$O,geq]ANR%Nln)iZT-:`o^JH@tckJ&-4[?P
tOlU:nn/:G'e]AcF#)f,8K/2pCC!-0^i\'S>s5k7*(;bTfb`mGkN*75Df+ClpB'o0['>N#=R"
s2d0!!q@n.X]An\md'f7&'KA-XPtJO7:dT/R^E$WYXht/q>\-i$4a&GAKG+0%+e:7DM3g9B)r
cs:5LeiRf?6b;Hs^XY30kf^dtE=bI$*jmcDa#$gjbuc!:&]AW(<qOkM+2Wud`=7s^'[eJq!49
.-!VppFuTV0=5LE9Y2pr[b892uUJ0'`Z-ctXVH1#.!Tmq?ou(UhDU)4kaefUcpBq9j4eDONf
>/nU;d3-RK!+.g`G's*LF#\F]AhW7gplaV'>a&4UNAijXHr.0V?X4kdZPH:sLE$,QW`Z=dY.O
#M,5PtqStur*VmZCU2PE*o6%*8GCNCg@/*0Pp%@CQ=Z3tdaj+62[8IoFpB+kM_fRf6-0l+06
EN>g?94.gr$B9]AH:X\:kpbBdHnK,KuCYNfA_-oa$YGj&dXc-Z/I&hmfKZSo^G9M9.q5JI[5$
&bC:s:Y0MFDM1G?9n+Am`:"DCm/b!@RRGcgF>B]A8t:#?4F,'c'dJB"a]A(8Ig$&f:"?,_kJtc
pV.;Wf2`lpiR&VC:-o&0ijl5`&@t?f.*NP)_IIG_'TB((l4tg5<<8i_dk=%21d[[n5A@X$,&
@1$:O67-=otRmi%.u)%K1_Gf8F[h)NEM\p!SHap"<AVBYdQdA_XaTM#op-uP.6#+ABDc[Nk"
/h(pgS[MKJfE`&u"C24Z#di'J_?ZFP+jR+S#0ntJ3MbQV]A3`X5*.'8mJ$Cq,p0:cR<<k;00s
>i0udH.VlO2:aPPcq2-&-S-Xbl/t]AHC:#dM]Ah[*l53'RS;Ch%HdIn;eJS<k^*D6]AfjR(RQ]AC
'_P;,k'.lr]A)f1Ai1/J)':b+'JBe>Nh_"JT)'r_?=\`R>YtDKZJQ8qnW$*O,GP^`nHDqMS=A
SZ:RaejSmV#V1adVS;S+H4^=7*A;W&TT+t)lcrj:@hfg1`c"o;9,5:B?rTOPsLGd]AVWqFuR8
c'Hm&?ETX6O9nKp#9Doqc8AmZKY$^BZHsd)r!/@VRX7.8%0s7s+aNj\;PhS-?Dgo7U>@`>7O
stegMB9\',m3,0hj?Y&(=\_7$Cr0?iCAo8TccGNr@&d!/dN#@EAk+4b";FmbUYD19TTa`VN[
*`%tV\]AEsIdnP[85%')72KBA@;Tl_QZ8!f,#)^V(873pj.jWgMmc7NuBm2o:#N%<qes&G)*U
"n%,M(AGL!R5AG*ogI^&@$@N@"/Zjk%)]AOpgF%MI068%pZ,AE)O,qo&#mdN.Ej2^kS4V26=3
lJ=17c.!eBq5o$3IRKG^*aR83$LXuWa?T&E=SZujFZ^n2"rCPLLS6K9]A^7B+p!?U^__S?k';
sjP_g.UAH)CD+;p:F9\pBeA%Ob3eMo#6:HX+[i5:`VSi,*:)Nb_5il;n/P7\[CY'T6h17ESa
2G6`<UaL)7W+B]A;opLjg$G2?e2]AE&bj7L1+@UrjGDCT9+p<g4ZfR*np#b^d,//.A_2?eHcF,
3e;qCM5S=m3o-@jd8ZM:F_K/YFgK]AT<<L]Al)e=Vn3g3,1]A<Jp+'72eS1:a&<X#p/]AVp,SpY<
69u40[\f0.A#ZF5["aE!1,Dk9^_TIjVJ(KWC16F:PM!giCd3O!kS`'(h@]A/HD)u7W5+N,YnR
t6spC4&&i;h,oIB[GLHt$BSq.ab!Z?RdZX;q/Yj-8_._UeESg@2`(^_)Zu_"KI@k_KGbGuin
gkN?+)]AJl7u67brmp%P"Vu7qB')%P6lj>sC&J=dFSuJ+VL:FP`lKDZL;r(?-<SD6S[.ap:Q9
3fRsB]ALeY.[lGYSA^:*tl4s25(8BE-JXH0h@J;9SmUPs7B=*qs@:U+R`N^S:e'!^te#;+/#,
<6<QWc)4Ii;kdY(H!L>,V]A4f=.cRfrT7Z)%IF$G*[qrFhL]AeC869RMo7@q2Q4X;]AG=G\Hc'"
eo(@Vhe'X3?B=.QG/E2ffU.Y3_e'>D1c,F;d&Q[)s*U8rOVh\#i37TGi7Zf<!ZhS]A#UL]A@#^
E`G*(Q;Z$U`He2Qe:";Ugfb5K8Keg`%Rsi:gr1"dD\]Ap7o09!X05e?2T)Mh=YWNeJ,D%:g?K
a"m)"9u(2(App&\C%4C=<[eu<4dVa[9,*aj5=-e_X9DQpjG+Q9HhgGKbKLWF7WLFcoddQrrT
16ms`/hQ]AY.S`J'1MJ^B_hNKg:Lm@t'@oTI,7BIunA]AFR0691>A*$!llS30",,l,bhKreA-l
6))9nP51WLa.LoIoF^.*L>qcM+e?blPBa]A.08\R-\0Ypi2*%!-*+C^qNWsj3f>g9of^6Z1.;
a.<`fJtY,mVn-&LAr062UFteUFr5;V!O.Uc_"Hf\"4^XaGLkG?ep1$1M.bs#:B0DDbk`hV`8
LhEb"#;#@r@Pg"a,aY8CFJ`H^QI^Mc)pGa4Oc"YH$-k+s1:jV0.dA7jn!F[n5A[$Zr:RWQGk
G'>(fngc"Q$.4'^)u3VrFPT/"\/i(cU$`6#C3Ao?acN?]A?#W"ab4r7<c4'8kGm1mppS')C:d
1ojb=\!Gsj4I%P'f[S-:>@M[hp.PRr)#K(8pEP_<o/i/tPqeMma3;):-fJ`*Ua8Bir)YBI#$
KTOfTYOf@O<;VA.nA;51,\[6T2kt*0qK(`uF"0`kTf%`kF%iLX8!^`I)C%HYc8OG1d>O8G/\
IWk10a<uHm77Vd_9U6I6RW+0(@6,<4=NrhmN4WI!*W7R.GFBNlg$L0O3**6Sdt'2L6sbWcsi
XA'9-0NBAWo9b7CqXgFACrKs7m#E!5dIL$ADrRaHuJ]A>(gh410YOj<$4p*.!q:VBOr)tmK!B
-DUrJ?"<u`J5nVN)Zt^PC]AjR$F]A[HcOP'fT1?q&$%DemD'GpBDdRO'l_VEH,aadtRS]A_3D7&
^!Ha69$CXL;6@mT&C-PGoas%dr1H2uOe[*eV!&^Y=ZfJ<=*M%dZ]AbXet%.AglsV3'6$6o>@k
?Ei;,:P%kucaShHO"e5aEPc,n!m?$hWl8S+?IT:lIn`FlEnH$16JcBt8[;/[T^\%sT<=([\o
(CTh_?Iu1sHq4EGUDXrd5&K3bQk/6^n^E^Zgp'jV8=+cEYns:&]A5:h[__I4OQtPiZjg,d>3K
dkUmYE+I)0lq3e"FkcPb&H&$d/(75XUV]AY[a"UNQTiM/.O3"H7jUgkjN0VfEU,r--q?Up<M(
@e/(6#OY`8C22!gA^+>dHSY#N>B8riIP@DeRj(WpSY[o.-%Dj)E$Spr"cSr.=;K%#TN7;77!
!>as&Y\4hta/kB,XU:Q!Y3nSfJ++pc;*YX8O*]AKJIQY9^eh2]A+6NbTLXoNf;%E<E`G1$s^0d
o'J&/nt8mG)AYnrC`.PNN.Yr8!Yo%(:.T9hT6`P^AZWa+rFO#fo++3fhT*hG"2+A(JjX+ZGp
EiRn_tZac]Am3Q`HH&-90uH\I-q8=\IVp4RNjWt0AJ'^,LkM?CPu\?=P*D;'q24S>.@'sLI)\
TKrYY2X&1RoGF2."YelLX9EssO.iF&NfF2c;_`KsFR[LdZ^m*l6T_RiUFVr5>%En(p@YP1%g
TmX'@cS*))9Y$><%GdO<H&_>rK*:sF0C`=TWf?X!GfDf$Z>4qG%eC&&kT*Z"/SJg,PJAl.Ac
9>P`geBST63Q0KCZa5Qh&&:&a$qP=<+";!V!"?bJ=PA[%Gl1,?4s?Pa-9g:)$Ng+ACV/4]At[
3:#R8>Q(!U<4fL]AQqHRt=^[Sd=i8A(<#m%*fb(]Ao[M1)a=C%[q;IW=MT+r1rDrZHP4+7JcSm
EgKRO>o%n)YKYBe_YNg,-e[(d*ct;Z=1XpUG[!A(tt@+5u&D*6XtqhtXFOg!7<jIMLko+4J[
;6-t@"&c@^-,J0tbB5VkVf(mi$IDn(O.XiA!mSW5sC0H4>&T#4bf7oT>F\iluaQt>D:DN\rh
#4OEZtX]A*F9)/\5IGlm;-e%k.GlMf^V3+^;Hcm:[^#I30)m_b^dV=U8tbpJ7OGm]Ad/3dE(2G
%c5cu./coS!#:Ld2A^rN5:?$oH'qtDHuDEAOhALUe9L;Dq/EBS&JNk#5EOtLAMPl,HgJt&;_
)hI?A^l;#[(fVVq;]AHG#LXuu.h)uS+dSk_+gqYCCr+fr_:(fj5<\OY%KVCX:CDA3qP4]Al)=>
9m1li7,qP"*Pc9PADh(um/X^+QCL8]A5+?@D#\NKTG<a@Ue''7QKEmZ40<TSfM4FC`Dr=#5%f
BnC+PXc[Hmgnjd"8*4,hB:8YmHGU:uBM;_qt,cRcE152n5%,I&;7-/qZAER:c.(8[bTg$$)&
,n*tH5Tul$ch.HChtGf>-<lu-!D9@M^NKA0VQ?:h[KR$_?Y#PeUhOk=o%mH!6NXe%.&;t+fg
"FnYNEg#MU&>_nP"q%7k6uaP@`FkJ_%QkM)1_.^7?Prdj@H]AC_F@e"fpA-(=%6^q7Bgc?g_c
2YIU8hELIMVT8d:5II!9U)3D5I;1BD>8LpO8=;"Ng,eVIq)caBXY0a,6<2H]AJ,M'kB!"E9A]A
HDq`*m:G>GKf&TL@`Dj\/lPI_Kfm;N8P(?mp6LHjS9iaKFk02WO4,f!<Ul!;G8dn8Z=:8r.p
Tg02\@&PY)Q%fM;I1":"['R.<^ZfQ,h4%7P-M-`[gR"1'-XAfC@.eJ[amj-=\oJ;l"Yb&W'e
2/Z=PeLEi`hN)B,k):R+m]AHTICg+HOg,(MU9akHlfk5"r^q2#!]ANDa3,YaHguMlK35^#IN>#
&!FKYsR?B&'f4gRj:83*tbXJo3Jr@:CuLdU2O"Irh&>O^RXiNne=Cis_=;*)P&MeN0`;oHP!
B1Ubk@pEudlW^[V;(WAUg+lLm1JpGj>'_mOL#*=^%P)d<(gCX@]A<r?OdSD7D.#$-QdFOrA4O
ScuEDR/7^U2U.(M+OI#QjV5bZ4THODBc5p<qKjR366X:#Kj6)^VR"o!k:"2D&<;=AIVI/J#d
ASS>:-HQCqfK^;`9&2Jl$D?KEZVX>`O;gfV[W$?R2`f"=0V+N0!#D;N1qP=WZb9R=icbl1)G
VJ4II?QK)O4N;91fdl7Jr:m>F)4Zir',$e-Ca+uXaXhQCD:d`?LZa"YWnXr@'@"P"1oQj09L
F(L>Fb9^#E%hhOl4YYpX4^)qEU*:=%^eH4_"'c5YZiGTunZPI8o:+8%e\l=\.V&#+bb]A+A2l
&]A\LtJohQ6)Z6Q#SM(<BGUNaVpi7K#i.:&apClkf[(;c3H$C\+Zc@m/F%#k@]AY2UsFSP*!VR
Hr^h[U.86TsSQ"NghVLHSlac6NJarNfKDp/48\Qa=UFhP@<]AF?/H>^&K/S+@+i!RYB1!/[)`
c<rcT'=c:j*]A'q18k*VngEq+f&[[8D:7X8,c#Bs3<?UQe/GMWjLXr#+4[!hO^9V8U&b80N_M
C%#^Ep4+QZo@O>-7bC"+k_U8bB@==WZQ6W`-",,Q8<K4;9T,jp8j4'HP#Ik'TR\R4gAeW<HO
,uK\uBU[0I#j*[B%0-[d%m((IS^(HDIE?%u0@1^'eK7O"nV<;<oda&D#7RL=K4l=@U7[[p9g
@0,]Aa,M*JJ9ME0L!8=kP`0TkQ:dDfo\\bN"Q1FPi0t$!)j'mre3YfmX;'9$i&;0gR_m:`PFT
#e!**_A8MMir<A(i+6<;UV]ASWh?r[Z!UUP3fPaaA*gJ+?Gb\O$RgG@+mO@)(C45&Bg$9=&Qh
RPLsOSB<9=3f<*`%Qu$Z.#VXi!</>1pG39s=TIkeb&-6N8:=7b2q)ASL9MO)TX=0dHKg>%VA
Z0e@^s<n_prUPm5Iu-u5^b""F(p0"FU63+e\_Ol0Eu?+5Bat:!k4pHf>fPODa1M9I0=B`5,a
G_hlDV$n(5@p%mJ"%pHQHFR^FiC7P-/`,_oT'"?gI1\[E-[$_LnSQ/h'hBfMQ*#smT>J%.sn
_1<Gm6\6+h8%"(=>T;1NBF_M-QH0u-NE>4;Tf(3iR`)5hek\m:2hWh7Am'ZXqt7n[l4@HH?r
_(.L^kG!;><DP-OiC7i[79ja?7"3?Z\m'8We<pS3D(X8,-i]A%/"'pB?HIL#RX*lA8"/-/`4j
ScBogs5'T!@lGjLh,`kr1JAq,'A&7L`R/Z2n9Ui[$F/SE`Buh%4Fs&#H0Lb$<E2_A0ZY-G&<
ZKKWe1h1d;ERubd%Ggh`f+.hOW:F+Wurdb5nQPOPK'a;l'hIRn7e@X/<;tJ:f0W\`g[c6S3?
fdF_c]AJW?*Q6M8b<]A\'1&Q/PCbrGeo0Z(0RG;:*cu<T?.5G&TDk&_h_a&kX(_[9]A42p_+J)[
-h!]A.2Kh2HERlD$8E,iZl2/48\3rS&LrQT;jL@R&`6>8<-"+'Tc^!fKb0Lrh;NVcenhD@I53
h+T)*>="L0<Vt!r,3A7fp,MZf"Y)*:ELJ0OaT'<0g)jH<Mn52LJ8mjO!W5Y^&.OL?$=2B]A5O
UO`kBED]A=ITShXp53Yl%=47fE^m96C)ZXjJ(i^<j<BK/lYZ#%N_!`Kc9[T'5/!,9772oW:T]A
)W?`'HoBo;u1q]A7D+cD.#+Lu(o1M+a:Uk8&[@Zsld+MJ?%WuL,8S@X*DRW)J-lA;Lle4(X$I
RWA3-?1DiuHLMpc?c0jLJ1`ZZ<0HgTL3SrOls&#XYY-GTDHXU8I"(M>YsN!*Y\o#,G^TUe2k
%rGOJ&g2i@_p$0%Q_cfC;>A^uUIQ@J/@6?L2/gl!(d!6BQ22-7c5=[DKNY<i`/n[In.gOTJ8
7"l$.qXsa.WF\p_]A`\9*/9TkmXaR=TlH1BM'EDh)FL/):B8e>B_E;p'$Hs^-fYD743\<SNgD
1c\=)Bf8S%;Pr]AbS%[qp"B<P-4<mK$b<K!h-$m8:b]A8P$thP>3IgkH_--]AjmpdsWNuii8<,n
7gJl*SPY1D&9dD:@N.b"E3SgSBQPoala6S`C+HU<!I/qZ(DS;AFmsT@`HnLFT9b$Y\MM0e$s
Ln!<*\NZ;b?2QJDhB:Z91$k7f1+iT"%,:)0ORO*R78Z9Uc2=VDlij-^g#X1PiIPHE/c]A<`UZ
cJVL4`/B3S\pr]A]AY:B;S,;5Y'_:pneH-2P7EKuiG$H^5rDUd!`B[nqo=$;k9C%sLgZ$]Ah;#C
eWJn'90jHi\ghpKqoK$U*:[o1CQ-E;(Y"d/S<-]AHDKV]A=4EkrnXJ#G[,j\L[Uu2#JM1F)nEn
VJP?8Jnj?&EP()[B?rK1@q9K&1H,WuGk=Yk7[R.]A*Ia/U@>%QYCik'+7e?7`KWo^bEX#GKBh
?ld/h/Ulb$0US8i3K[F/eCrC:B5RC#&QSF_"emD"E9=-e]A/7+DBoHNXG[2Lf>18Oe\Z3e/K`
KXqY*58^c&`(I4U7g^dbDU=<[j6EjD.CA40X_rIQb^Ag"Tf17WtZiL8[6VcZ_S`3t7b9FEgM
2h?<D,E/!J!,jA0O^\W)j,s<//KU&*E&1$81GN9Y?r:2-,S"]AC8p5=_k#%kb<6Eq10aJg0-p
i,mLV5qO.\:@n/'#S5PAe4l8rS\QY6d_ngsLB?[$2NYYX,TTfJI_F_:hnE$",U"IB<eHAo8s
9\e:L`SOVRR/HM(SF(]Ao^7dcDo&PSh.>`=7''gYOSp^@ikNIi[c0kU(B8`R'lnQu(:"tX)fP
lPkQZ;\f]AZ"=[TdT2>h;^ArDcEj*+gIbkb*>?J1ih5Gnd"sQe'?>!Zk<Esa#fbpoC6u=9Nu6
!KSe[J6OT=7k0bfU0U9S+_pH02/k9KN\>HB0WBD5gkpP>fcfN97>J5%7O+^/Cf[Vn1C,<f.#
+!/p3!0C5b8k`*1CAePkf`@!p]APs_JF[$:"K/uS;k*C_Se$n;`_]Ah3N#'uoDlp(dPn2Xk7JJ
ft2?.Jg+"<J';(t<1VY$ZX7qtH_?$:/CN4lKe)Z0aT1[`u,:<]A:3,h/b9ChfMP]AqCSRAZoV^
N)Z"pmAkq5KIJ#`lYT%jUcH>leM*3IqncLm#Onr_7SiK.Q?gYaa2q6_>&cG;)=K-T\7E`TYU
Ip@,:[Q/"5*>VKdg<Tl'aHeNhlJ[5`6ehfH_H"9]ATeugRmpt79"%tODHR1dP0%+8K+pkdP:j
2A3]A=0Ver8]A'YSj,;2W91^!Xo:YeCR2$h'C?UQ*I$=M9P"$\/9!@HMAiX]A1k[\[npQ*^?CtL
N/s++^A2[6IY7jd^p0Iag9umYoWM<Tm`h*2fKii_K/9rb1WV;VoP?"^cm>&?q0UWg3._uPB5
IS83W[i[$L1)jdG,b\*:HaTFr0>fhB<YWLR6M/=au<i=0GiA)lHG;6#fI"!F(CO=Yi.9IX"J
DV/NOjLhTfG;'ujFc+5)OC_4I8nu+^X.9OZbTJW"lkOA:U@0'ZmkFFnU'ue4C^"UD'+Eh(mg
1(i74"i"\N0!C&rBm714:@eRScLd:+9_LQj3i32DtFA6Hr>22[r.@']A)%!`=+%kE8OX3p^&s
]A7Yk`@[As0G'bcY&5na^rck0-ptf9&K#`tqlm"*&;[=['$ni,L3<fKNs!$F7\e3-!pd"]AAfp
+1<4=Rif.Zr\s')h3in"C?L.-nC'*H-:```S;7R]Ak),)?3B.efAJLB0$;s7,83ZiD3AK:r4q
[hf$P`gp#*ELS>)$^NrH]AE*5P?=KO.lQ2ZN2t"`b#E5S**9?YuINE$$NSL"]A%j]Aj>D;:qL97
0^r8"AGR@]AhN(8dA@=LTV%^krGBr?]Aqiol=?N_[)^[k;RLF2H2UcF?ou)4,(NaOP5Tk2qJ@2
&pS(j>[GJ[mS*d%_Z3g#N)SA^$jRi[LX3jq[a-lX\Ge^J44IKM11]A[jX^h?8cj`>W5s"NQPS
QJRhqI&Ad+q#da9ns(G:iAE+*Q7b(Ef$"8HN<a.0ON:oM)sp[X(,:BaUdLu6`84N/M(RBbA`
mscZl$R4]As6jB7f5Hc-@S=,@b70`HS6r7gu^DeVO=+g^Pim>M?S2IOKHgCH[<oDt+M?\\^3h
ta1q4uuhF]A#D#r6kggW#<FHn82CTE.rc7</V`RAm)Lu49$fcrIDVoC;jM:ioAG=/XD?B\M+(
_6M?+j&gK/q8!$)JN//IU7g_\QRIKe6!["UV@LXc"k+70ZX;p-&1J\I%BUaYbSr)[XVDBmED
V$qAfL0A0X?.)*M^2]ABTpXJJ1+sLl&,$@N"rojN's1ZY_jM711lK>H?S779/'lb(6$g86_k&
)degQj0/HOUjAWl'fb;8[?%YIk-M)ib)ZSqC?A7KFC#>UW*(a&jK/Ru+LQ:EV@!Gnj#Ma`Wn
ofEiY9.)&C(h6%]A`MaA)n/4[+UP@+SeW6J[I>s@V^ZL_V=VY.NV_!K+p;,tOF"mQ.Ok+)bPN
:7UR*#7s;0SKV)//)uJS#?HY[cuZ'Tp5HH!,mR0?_K$g&J-5VZO&n=7F',2b.>bocgVfa`^W
aM?URAM4s/.e)7Vr#^\q!5;&s#:L?##9gi`_Tq$hT7JGgWEpbQRfY7#<7FFWShr3WU]AC>9\3
V`qS*Pt1TdJa[Y2DN2u3tlna:WjE_/ImHINZYl&d5uoJ@iQCG#Uc9J.eSkHg'm,SCa,DqX\#
O&:@&Ho1oA!0%7NZe/tX]AoXIp2uO'`//(LME6G<oipV`=8575<r*0o5XObI8]AU0S:29Ztg>8
\MI<MA(QMk2EHhtS,q@q%W#IRZZ,d%6Td"uTuQsMi'C%cgSX;(1MmNJ3fcP0DGrN1l^^6]ArH
h6_R>N%G;pct2#4aOi;W'I"!3CuP@4<i_'*Uag3kkI5dRBX]AATr_nh$@cU)#F4GD#O>92Lg4
<m.(^)pL2+N?hi-C/[THfL0q2rr[tQnOTJSkDS95Oi5"3MI*@gN257O):;E&1bGH3iMf4l=O
[Bltl\jrCJF2]Ak]A:?.2'QqSgflXq9[/VGT>^VRTkF^e]A:Cki%H8pJ#7h2Q#dZYEZY]AWlIT74
7m#D2kOd)8'aiPF2,r6'AMQ0>aFr35Dk]AZIUq4l[.$YnPgI@D9MW@s`%.!B+MC/MB']AX&TGh
ON@UMm*%X-lojG\i)H^L\R.@?oIQ:Z>0#B1)$S+)(2q17A_XG2nHLOO\rkif-32jqkPGuq00
R1Q(M2_hPK/a>KL;l%e9;>R+plm[s47=A*3h401\'`8Z&XdZ,V?7$(ZDMl>lmq.0t$>6E.@:
\*)'&FSu1mpg8-eN1h_nR[2a1uXs7hHgo]AUg>6JWkCV&NBa0%C/b6d?I':YccS>kb+'*N?rL
rg\:TFMIHcbN8N,e&8*':V2`#g8(,I9"<"$Y)714(RNVJ;HP9.$^3%OC_M?[GH?-%%@e*Lu@
V&3!;'l@jFWf"#rg#61;q;=L3?($<:0k?=&cRQCFZ8ho0&M]A,8ab1Mtij!"S]A#;4jTCArY4m
D9<X\gj59Fl4g[F4@e/4fY-Z7G5Q<2YGoOmLL\?-VJBfP"1(A#0rMCC:Z,')V.1]AhqU@[".N
(9\+Z[/ZP%\l:Vtn'D2^W'6"R>7hL<*b"VTb9Iq;NL<GpN!,9JaCd`tb-_-gS[-&d'mf7`(F
Ld_dN%V^1((BKR\@p1P#[NR,MA$_"Y;UPVW)0/dLn+:q6d#*9K+jQ3nsp#G;h`(8"s)E/)FM
<!2=$`of8K#UL[G_nP(P^3@H$g+W?:^_fCCH*6B##R4Tk=eX$@O:J-.q!FUZN`=_8LcmT9*H
J.^7abaIT$QKA%@e8+:"ZNQ$\_7@Kb&GfcK%s+(ZWsYIK#Z2;M1B3L=^1C)XWOUNr&B2"h2E
Zc:tB9\Efu"IaUhUK'*).*a:Y=n.<'Eu\@BMa9aU(Gf:VV=H[L<'52U,4.3nZ.Ib_'*n6d'R
djL"ON(*<K:Nk^bU5g>WQI*>j=_>UY*[eFW*0[S<*J[q'nU4$5V9g]A.jnG#h7L3WX*.2N8d]A
Z@b^rm.?#!q?n47?41>QBlE?lpYu-Q73-F4%O7kpBZfiI).;50q_,pmb\`1g7CbcqCh`6&W-
9AO"6B"*_Q_[EJZ:"_0nlVbd=s6A(6R>I^5B_jZ,+3>'UNMJ3A>HJATIqEEI/m_c\msU0/]A=
;'o3r\b)(HEk]Acb,J[Gs*`NgbUITO`/f)8n%n%K''a-4Xj.*ZG2>TD$rcDAUK<I.32_e9<V]A
9O,T!!OL_C6Fp5_KQ!FHpl_CaX.'[tFCIZU.;7BoJUfN`>;u$6.H%L0'i0+Ub-]Ag3r>,eZo#
VYViTq+Oc8Z`+`inRiqskA6EF6;;nkp^)o>f:LV1g8O\m!=9]A3'2alR#3uFoPamf[ugfc_E&
SPNl:Se$F<(p?]A;LA7A$2A1JVMrBea!!<RZ?d+F&fZ!J4l`K-aDFrYP/7[#Eb5[()3-l@k2X
Uj/pp@Pa:91"1RHh%5bZ"<pi?+p'$--L2=IT[hGGQXF=ZA?h.CZ6+`p9!@onbdfA+j25!ZRS
PTapk\b`t+*5mb=?_;"%/nU-10OB)s?KK#;Da:#bm@ksPQ!"p00MdEsJ$ZTPu4M>oeYD]A'Qs
Z?1s&I;@\emku'%9P.lL>I#h:6^sL3R@2aamC'X]Alo*&2bfjlr[[<o.r?<F]A<_73'SaYFG1K
s+GP,_,SkN'aD*BQ#c#MkG#e>h4BF_e?RZc7F@rQ!<A5CCj\/&8"Q%oDiolG@9<BjMJW[\BH
dq;&3)c"W+9gVDqO26QpjDbK/7'Ys8-*/:i,X2NQaR7XWtG_j:\CN6M&)k8Hb*LH^TiLVEJR
S+cp]AD1E_HQ\oGoTeIa%mG5?+oliO\64uFN<&FY!1Q&&(FRd7N.C:W(S(HT"fDXaikI"(5JJ
k+mGEDO9uQ62&3-h2ef)2p@*Qk;:QQnF2aT@a8SW9hINGe.nUJhZ_h+L^UIL_,GXhJE]A9,2?
Fq;F[h'9/ka:+m-h')Y^[,.)pf4DGiMi>pMqGhA;"'[lM>\h42/IE4b[DDD.LZB>P,")nAEc
ljA9mSEmA<2T-e0=h6?F\Z4_R5f"q,k)t=.-FDH;294gE1G'oFm\/;^J;J3j:'1:"kCj#B"&
?c>.)*2\KHXfiP6$)8#mXLr0I8&:7N=dK(rY<AG<lHHj@F]A5NZl%LXjF1HMuc7uOH'JQQENL
tse%n9bW_0S>D=(t<aA@`([NVdq:\HZ^IK'namYk$Z8\$,e*daTce+p=&!f&LZP)i.+W*[X1
L7Lt^LhE'9EdUaj?T[2s2KdWksXh!;eG1Sa16oY_MV&2"^UI5[Pr2DuTb0UtB_GNQo[!#ojf
Rj8p_kh(&8!IeMsLN'=s[TtUGWtJ^Hg/U^uAs"&gQ_%_G"`2V^N6[n5MZ/#OciS#1+l%t:)P
Kj(:m<OP:;@VgC*r;LQL^(`J;Y1N.j*7FJSsi\0]AM<nl_A@"7e5C%m7Q3-+hl"=,F(m1V_R9
r[Z9GImNAaG:58U#NZPn\O7A!Cd650/n%D9sBJSD5=9>$QCfl,,OM+PK/mOL009&2u8572ro
>\\dQnnh_f5_kPaX6'&Qc=V5*lEh'>f<,`fokRW<O.b:?!Y2:9T4FQ\fE*PbeV4)0B1d/Atj
$u,f""D"DkAn$B\i!?6p*\m]Agkp+u"B?)WUf2"ZAmF!C4dfNZGi/XD'=[q6^jc)%P,BGuU^-
^P("0k$Z4$T<Re1gGj3F.BZs&,DG\i00dDNF8+ng-'$B!g:$)OVG:Ab%bo<%PLQ<`5R#dE/=
*%1\huP/al?og#(6H3Z3[.NGA,ks/7.g-Z.`XMfOd6L2'#G"dSK"#LXm-dU@BKX*;;!%-?FM
3\fCjN>^4T:'pgT/+XT3GKF+"HnofXead2/>FZBs#]A0kb/PO@O4S2u*$a,aQ)hldVJ]A87c>:
:G/PJm+GNUU5Li<%cW0-Or@@`S\<laGqNpbX8/hJRm87U2'La`5WEDI)nEj+R@D.>DClk&lG
Q1&%YgoC!8TSdY6gt#Los5M6=6LC/sLHM.97iHfMq*[FTKb$(L.(F-iUkf:b0On,h8aZN*jG
Q5OUJAYD]AF0QG=h@I;j!']A-Mp2cB\IOe%\.kF"d)3CaFjP<Tdip%$q58]Afu5I'5PgP(2W=>"
<Y83j";o3ksh@g2Sr1G8M[<V]AFJ"V9^3@p8pg4rF&-cH<<:ZZdRd-o=KD/.9sTf6dA,1&Nk"
ZO6FgZU;6K1L8=h^Y\>t0Y"pS+oM20CR.]A_q/8LJGL59nQhnDAHc9H8%158&r$LS*t^]AU47G
iBKj(TtT!;)44SKCG[i^H1TQLTUZf?,@C:?+k3pQ,'Mt(Ts(nOQ04FhJ71tj7INuCd/J@.om
)5IeX\nI-6>4Y'sKnaWjr&"DXH,QQn@T((6&+k(rA#Si%%hp,jV_-Xl#'aXH&X1eP6"`Ma6J
YkuR"Cu%;[)>Q5UVL=\t-lo>bf78j?AtG,+c+nL]AfNJ`HTdh#0*#C7jGI6,OU:kB]A@Fo@5N-
&gci$MjTbu71ZDeX5t^[`F)Y.[;.$3]ADk]A\%He't&ZL_$s8<68S2:g<`53n'NFb%""g+bttA
Z4dL"U9T-Pt@U?.I0QlAa6bLs(eB`F(ghsd#(,JdI)nh2hH6,8"im$Kl,U_Y_b1J;a7%,@QZ
TY=SCF^QqUr5)8]AMHSGO.!Lt4VbrNX%u26)Bm%4/mZ%5P>2iZRmi'gV0P$DKJUd'\7MJj:n9
khRok=kJO!aVB>]Af\0kiH"2dpNG:A6t'^_YkY'^eD?c1hdje?c2,6!@@W>)a)4iI.QU1H$)c
"p$V_2n.KK*5KReCR2>U<KN_DNY-%I11PV*+os3\rJH`Tk@#\TlcG>+@Hs(gQoo@K-BDMf.H
<?rd[7G\)HIHN>)L^[f:ZaO?3kLg.L#Jr#pu?:PO<^nC'Qa5=dafbf-O1&asrZl8\i]ACQpG5
I3)YSH%9fNQjYd_a/f2r&&j:VJRptd-I0)a@7qFDcL9/N(8l*W#>g-%8oUAG.@Ja(=aTquC@
f+5qN1X_sZ26'4D<D2gqm\ORY[8A)[cc^R!>2#2M%rJnYg#OaY3mO5e#?&1J^';k"?_)(N91
u#>r<872KRTP^BHNR+b\'BVfcd^6D[TIKK8n>2j8975lZ/9B=E'/n#0Hg4^t/_,<DnZ!R3=O
ULI`h32S&Xe)"X5qhp9uaJ&3en2<Z+-WSk\UlKEX^r>:AeZ@I:(XG<9_M82$Ch83f@,IR1Gk
jH*(XBb5q9s8%jl-Ne2LP?\%?H<B`UA:J!7?uMMC<IZ:7o*B9UV(m12*25&"8)8hqH#mS"Of
T:2h`/.P`$#.CDV;$EZ`KW-7j2_Y._DU%ade,R1t\RATV&7iLP[-l:52jb$dseBoXAB[<ACZ
S8fh!nj9Qa&]A$a45@OB%Vo,5JZ!9(1lUWc%`)Z)X[^SCXiYTL>qfmC#0`UKKcGt%QoFUqEY`
h-e["#@I.8psF#pSMI%r-l8K=E7*tn,Ako1Nc'fk7B/j%jhQgGq3fE.msBs%8%P7r%=6J6+E
.Ao<^5D/<:]A(G+EH,t>Gc^uIUnqWC.;c/B31Y*2kf9'U>I_DU%i>pP<V+<P.2gi8/_sM52;H
N'_X;489>64m?EV]AMg!k.qLG/0g\$uB)e5m*Tt45iC0D!]AC-Eh(gWUeO6cJTG@iH[kmJbTd@
4Z9p"0/lr-6]Ah@C>=!1gp"QH890A_rcVo'#u9+Z.hJ:$8gJ4HcVGj%VPM`5McY[&WrG,(ipX
qc/uj^PC&8<;q`+NF,'8XuO8=E,/D.o?B&$.u\6kC]ATW"0f$6)3G?85A"A5:BJ%R;`=1RZ3\
scO_rE0RQ1]A-pk7*lpLD:E%VRr1.TRVVJN_W*i:fS`OATsa(`R,W=f&q+lg"IqJ&g4Je+aq5
SQU[&J3SLD-SMNlA@.U.MBaJ>bXhUh)>)VCbj$^S"CRNr0Q\(UAngf+i;Qq3Rf<U./_G_l='
eJ`0@pYQN8<*V_'Bqab;VredS1&'g="@L<Qaj+M*ltPZ*]AU&aiHsbCMQAS(.j7*Sp3^_!k._
81Oe[E#p.&paTH@:=jo8I`n9G;$nuVn+7Li<KFCZre?#AE-niX-W53cYZiJ(d_t*D:KMk+p"
Q4K_8Z3A'<3%$G$k-/f5lC->7g/XA9B&K5:^gC.fkCGJb+-Z$cVij+G"A,ffIp:<D[s%sS[l
l;Hl0st<XBH0(2m6>*<Z2a&Vf?-)MX+/QQ'EAURb/2iIIkR^jC-J1iFZZ<Pg:ZBgZfLB;BQ@
NuToeH.!=]A<T>m`ElemR+Y>\rWCcpF*2FtFin8qm["o_KRArGg@3TWecdT.B(t]A='8&\ACiV
n6mnk.$&HcI8E^B+8R;#7E'R9p'kGd3&WYq5>tHC`]Ad>9#a3XOaR8+9oeaT]ART1*)TEn\Lo?
R9k&j>0ka/MU)>\o$,hdR\Al5(Bo.r$rk5or$a9eZa!b?eD2ND4T91jR6U9@+6Ed-jaLR+6c
#";tn:kVc<i.fB\bpO?ecSl&+!n<k>W4Wlc3EC3M9j1_>%^:pI*RjNoY!=>`LHV"3ToSV8rS
#&MJY%je.Q4lT<N_-cZ"*/"^g_;!ouoBgc>$kL`ErJh\_3%E(L1*DRF<7$d"5cW\osm,]Ad&S
Yq6Srj(J`h/`tC9%bDeYD>Uf\hAu@4^o(]A463;em^YtMRnPW`6NY.&a\,Um`V.n2#\qVCe\g
K[k2G7*YG"d/LZX(c2!a:f-X[T"`+Xm$nX[`H$5d/b;5Yc.KO@YThePJ)3/!Op>^W4E*fq;G
H+>Di``f.,a3@uV8Go"J-YtZ4pKF]ACdBrF@\22Qb;]A)IFdlkR,3od$kbj-m<mf_Q/`2+*Y7h
6DCo2.B;cZ"2fgCg=SZQrh0%9[TkG[q6!XmQW-/9//?T[n[ZjgI4Yc_)gP'%b``]A8^:?]Afq5
EJYrP^F9WIHs%c`&K_/'lA[r`3h;!j*u/e$E&$S.DJGKuer>9s_lhUTTDiU[MV<B19]A((N\Z
]AX-#aW(#;MMS]A8R8oHWe\TmNS>edI<+A;<nf(#'NgC<?'m\i9kMBMpHJW3DYQSm6N@VcF-F3
)hl>[6T[9=R-*%$"AhM[(EUnBAin+'lSMJO&NaZ*<sT54j1%JQi+\'$*54f,qR"i%_qEKUCJ
!2_SWW]A[,`#)['hUMn@t(rI0:tmMpf4l0hns]AU0':'JG$.5CA5,oGPhWr33/3)Z_jt/XtZE#
J%9:Bm,q^8Kgo'6G!*t4qp,qS".[3RrK9pgn'P&V`J>ZeSa#_TdP")+0L.=p5+`8Y(X[YIoE
#B!D!<_o?^2A%HW_Sa5B7Id>*7SCf#3DTUm$\2AJ<8RQ7K0@WO#0g[(q_$o8<()EW-_6\Vh*
a`p3]A_n&!u3b]AUL=7%>W:;OY=d&kJ*nrU9k@')ldm^(9Rb=i<bYRE=cr.5g8f&Of2j(X(bcm
4N;M^F'qE8P@2(Y-DRN@&Saemh-1d*K*'VG>bdHTPKM@Q07pgf[kCF^Na$W)^6`R\ZI(P-=S
0?G+?La^Xr%iPl%pOeQcn6rm#O9+-PR"o"JF4ilD0$^NC".]AgX^N-EaJKCJ#?Q>2r4%3p^LF
6aMpW14U5ru=B')[W`oP_c,Nh<86j<f9R5\(FZi0f.:5feYS)]Am,21>LtK;jLk`0cc%6^7Z8
6X+^F\4ZUgHP=<^nMf<=(p@=<c`j@n@>q%h9uVrQ0W:O)Gd]A\Fk@GkUc^*7(7*Ph%9Z*mif*
52cC/,^fT!7^JJujGc)F@#6"6l_r+XU@'Nf2[1Q4[Rt(H4c@@:6:c?Rrb1&0,[.SsJ/0a6e)
MRXC,H.=Rghg0(*cYNC0)"(p*@FY]Aje/^=4P#UJWF8,$uG"h$a@#MUY(SE)gu)"-G:_taGb!
)c:`EP4C(oY\2LLSIk)N6o-Qp8=[\8S!@]Ab6;8[#c20Z(D`Rf[cjoDhGB<InD.A^4b`O:[@r
9VKV1I`Bg+-i#tGaoj?I#$jD#GP)J-kY*D?u$V,S"-tkBf`eEj*$*2G=$!,O,+53M28aV7F4
$0UCkcH3(/H16:?62D,EICVrr#HGag*c&*uDukU`>iK<lc45b%)llIP0VW!3>L'9imAp[<E[
Unhfp7?@URV@i+EC54$hYK1s:qNQmm,F=3bb"&Z''-)(L_iW)?7LY\On!T#VDmIcZ!5Xl=gS
9!L1l<-.i<,DZMd/X[_IAHAYnZ4f/B=.:bNS[H(e_USlEc;^Y6/''1Lb;T$.p:i_O/;M[>?`
$)Fk=%P)RNu>2f2"=#b[$2VgS%jlVph@m<:q&!Yed8nC'DO"D0dg#]Ae/D?9D">o"JGpdiW;4
^D8T$l^tT8=m+*&WQo_hn>PM/@eR3AUtLt4H"uY"5FIJ7PBpQ=4KRe,l;Z/T>&:d':87Y_/k
aJ&jg*V]Aa]A*08hmd-doV`s'2@f#/rdgiA%c')/eTMaqbKriMLSQq^,&a^3t##L$l@4EQVn"D
Zdr9A;C3Y]A:g1X+rrB8<nB!E]A8i'3WcEUu2#$sM__MXU<d3&ctK.>iB>7_G&"-HR2'8a]A`O[
tNT8pK>9!SeW'Dm,#.]AdW-'k6,sU]AQ!DX4^r5Ol$[bKGi3abGMFb3VS\GuEYj4%W[&qti!pP
RM1*@#@uls0(7/td`n$C0ooB5JW<@$OaL$C_(9t&Ro*]Aq&h8@.Sdl@A>)\1_3Lcl9G@GSn?=
F7S=[bPPI4ZBu]Aa2u0=0\q8IJ^(&/)ubSs'kV37)'&!HbsH"ArO2A)!?6=BSrG"cFQ&aQe1.
I3W>kIIh0GhoX&TLG/]AME$Wg-fIj&$W/JISi4h(IKoq$'!nb`[B/rp9;n%cPrr4C#Sl)Z=tX
6`]A?:#lN96_eTol4Nk[+7GCWs\=$mI9qAdpRV`i$B+$"W:<Z0$c;R.=b)7$IkLS+%pZ<jY^&
<hIbR62q#oGOA%=.Lr,kOsA6>&(El*u6?%2o-]AG]A<C/NlF;8)h#/UB+si8)iO9Cc)S)cFU)>
Uqp1R7GDYBT2NI2Km*X"_!QIo;+oU*b$S9;lb8(2V;Z8ZjGoidaQ"[?&[LEGN.UZ2[GP-CN%
<CSKCCURE`"3<5;lr`6eNR6s]Aeq)<A2_"#==(U=J*mXPl9ADa;#9pVMnsh-?r6=2A;oa9]A7>
oe(u0V$*(.ik*8G`R#5"L?<D.g1AhpWdW'N78NMNej@AIoF/4P[S*XaE(fQVrb>9!@I1e*R.
9?`m3%nD]A;_pRMrkdZ3XVm#'tWTuNer!q`Hn"SQtZXaTqV-"/WY1cOg<FnUVco?6t0X=A.M-
W$!)2\E'CV3a"OarGcfUBePPB$[6>OUEgO[(3aUl%,oc.S:"efI;W$F0*nimp260m3%raaR1
-\LNNV!Gi6_5-(\VUn=FP(D%Q_?P4-eM.LQ'H&n^ActRmoZM1FE)HLR,qWG#>=LmWLap3&'L
>=PhVj)_90YtGLc`hWN.I>i<!kWWG_<-_)7?<V.]A;eltJ3>usA&f[(M1H_gM;tLi8L2cpA>r
BaherS)_>P0@%9nP7D(oP<B$?mTQ^j)5Zt>auW0,bSf1r)S:=YXAIJ['_,Wg,Bp<s/5SOA.A
Ce-CC*5#`+s&c*s,qn#3F/LYL`cY:;hC,6?]AK@C7G&Zg;9mCn1'i,pJLd'qL8#bSEUsgRgre
[/=1c!ji&72uPA<BnDh&OJqn#132iM7`JA7-?+Heu01FhiuPYHVZk3V[oRUJ,&Gba>mV@<EF
>@L:]A@iUhu)(d)2tZ4VQEGkrP@ec7^_!Hk1oaQ!"[(Rg++6UK'LaWS,Sq,6L_FMTjI>3?@sm
E)WEHMOg*RO4fo17'm=5'R[1g'u#cM9@/k=,!Y_aBY-tcDo9tC[TESiZrNsc,cT9Yt<h5MZP
;5[\#b9;=`Jq"Cg=,2IMA4GtBFTidJ=a?^(IrPskTIb75bt=K]AMSe83+UJIVVtYS@@$"u]AKg
Z5T5,Al`&1H&&2DgMs!0B:KD`Nu((snCBGsa_h,M/aeUoia)uE#e]A$*GiF]A5!Ln`hrU?h?04
'q9+U7+^LCA(m^3^!5G6nZqghtL-bh=Z]AaDlsqBpRKLTd5X4GJQ2HP$%)I"+KXY_"Jb?e*l>
EL\&%Kp*=O*3/Ymtp>FT0NVNJ7%'1`D=r-!:X3Yq,ZEpf<Im"-CDDfAXRr,G/<.C^5Y/=^E&
JYZml]AM,Z8M0m>Us6NUNI9r+Z0g;+P/gX*'KsU*C*A;$=oj8hGYR_q7^@m=T$;juS3S8emPN
QIEto<!K@7Rjf_3??R:NB*k<kj\jO45n[p>0`[uVX%dD#!U!l0,<CYViTKl#s5HrVMl.0=p,
Bu9foCb%_';^j,j>A,aoJD9hW+rFO`<!W'lEB4tkknl6b+pJRJNJMoZa\XJ7>V9%u21-hjpr
OB*B-IQPSUb$0B>DtZ>`qTL"i_+X4Z)0hOOc*dMsA>oi\hXl":st95j)$P_FV(L[`1N-41E!
PP!W%r@a1+UU@^:Q@I"('$i.@GCN52Sm'55ST2Ne@ED`Ys7r.-Qr%.uY\d79n7b8Q'o.illA
W'_/J@"2YK*'p@h4-=)ECXJnouJqL7@A\'..,?-%P8:Pe!rTTNfGFlnV`[a9DQT#>Tg^50FY
(Pp;6"e5]AZuBmujqR6Pg]Aph8(X"^uo7_V.BuM?O(g6V=/)UKDQ`6,L_YmcCE(ea]AS%pSP.;j
!b4^'PKZrY]A)Hhfp<-bFb8i%?W?g8DN3gt(7AW/_UT"='f&O\^[>5bI8N4<^\sr$<?DPET[>
'A08d@8lmorP\?_7YgdWm5FoU1G$#>Ro-SB>6hTh);_rmu:3ps;GbWjTnZKqVDtBUh;2e(?<
s[M2Tq]AP?Q'']A9@\SS>pZ1G;V!<*K[\2eptM+$O4+PTlT':X@1\n_g-K$f8TGJEurPV-pcUo
o;pHSjgkql`)qhghb9/1!'tsLC<*_ZYUI>DukMlX@*rOSUQJUccoA.(?3pS#PL?CF5Oaq!eC
IT;os"+,NVV\DOnd?nM(iL%i[VET+eQq4%s`lo#*h&E6Cl"-?c<L9\\.Z3-]AGVC(,E4Ru`4!
XqE8"6@a:qnV=7lrnn63jPMWMfF\2Ghp.o"3Ja2A;lNH3S2tiNYtrO$\qCSh@,o\+CR8ClF1
N)=5L^fVeO_%6=@UWgXV!%KBn^>(?=VNCh#p@CV=i(/(!"_&lZDA=f=pocM*._Q;QGH]AeUF]A
bO3>X#j6"n$B\.9hqL?96=@8**miuiS&P$$Sr]A',sDoeBL;SF%%SDsg3K$mB$Wj,E06AXR+T
19_Y,@MEDGeP?9Vb0'2*6F<a#.>WQWu?tG,WUkm*5HaZdK>a3Xu\:YcHpHZ/XprEV"g=^.9?
3i@k6>$mGCV3k<1`0iJlMa\Zf^r!o?,VX\#:,Y"gQ2#VLa2*r\_($c_?BhFRU]A#K\TI89"1:
3tEFGG5'!l!k*=Fgq+2JGZ3B>D[>-c]AfdW!pS``]A*Z"LgK48/s6\'E>T"@nK_Z2T=S0?J'iQ
,NJ?1GPIG?Er*&$0JN&'s_4`1`*)Yi4MN/D`Mk9+MHKP!]A>Ui(+C&Nc0\U7pBHjM-);h(Q7A
k_m&*GI;HS;JaGC"@f)Po82oEOY:5GHL<8rK9n,5/%.JRO9?&'g%\jlkG^eCc8)RRFRV^K?$
Yb>gkFTga0Gj"hbq)..WMhj"Mp`iW'hES$?_'!"K@HQZ$Z8S#l^EJ47LYh8P:"5W0fH-s,RZ
a[eLmDCKDb"*Q<J='<Sk?5dg91$_1%BK@.l7j)KN.4?m6!#Z0na/`051T,+msEq\G^E*f2Yg
%4!YSfXEjqMbY\^dtM+HJl4m3lEqaPF&N_q+U!\@!5,+$+I%ED^.`k'psEJJ/>8<Sb2oV@&4
_o"+XZMT+(N>B`$]A#US</tRFC&#<He!^;(u(bUZ9Q91@[u4-HhmraX+170BpW6`_LB;R;g6.
fB-hS9e@:,N$lqZ5HA*g_a^J'&;-\X2cFHZM*ouG6P.^na:$([VAK:>(J[]Aq6PQ#5Z0(ip@l
B)+I5otJj]AR66+eo=&gs-#g4%E#dn!B)Q*IJ,W4^MZ))j5!<ip+lWLUh:Sn/NeBC64B>)T-[
&bf4Rn.ahuFK-XnfY?6"ApF3L*H.kuU9db6#u/'$;O;`/q0fEM\eESn(qXi:XN2/b5eSn'qb
]Ac1J5p<.^[1mJo$7095FnFm7,Kl`=Ek"R=3^.cJ'V^Y/3b'#V$e57-^oU)dSF#I\p84MCBGR
[4YLhkL?1*/ki7+R6egNK?OO^5<t3L%MSK:?IR2Uka$,C2mX0.0KUk3!nc+:BMne-FjF[\1P
t[7.O)IdPE1*%R!(/F6^>ndtu/Z.:;G600f)/X1:CqK764QMO`(JoCX$'a_Dl5&aTS?>>Wtl
Ie-"=,*64l3''t64cKP@2Z7YnQ4d6F)nT5qc)^Sj:i;!+q4LYB\!PtmMtMQ,6l^bg*APSdn4
Ao)UrJZ#.6P>d8&CjL"9t!"uUlep(l[b[<ub[3e#[W*`51r6BOWK*]A67&Z7VoD&3Hu-T(N[5
g'`]A14d$E^0%d@,Y,N,$T/lQEQ-)%J'_tpt\rs1/7SL35DHqT5HWN>tl@'ZGJcSV\IhN)_&M
7#n,DXZ/^3AaoCdhHb*!u^)1A^`_^SCC;.1T%8fPZ`BB!l7X):67[r%iEJ&t3_JLrIr0A0dY
QGo#Fik\Wlt_"[k/=ZS&Aln_^c9;aXlrlda>HrjP+eo398"u`lLq##8VbPh[Lg&Letc"n*OZ
H!BB9Z[!bXOI&d^2lqPY>QF6.TX>(%hH<sF[ldi='@>.,S>*E8&4i<dg*)3I>Q5EiaW:E3Sk
P_DueXVP2:FWa.m+8"E*)7g:VBW(u464DA%sDRB7Q9E1@DMD81CGMg6BD"4JIsan$L,H,''g
`*_8/if4M9Ye(>kmr+2B#F]A&KiJ*_F3Yo'JL1ANnH<>SQ*'`8XO5K@n@-=XMfR@uddKnJV8/
GZ4WVbh]A?GC7&?njbXXa"`'(]Ag\kSfhF!LF3s??_Z!abHqt+Imr0&&S*+kUH_Bu&oSt8G?T'
ZCacUkaf#f0,uhd1V/BRg-)%:%;c^]Ag[B?lVl.Th[2ZIk!^MMUOq`7tp`gbM:kAS>C5K@7^d
<n]Ae%O>tZ6YrAYAr%]ADB7BDs4FN`M,muY)aC*N%7@5cT"icO,JoO\A]AE6=rNKu8/J4D]ASZ^<
Fi29(ZDO"nQ8@f2V((clIk7ZL`4@D`jideIBuqW*:(CG-V;e`m5nEUDDlr?s8s-jfLpYMBsA
:L');A00?3nNIc&;'hYF8D&S[k6Ne#:)NJED[)83&XY:aNPX87WMj>J7g:'KT>brrLFA6rFU
&s<dBVa'O_1#l_Q<S)2(MPL#q,Z;UMF%dYp5TDo['G_2ME(lE\3]A<M**Def9]AmnR,o/\O/$F
EQH]A@8mp>(KEFa!e"lm<s/D6gd5eKUln'@br3,X<2k&Kp*J7kt513ICp&Yj(<7LYcEd<)Q^d
FaHtZ&"uU.dT-hINJ]A;[34Ma%*]A`N^p$,2`,JtmE*[U.2H83Ef]A!eZE%n_D/]ANt:%G?6i4Z3
enmJ-'(hRq!!`<r<%n56#[,@%kW9\;3=Ie,`.-XUheJEg9M2Wh`Mcs^s:P30"-K"5*A*Rknu
q*d+M.[&ai*-(<I8tE"4d$HF9!<snYPUf2cld:N=XVVU6Ar?-hc\8Iu9QG@bAFK0hCGQj?H3
=M5V)XmX\%o'b)YlMC[O_u_j#OnKUj'9c!c1_B4igJkOm'cns&G)LYpa'[GN<]A1[<DQ!$Ncg
cOqGcl5Fd_rm2AU_C,Fe]A:,0>#k8HrG"_(`E-D^dPrp]AGo7ZLFeW?L>g;AIB/TgBXb,o@q",
S`ql8H1[KSUiTDUEr7>>DiKunKYLX88DU+E$gX1$#GVkdCg+T?Q3QCU1c\B`U0-$&u,$g@.E
/E\9[*`ZH0;A216^Sc:/*0BdVN!Z`!aIl9hYiU?1C!XIP`Cq71YM^=OQ1a%g#fqQ/3tG";[o
g,Cg@Y`3g2M=8\+ginV)<4\EtN3lQl5#%>:!B-(s1+A?<ji]AQF"&Tm&-*!\L]A><.+.inrh*Q
+LrNa_s[-a@mi$2h+!TQC3Y04#I4#;%,(D\[V@na&&rr2-W;Z@,mNH^dm<@!-S;<fsQb1pC*
l<=Y.)Vj[)>-#UtsN:W%Hn=jN+Hn#qkUgRYADQZNMo0mCcIj?_8\J)1Z>C5PmK9$.[T1T5/J
_8[<H<l:M3JiE?m;Xj&4SZ`kPXqqmF-dI!Gn*2jmt-an)+feSi4$\0amC%koD1+6Bc)A3X#a
_f:G"88HW(@0eIY+A7:YtP=H#BYNJY\#0`?)=Am>b`X>>"(l:M1;>n>!,>7Ik)ApaH)H4Ws]A
#h\L37TQ9Q!9S25BM9aUr5r6P)50GgKMl[j/!7.SbM@_"Q>/!$$T:@^:jAEEE3[;7:b":K/P
2c+ac=uVP0gS`+BkH)9t$<t"ZAPK2]AncN(bIK4OFU/l%cY@a0Od>U7F[P@5F)an/;i<chQ`5
=c&uCUWjO5:G[Cf/o5jMVnSjkLHRNmR+*V8:c8:ZM=+IrR!\#VtBgY!f^Q0LFBhj3+>/!3OX
T7V-r&QuQdZICWUm(omY[r)-Mb,4f8AYLV\E*ZPH2%EBah.6?XA,>9;#81O;/m'rBRgMUKG4
f)+&4+.W@YnNpRXf&s#<S[pF%*AaGMejOQ#9634%nTVAo^XhRuKH\'>Z*HY)+W3cMY9gF?([
>hR$Tcj;(ZW.f,1(h0WYj2QsZF?Sk;"chIrdod;3?[g<n=%@GF#oUi3H-Amei6tmLRRHf`Kb
/-S&ei[;Z+%Na[W_=U":%mrWPEHR2Vp+X-Xbuo?tRJGIe?/&S?iB%'qN7M>Qc*=n+Cm?.ICD
5qm@Um<1c;DqH,FiPp',-%aKrJ)DaqXfR1fqDqB@\1,<\0dV1ZYU3]A_q0%+.2ZERfWcWIhn,
9=OV<1)r+Ta[=ABKN%V;pB/2J8B>#i:!IgoB=SKo('E>]AShO1%lNRW;l$t*MKi5C`^Zq"fGt
HVB(?ba5*=&S('\I-Yb(n7$Vff(]A.6X<iPZZNg4#=kpE(<h]A0o#KraJ\Z98b@56m-`t=Glt.
3?j+RnQdJ%(4B`=p['u)=D5DoL4&`VdO5bKKDg/bW,+Y,#uBueU.b@i_K*1+I=QE\Db(AV>\
T/=L;'=r.P+K/:6X^BOI%3PTgFmZi8Mgi2U0XDnMnab]Ab-/<XJTJ:(=(YW*=*G*B=YDBo_2.
K3andsKlYqB8nD2b7/VI)9X.]A"pcdX]A3CjSa8a*j88/hX$%O`>1MZ/%$j7]AT6\:3hELn/n)L
D-Fu:6*G;BdNHOD)V7bRSN#eMb9gM@I8q:-0pu>6dAp0AZ_!5ViO'8II#jtQW9Iko<88=E94
qu,UHXXa@F[V>QXV03gA4U]Apjj\1j^m,B.LRERb4ur[n'tJ#ll?-nU9Sh9kK.s0AJlf<(H_/
etDhF+4[AZTP!jfe>O.Cl;cA3V.-rfYhb1<a,g=C"P>[@F7SN^\GZsc!#ji58[`N?gi(^D70
/mbiV?7O>Cf3h7u5ALa2$Oq`dqG:E2?u+,hB#RU^Fq/#kC8n80F(PV'Qdo]Alt\do2OY6i9$*
H/qHP;VNsL*p9(3`m'jZMn\QLP2@2eb;nMq?#B"qPL5Q1F>bK=baHPMI^sR(Y$X<N"s8*SH\
/3%Fmr'nnE<t^1BSFj')e8+"(_#%5JUrTn0^M=i7\'h*KN$isFK,?g?`8mn"E#_CKk&$N0`6
++&[pT`K\t&`7B6/A%9^,m1K5bVs/Wr4&cp3e1c"Ruq(pg?EuT>lhSl%t&*WNiDV]AVlqfcD2
&_Td?1L*%-mOuPZ!Olu3`SGkOjh:EW4f.0nrQfo_]A'`04Y-c\Pame=ZS!fOs;l?d^Vq4UAae
KgI+`Ksad!/8+B]A#DFab0%XN2jY"eqe+o7l&>X6k>GI9:",eO@IdkS`i2)9.a+BK3l':q71#
mWjXTbKgUP[=ZM"bW]AF,%5OjMIT_Q!="<8qXBg[h1=UYV/#9,/LC66+P=e'XR2l4(+5f/8<)
h>YKqO&,sC'=Fa6A:M7N$9U5T$1>XAdLKZ=`OqiH31F#ZZu+Yi4(`#Rap-qS@K,jg!I$Y^F:
MJ<0'1g;kC7fX8mn]AEAssZJC=Ek`#EOAU;)Mno(d7"6I*1'E$V>DX6`R2_-FBX;5"]A\#>iX^
C)D<:11]AjpWbMN.H"MG!8B6W9M0SV9"h2"48EJDPHd@WEfQnCn)S6"3M;srLY&thnC,Qp2j2
RigdtqbgGQM'fNMLpR:GPsT2AqO@EC9!$TkG?+J:8SnR[#qOQ]A.f69*^,N++tCa,Nul9,)3g
9(;-je)RiC\&t6cLObTF@0$VbWq%W(*5&BG)na7:I3jtGI/GU(,T>,qM([p;[\HfWbq#MAV8
%<j9#sI.`Q)du"DPnG6Qe`6sQa)X(p07p[neh>qa$Bk(F).XD1oSqn6jKNZWCR82B8\*.Sh^
;1ci)"?B9G!n22WB2j=oem-]Adfed3Cc$nd>+5]Ate-(4FZ@OOqi&s:h1A)\GlU(+$?AWo)b!@
^HpkkI'mn:23TkHmbN.5H_F]A6a_C`jpcj8R`qSAT7^.@V!S]AamfGV2Hi;qN2fIk%ZXIN0PYV
Ra3FdB6flT?6`o,R2RH7nTLnp-;+^aNDA5a6b#'dV/8/P:C0K4u!Jj!H#3"QbaZPV9hn7F7I
paINE8FSu.*<.rjE5`SGE<%HQddf$$&]ANNcoIf,:#lZSpH93!Ij5mm7>%@N";=5V*o?,(A$T
lmr@`:pZ.5l09(qbl"]A^s/QYScdc^L*Hp"p7B4/B.o@1Rr1W[e:&*i(%:qX#_?BnllDE'C5j
N\pL3C6Vhmtc_V/#EZ#%N8Qp548VG13Ld3GP$d*Er+1(n0s3H>dnL^%^l_`RU.1Pls'?-3LV
WJ$f`NZb`Gg)&#'oL@<L5LSSQLhkKHc/X8;^$M'0HI*Z#7I-`c(=1k^h%c<^rN\/LmW4<e>G
+b/fq6a!NPT[tf<5NMI_!Mm*rn4e3G(2ARV[7@^uL@*h5257\#=n>;*daP6XWs2'-GDB&\rZ
:_:onN]AElkHJdB^in@:q9Um)-N9(?:7QLMeI'&HLjn@H+gSeh&D@.V2TQI]ANAs)2.]AkoVN;9
u!;Ck/LlOVnO[<'AjKkr."YIS,C%?`)?UG`q0PVN(n:/[^@95mqm`,q]AdiR:]AuNn7q(3#85(
;[2W[mhZ*f=RG<Qec/k9F-eL4mCZ.O-(.s@L&L.hV+,C+t6(!W$t#1"bRAEE(1nG-!$Ak\hP
T%sXH:Tn3jgM7f*oUI$5pA/m'MM>PfaVZt&cqoNo;m^C*')d,O8+.L_k]A%O;Fe=Zp^$)`a=S
1l:%&6<dPPQ=,#N[I5e+n'76@a!-)"muY-6r%j[MT5:#(?=<%@fJ!JIL[$3_n_r!#Rua^WEf
AEU5gI%p^?eG[-L4="cR'`cEV(PW2MR(d<2Qkcup!PKY5g$[3RZ6;GZB<bhGQARdd>0*\b[r
^%"V%IW%E`.L..U/At*^Q7e/M289:_N-0)cTdI4^;B4SCJgj!6^00&QTWU!G^07Z(cGE!@9l
[nXB]A.T[O0@GqiZKh``$m^iX(tV'/PW27%'KDgPGucKM#?h,<*s4$YG_)kO`:+[l_'*TiO$+
R,/9cnM_V7GXte*EcY7JTF+2h`hO`cATNI6ZQ$)_c=jUub6GNB.%M`%P.b7@ca!;Dh%K"C3H
^m;p`]AWF,3QplH\2PsQKqVS:@(mJI[2c2O'TWePF$9HNmjoipJVmh3-F3f:*./Fa(5=EF#\X
81qf6>)(*K14,;cANEn2o#cCF&+p[.n0K'tbDP=uH[@0#m/6s*[$$$gg#+A9PpQ/H]AQ&JQs.
[OjBJ3"0g]A?`dpNoMCDh6$9NFRM=5I="XXa*'hs[I\?B3.&u-4?0_m*F?M&-;9m&XJUs6+Q9
'#_9l0)c=<Td>tV@I?Ok1C2*akN`,i91!rW&`)3bWhnq^,\7WlSGKNoGAAYM*/F-VZe3GlK;
cT-)QOg<#1\P-cIm^nQeT9#,PAmiQ]Aa]AQ=G=(-"e7:@Qs[fLm3CD)HRa3G_&UkIdkNI0STo9
e:Zm+ZXb$g+T.eVqkdXl8SK*E=UJ_:XlCBfsBAb6[[BK,.1.d[D5:h)gZidp&EM.ST$\:[6;
=Yd@MPrOr;E:AIHu*Wp5m0KbWQ,b_u#<pRiIKekAn>Ch-\<A*0^me70$ANP$!h\4c*-k2),=
09s\gW4YJk;b%Sa.XSZX(j.o6abu;QS&1O7h8tHm@2Fu1%CAnkL%"\DtnTZ+@,0B=fs2FR7?
b'b&1eKSMOchS3rqs0uKXoL^>(Q2Ckj=/"!]A/NnI<_=.7d*?PTk6eKhsVaK$15]AG;.R]AQ!#9
,6Xu0hh%@<Q'qL=_e5ChCnFIo30,;>:XYa[)g1-SrCr?ncQ`A0BcN&GJ9.XWi;&R9gpm8'D-
IF8n)8,:HGii+4F$)BmVsSPf^NI0^XJ&92h?qtT\3jT/*8+nG4QR144_I<[agHNjbra8IRpG
-J6%\\Xcs>[q@[amH;!Q'B,:WY'#@*k5lb"B#bQptI3?Q'cGcE+bnj/Kp^47]A-=FIU]Ac4*eO
BiuJ4'ToBVs(Z)hn'/@48F;E*;fG6X:P46VH<X1dmd<SPb6tio_4(W]AXo=A2?pU/!k&An58J
sp7iPpka[QDL;-7d$#"pU.`4B^rq!DZ<m(M6f4&-8/@(QRmM]Ad*(?tKPmU0`E=[]AC7*<E_18
MJ\A=s7-F%We/[8[GgLM$"\]AK4NLs--n0?#%(RML(^Vp^#nE6]A%UO+U[2@n)(Sub!d8:?a6E
8F-5#2R(-MqJ(s13CnM#a1En9,<U,;9"YE\4:cHEPBRojnfe"jUXg_njFuZY-AWTY@`eV!g(
gXOp6NC&!#e;dK*db"Rt/$e=@lU#,bPYj(N"8,#4\Eu6$.:\PJZ;5\^Z!q,:i3aaQXF-bFH/
WYP\c+p@@^X9pr/E<Uk5;mESPnn>K>j&WEZcM`c,2PN,'+)Q+-u^GiLu'@^a01tUTi[;KB\\
^D%-u=@`X;#K1LdmOD.GnB#D4u*q:bX*UaF,o(WMd33>Y$fbpJ/^8k,j6)8Ndn8<kRE7RqUq
c8X82$VNp:$#CrV&+&XB`0)GFfg>&f5+9E55`McuW)A134!^>TBe<dIT`f2^ETH%H7qdsCRN
tYhg/Z:?Y!kZtU6K(`@*\M0gVr[RS4tJ9Bf$>IN*]A)k(+SS:lW<PA@b<fRI[/j-j1o0GSY+q
Oq?ccO:hQ9["/V4RPm^A-@;@c3*%!6X(bJm?rnb%n0(Q_mTF[)`20uDD-;@;cg1m3-]Aha+<H
,ns0PAQF?,]A/t\':!dmrk!IS\\Z^2Kn.G3%WAg;Z=NRtZGd,1FPmQ^a>(W73IA.l0q[<CO.s
Kq8V>5B5n.?u9*[o.rf=OhdO+W<al!j^iV*[jl_.9K("BD:5gG_BO'DJ)R'qt99+C,bn:Vd3
X]AotAI[qg+NL\44na$X:enYVBT?;6d]A?pJCNMVP^($CO^s!CNDMOn*DTj2=.r1Ftlg8.#sP#
>k.$KErUC)!l]APW`$U@WaDRnp4HN-F9.F3kLVDFNI*g=M8a]AJ9J/(1c^Ke6qd'i[AU>'^jC;
7DBD&Q8qs8\c(g`X>2[PgHcVm8bK/[@#WlA*pdFGBLYOCEYNi&f3tBN)G/:*h;oN?fZ3ZM.s
1Vu>[PY,<>1!K>0BHG[o+^6D[5W6V;ORhf"N^7H^K4tidQF2q`aNk9NV<W[%(Sa;?5Pk:)@#
o+M0@,jTklu8Z#>-iG1a;oX-&WU&Z;+$)eZ6EiXL;PcY8ddB!o?A@ZKV10el`*haX4oFj`nS
m5]Am_@KWo9Fes1jf!M'2QC`!H"tc^SP$7kF^h2_&-)E6sA:6rHadkEK,o#h&PfMr(0;O;I+J
lM*&dd>+bP<;9^lO#*!7!A#TAA`S&5+3496Lc[-at4GE!aH%QXIHU=UNK4q;Y=,?X[d&IW31
NUNZ%3M\f-RnA#nC2HCt]Aog:GRqr)n'#l9$*0@C:;B1HA%cS69L/K+_77A0[Q@1nG;&Kd#>8
#%blN`jDZD4IYb"W,%\lr!u;?W2;fHZ-:1NYDARA\LprH'0EukS.Sk:k_9!m.IR`:.rhse%!
uupFQb[mkWtS<2P@IM>jX`+3t9l6c(lt/1naDf#P*HJcfc7ql5P[Bb5PT4s&hLI:X!):]A^!e
rn-f-:,0KYGmp4BLlQ?VDpKo?^nQ\ZIhY^O9?RlcAPg`[0V=uo&)"AN0R8!"WO@@O:4E<JDR
`iM>#STm%n&9>2_Rge@i/%<1UN:mXT2(2.9]A[hH);J6Im8YpA^in?J572MnrH))^rCIQ'I-a
-W1a2MG:C%GpUQ4nT-OC.lIct;FH+1n:<(c'n&/Gk8^@c13=./A5_3,?NGAm+dh1Xl<.^H,B
lY&*_S`K2Z&)m5!\LNk$<3/pn&G`U/'+$<Vm%k5!k2s3?HB\RHe1\[jH%_4R@e+:,P>E0!f(
rqcJI%'XY:5bY@TIM#j>eBaMQc=GrIkA8s:W,>s*Sm/GF7g.c8pj73?6M,'sf_UnX"leDEmK
79!rZXoktRC]A#c>7EKN=m?oqW0nE5>\qd\uG1AK*#.bjI1#4r0MsO,HCeabh,8EL6ZN8de*'
e#%/$_blL<_%uW)'$a#9G1kdCIi'\Q@$0N]A$%*[YR-EH<$iI/raI_*?G$s.MSij\]ABCpG@__
Z0AT%S&hYIF]At9>hlV10uQ>:TN]AJ1?,"?$K%nG5`QS;'?.-PFdZMpO$pZDj$'9?MJ--65so!
fK]AA#U:c;*(bopKaQ0d0dBpYEd?J?-r8IQ)l*mdXqE1T12.dR_qL9;pK?#1(GAr]A7_XV-iV:
ennDS4*C=eD6V[e-r3$5rj="/Cc.TtCfLC=h%>TV[INA73*,<W=^)FcS1_"fBJ>(O/'$MgTJ
S%d=De[8M%9UiDXmY=O!T`@VYY)FO1[V&C.,IDn.Xj(PD0iohI*;t1ZTQQhY@E<hbPFOK'l;
]A$s2!P+NP1<C*;A?9?]A.8Du9jV[S*d8\bA(p"/A4NYV/b/E]A-dHj66rSs9n/P4ucGtiU+#.3
ZC]A`^I\97+tXE0SidhKn$?+j]A'R`':o]A?gV!%Ju#*ELR^GM6W(+hd5?>bJTKs>O_NU6b%=4*
fW_q?9QWQ:[:c57OgJgUP;Q3C2034kph<(?RsG'hR?S`WCEo&T&68CV</%Jp[\,-Zu+?Kep0
DuqKZBO#Ll&G-9^kbEO+40%;[Lc:D[aFVh**ip)#WjAKUmX=1d!M6G(Z:Mt9DY=@jdipV>rQ
r^a-OO3aYSOPoGW6n]AW-H2&W'SNtHE&"gt*-b9K@SQddS]A9L0j&uG)bJF1/`5.G0[+L@Thfb
3^49ukrHmK@:-3*3a<i_09$rGLM$?MXVPq/$3gIsET"r'DrO7hc0o+^j'VJ:K3c_iHXi"9Q&
H7jB_bGVj$'YDrc&6OdEJ(3DVVJ)4juh5C,ngO)A=NT91_Ml8>6WU)7<ln@kQA)mL-n%1teF
RGYFQp,X9k0I=e=jn0Y#MHYo=-CV/#'4F[Vs!8`p+":U_oGBnRCNY4k,uM4furUR7@5fX4rn
\N'HRWi0dGXX&2RoL`.7jIY[m8W&o&&VPER5TPg;WO%@^3na?N0)T>IhKPGH37(pOk%DO`k"
4au;"Ntt0mW'BdFPU"\,WPrU=Od'b>Vi8e\aI%DRO=KoTb8,#Y%a1B]A`5f*5oBC5q*=FTts(
mW33CbnA-)>3O,.VL@DT&UoMfJLb;e\jkP*..C6Y1jQ*$GO6ZD4[#cUabKZlAW"/YOn%5i26
%bacBUB@#@rbWT[-BJi@@S:Q[GOlb&Z)9<kmS[83pOs&5eM^j2^%]AE*<EK5]AeEcWd$GfX^fb
up!o3P4>*'sQqN2Dm,`4;le=EF$7u(NX1?Q^Sp)8+IMCT"^dYs.=;rpbc7-.\VP(@9H2p!7G
P6.3>W:;q#>(^R-#$@?[LY>^=Z3I:k6Tg1lbM\o@)7b!n3*#r)"^]A]AYKFT7s?t<m6qhm[Y`"
9Dc!d5:a]A=asP]AZRA+b7Y,6KSRN?/qdQ,XFU#t=(R;:p>kKj-]Ak4)'fT",i12Z@=<.HruRMi
ijn\g2cMT7i$)VSjsa81<r^l2/=CFZ<"$Hr><Uc:4R@,7L(qC&R']AcU3U;"4=^5&58Lr!k3)
3&RE<Qqi6K[?*X#\/=cGjQ7r5)qM-f#>-[-I$,*HCp+rtG?YE`H`i><ik]A)=(a%qE.cCMM#?
/(E3Tf07CZY.QndDAmc^LfR1?@IRgcZrX#i[61\:/8qe^tS.b-]A2100:or!JUJoMBu:^T\#D
uM3a[Ra<JDPKDTke]AD)mF)E_d!cE[8V=F#l+G_7k<m&d&@I`K-PpTkgQg(c?+n:7\mAhkblU
2a861WEK#lVnE^c=[p]ASlSfo]A71j0(kN45dNnZL"OKDY;p1E0Ojd8&<!KG!CYn-3rn9sK[c0
Icf3IMKXhnD"%+O#S_NYN)n5KDX:a0B./@2qIM!QX6(io7NG1-V3QnGZ-/1=K3H!X:)fS4fN
#m-n"CKm"X_D209e`Zd/-P;nH4/fE<cB#WJ8s#n]Af(fMkD0WXjl):(bWOOl-MA*Dj-pp&:E#
n;q43eQSU8fU!7;&g%1J7`i_2lI;Ws++!WJP@EsaL>c27+S&S\CRE5P.QrEAfG*Q7_9d#g_4
Dp!g-I4%k6TAnN"r8T=qoaR3\&">:Qm8#.=Z$!5']A1p6liQZf6PG=2GJl9).<KZ*Wa!Cn)(d
WZsR\^K=&I/QiKD4heb9!T.=36nun+;?9]AS7&/Yj#kZdfJUr<*A&+`00^*I=%#_<EnOGr$28
0(l>9j5R<@kd&L1M1=Z15C,[_:9siS_ZuaKaNn;+ZA1_[*oiAh,uGHD/2A\YW`4aXZ-X:FHN
8aJ5cei<bg:6dO0Oh"b,<a+f0<&m75I$^T'5Wm8P!;?g4S-1RdUq^)=s?@5.QVUa=#dU$k+i
O.F"ncQ3!Cj)VOADl:u:Qca>)K9V%V+Z&"eF5%Z(Lp[`;0;+t$n/-S@Wemi2P(*#l\\nbYc_
439u^_VHBBJnl^'&Fq`7`KHhfd$!8l`@=L]A;oW_.:[YWHB8fJ%(F,\anP44.r3r@a"JB,=,+
'-Fm=_c_imqGe]AOg0`9k:TPCCZRJ%0hT4j?QE->nUKa&s#]AJ'&X]Aot8(*+ra,bCg^i_]A>%>b
e.G8aLUFF4C7OcB_J(>BLs&#l1ed>fcZ'mkp/IDN7_SkkTA#q]ArB\2&11uN4Uht<ehHgI#fN
EBm,0B<NV9j8,V%#fk."4!fhWKo0BeQi'!Xc2]Aq)*br8N9o(_0JflrU2=Sa+?E9HhX4YgN=b
!!#.oB5aar`b*2ljaf32*W,UMOQo'^Q)o#gE@cJ2'u+$,VlX!")+tWpJX_''oI1e<2g&!bB$
5Fg6G/fIJb-]AT=?Cu`uJ8oViBT+9@mo7cHDGjGDn9VcL[FL;)PFT9gro"?)OOKA<_X(N-r?K
N'*`Bc^Y=C_m)te>d-44#24Um"=WpaMka<N-"'gakD.(:g^UiT>6GAdna+AEAUKK?&cAEcl1
isR4aKH]Ak<<cgI7A#6ZV&$=g)]A-Ha^'E(p$uAIF4?51`@,<Eb_NAtfpkD'd/X]A6LffmOQCXT
,=RSB8Fb^.7AcYm6FSPIWk;nfSpii8k-2!WPme`B/6i53hi;QXXR[9,-T'd0cen%VmMfOVb$
k(:6KB.skB[m_ZfU99sk6Z$4HURK");2-&@@l2ElD!jdhsnIuWdb]A7PR9:(2C%B016/HQbs&
Ose?'-W>'hHgR5`QhI?@R&fNAZ5,S=fb/k)GqkCk1*04JaH_Uq&_pu-k++5RUV]Aqi]Ah`OTU*
)qSACN.,U2Wc\cU[EBjZE3=jEienVjG0b*3[a]AM'=gKAcp+D'PZg(rZ02^r<4WHV.L(^_E$E
st"Uk!=+Z20i0ZiOb[&'(bmeZegh30mkV_kq5.fQK=lH`sisM<eZ6CLtHf#.?W]A_4\#c:shW
H3bh]An]AeUU3igVFdZ`(uTCf`V`SC6^tUh.cMn!;W<q6]AD"4GsPjR$>+ae@A[5Kc#Qt!D<2K*
A15@UM..FN`n#mUHht;f<hg^;CYA3Z^Vs>8bUCg%%+(N,'DO3Iui+]A#=(:9I)_m\$cR".\ge
"RL&0^E+(a@^L2hFggGg/ZS(/'QFm]AM"CDWY-p@&5TlP[%)BQL]Ac.iI^0FUYm**("sTSh*oV
O(4]A<Q8EXaS#H[tBi!>0`MF?;1(FZ(m7-Ie)^;n"3?\5E##b(\eKOmkCaQ&7ZP3U%V&QH'Wt
)nK6W'ecY6%+e#F3f,)/7Ht`_,XCl4*eLIiLcTHCih!6_PBneM->*,?1K%YK\fJGjb,%8XPW
(n':<U`2ntj;T4W2%qY3bkGtV41Qk8pL$l"c-VMi8JQ^5B;nehbc3,_aOC3.R?b7O4@<4Dq(
1YWM<FrN<[YcPt2XFWB="!S&]AgH'bY8e8bFLIasGNSACpXjAJnu-WZo373:?3_[d<M1u"Ah,
PT8%U_nlMkudf"#ZL7\Z.`q:4*#kEDnle=*F!C8C9sSeHGL.Hrn*_tfV>76uJ:H-d%beWK7#
C,g'jl]AD.Okm3Aj]AbXnrA2X(h/<WhA2EAfafCM&jS+@[]Ak8Xib2dJL[F#XNl]ACZroSR^og>:
OZdhX@P,r/UoKR5:?YUQ-iE'9INR"`=gONJ-^Cpsdk.l#$?[hT-e<@DPL;)h_#;I?@LV)lXu
E8Fe'Go-F%lmYd.EhY;?]AmYr$c*dCZ$"]AsMBES8SE='SiPdLB98]AAb"8gGq2'*-$,;2XfX-?
c`HZUOBA>93FrZ<?#FLL8!LC;<Y<<J8J(!#4-2W62TqVki)@TI^D:.+0Uaq-gG.*WDLf&>FU
-p&kgOaA%NY1D7:Enc]AsO#oPb9@p3e\'aT?;6_7=M*Nh4o"ju@7k,8Jqp!'4>X'PY8>WSa`l
KO-(L;m]A[bn6!Y[MSY&TH0S5$/3jmtjnjXG_oUu@F#4S,jR[2f-&^HHk?(!\jb):aYSB/GV3
bk9!:H3'?;2]Aq5`i>3pp5&u:joIk_KBFW1n2o_6!p7QQi-gX'(49mm&9*RfaEA>]Au[]AtYV$@
LqG@uD(;50/R?H-kQ*9nW9TUs,nkbU<cJGg@10Rd4W\CXpJ0L"=^6(ra+<:Nj@FL8E,cm$Fm
C`H+KR*K3Keu(')s"kp9m:p1$bu0NdKSjg]A9i+H%(tDX$KHFVRphuVG/H:CSR\UXU`+T<+Tn
'D>bB\Xe?s*)LPBqRenRaB0j(H\j<@qgT$3(4F&e$$k,l<NY\AaW'J[u/?3rVRkI;._f(2bp
>OAesGu^6ZU<*70c@ile+k2Zbc>cgUX8;VEMQ@'MYj*=t=F<+F$en#23`?!QcCH0jC-8Uf;7
ZageX=Z0$:H6>?&!uE0L=g%R2o&gQe/%bVZm8eIeqI6/</f+2R?<:YrTis3T(+Gao$@7PIf@
XLNBKHXN>EReGj3d._I_-baNa9Ts!u=4DmpK@5HK;a`0NQ1HBkJMN79m#IOL_?t0X5hTW@5f
:AOij9&%oB4r;2p'sD]Af)VUj#XEDMZ*^H;HjU<L@U0&DC-G1l5gKW2i3SI\5'hJ4*?FT3I.>
q.#ERZqEQ>IHc?X`oN0b>UHar#K*QL=!V0RDq?[sL^#J+;SAN)/R&rc('X'jMcE"$)@TXH!X
h>`9rk8g8[[5T*(pGB\D"8*!%><Roi@%2P4MmM_W&HUXLo:Z;'OT]ALFYig%.gj-F?B);rS\M
Q@WaGX?._N`XYCt`94%o[uZ<o\p=N#VYj>(^lo483PbJiQke#K7?MKaQAi2*;\=1'1^1jYX3
e_jQCa4Q=4o8/W%eOn7-;7m1d5#WM(k<lBf/!&k=Y:3%bqT[[MY3R1&J#9DrKZ5K^/@<6\*J
+`0YjL$te[I?N6?F:h9=b,KL4+WI9(Xs;_Mih)79"Q>9T:N+XXctkqY0f8a>R8tuIfVIP&E2
h=<]AG0M?ua3Pl?f)'=r0"Gen8uIlo%?naBfS5Cash-frrl7C#f,FJ^k0(au33HE&Pf64^Stt
X)PJ1M<TAaR]APYN>!=/nX09PmdVY=6'FlAQ4XiQ%$<0?J`EH(`6uFqK<OWnZ_esZf-J1Tt+U
"iSLlL8E>-*6=:Q8_4_l;#UEI'aT@Z4>GdGh[[$M?N%c;cI#@!7K[N4dj10_j?6ctpR5fI_g
>U!m^uhM]A8.a8]AX)+p`.h!RW7%kdBYccHZP>S+48=H0'!oD;'9A(NS^H"._6:UsH#Z'Lrt'C
Sn#]AE']A%9+5L[)n#,Glcqt3_S'91AKjbp;f"X\#^'&inF@@58_LSVRH=8N.]A48"D&@_pj9;1
tT%fr0[UlA1dXB^qg$#,0\io0C\ptR5..6Rb%\UtEUgBJcT/c_MQLrD4oTW@I@PY)'tV7l@I
fF&f!]A^a.f")n,8n<b'J%<m#$nfUuql\Rtp4uc+%fbs.2XWak"<8J:(CBe0\<,'Qo?P/KWeA
Bkk&K&&@(0rjV5h@S"pi/eL*T?4i.hmX1LL\]AI:^fL]AJ8OWZ@Vc0b;pL&)`p#NdGVL2]A083i
Pj`'RtgCAQ`pVZm8K.u!8d'[H3NR'Nl>@DNrU19j6J7;X+)DH6+&>?Em5_ns<(8Q2p!a\=/6
kem(E\BD![MVdl6)5;.\/r_o&gSIU34iA`7@9%-F/^O<As;MU%2O_n$]AUG''nG#2'."Wl%]Ae
FTq?dWB[6cfEeaMI9M[J:mN(rmFLKCY(_9),8hOA+9Kc.!N6r*5j(h&oQZ(NoRlHl4'%NQnU
k;fAG-"NA`i<p-\Z#SnJ<U=EXR"S43[i9Z=(?g0:VdV+@Z"pTB]A#/"4F/)0deY\:qg*808&3
*f5Zu]Ad/#1bC7heL^5&TXKHHt86U8eP1"OPIA7)VEP`=<*/HAts@HbQYT_6u<2]A`nXFO'8N0
)%*VahplmM!rbki<,=t;jRp(dSQ;"52U<2A>44Xk"r>dI9B2`kI3D5+PVn$IA\%44R=hntp%
'W[j@4h]A,?OE*'*G\aZS,J75YeLnGg:fNdn(2^_7GhJIFaXbR+`[S;?X*ICFel`p/llJRIgK
;%8#ZEj_S9G>oOg0)b^Y(iqYP,`rm+d?H,o_B,6n/f1VWc<lPH0jG\db[;k]AADIfZ2@D.&Q]A
BIm8tKflMi7&1o2KZBj&+_<nmdX)3C[2T-LQU&3%jbo0oJrgPCR+nMWr^a!IO1,i*n<fTt?%
5)o%10l$i*aM#HfI@?Ir$b+N=?UbZ+dM&QIkcF]AQuc/)'+C@*NN]ADTMS=N'TGD"UX3e%6hFO
=)""bbU!rImkdiPWh028[c`V3qr%eBV#hT>'WfI_pCu^R6^nbK50^WC!At5iYV8UlL?DrVg=
!Fm9>!!_<4r.l.=/:2OeX@rF@:eo]AEDuiDCru`.&7@.kFj5(^VS`4:RR--KO>7TopuqPb'h0
E8Cs*AtZWcr@hS%a$1UH(nc1%Mda>eXX>7L$oeMZUB3JBUD%?u%:DIHCM1cjaqWP'UUpZ<"s
('CLu3n,3JJJ^"7\^s*G_d1uCe\JAk=bi%h`p6(2$p:CJr1lL7_LMjScVu$^A,;'+S&EtFcV
jh?^/rV1WjBJl%YMu61VRM58ZlmPg[orR`PIYc@J%XI.J46B=P3%PdV?P:!kgfCXdip,o-A$
<mr-kGROL>9[a#!s]AoT!T8,'JjF%l%pg!mDJ%;kq;o`i)f"OcSUVOS(V0^)?.p3rQZ)-Z#lT
9IK9UB.FlX9)hDHCjG?!a9k>mQ\<fq>#cZVg:#rXr)mGUJNL0m_-l50V\cg9ud+8'a^)gd%+
Yg9CJ^G:!Ra"e/@D,e+Y.b^^-JGT$'mHM(ah`f8T]Aq7f-u:VV=m,PCMZh_SGkFT_TM1's=%V
_"P`m_d\#]AIi$bO4Q!?Up30p:jl[G&)#eqk1OT:A?d!"/%&3c'JB_\Z-OaB=,p;mE69H5l',
e\SOODSoR07C6S\=Nt@fV'a0L!LAa8;ejGZc[*cg-n5K/s`eV+Q$'X'>tOkh'1;!]AF!a_<Q@
.0JBjcAi)-")(j$A8r(P+e\*Ge&#tQ(A&9p=<[76>g'!sI1dp(U;<YA1#46jI8#L3dke91e]A
ns/ifboPDHc$i=2O[b&`;'1l'fh298']A]A%P04<=oR&f<\f-4Y/p5%qHOEYXImumUR2/Vb$Kl
B^YjJVQV(f#aA*Ghoq$pG82%6>P2GMK$N^\S'Jb$><cHU/_VSq'$'%^mE6\QHFKtLcn@5uf2
%>b9cjUnOK!-uet).>L1"/:r=30^65/9D79RpCeN1b`,ZlV']AA3N9eb[#g589<M^1Q+W1s$Y
MFfeX^Ac@i.`Cd1npu]ABB]A7`@d[#G4e'<OED##Am`h;T+:8R1!gh`.K`>q]ApPLO3E9[Vc-^K
-2bDLB%_Eqo$KudRc#bf#aa"cG%$L-oKQSi+%<fE$@M**c"4mrm)>fUiLJf^-M^*dB0c?/eP
-RZ"KP".4EQ6uDFXdX:R9@Vg-RBimB/5*OgNl(US0^NhN3?AfXk;1D]A\^`]AV%u,`:5t7%Itb
4?25"[WV]A)qBqk`WOFB]A[^j()FV]A?`K-e6HqoS*DM:G9g\^&<n[5cs_AgB*%=[R7baRlIe6>
P<ttY_P$R%KD[Tmnoqn=2.4mf)MOR/Qb`;RT3LBi)A)7b"_>[:rlr",rpDn`"uLf3>^le1If
br9947Y>;4-0g3C^G1`qKERYh:%OeOg2RjocqO?\AXtCEdmh#ZCO2>O)lW%pb$_or3bF*R!D
-lcQ`h]AJAon<QG'h;0_S?CY\4'$.le5a8'%)Z+G@09Pn#:j#bi0TO'K1TMH"*)H[gS7Q!H?M
.,U1.gg.V7&'A6L1mhA#'"FRd<oF<>6!)K!S\\.kd`8`IC;Y?0/9oL`7P88#fi#oTbqj<=Pf
0:9I!r7F"CRZ7i%Y6JCU!\Z/J#*m(G:[O$7B4g&?^A;47ciMR!T4-N+CXWV-XQiNVVG)RXfi
B3D:1_m)hHaAj]A--AuA`7uX,"R;*a/8J/Dl.ENa>g"86&m\@#VQL;'p<U[oK%iXf)l.C/AIe
4!;LX4u8\]A[Ir08u2?C;X5OA/eodW8&1'QlLXO&"Bi?XULlUk^19#6F\.!;\CoT?HT@-Um9O
_=cE0FeYmP#6dC$^\s'N#%[C:.AD=C8<e8ppm'%H+2X:>;3gj]A]A<,skA:'C\<*^>+2UIS,<g
!a"lRQUuq:UBXS-(R'2;#7IRqbja/>u7P\^/g?Y&14<6>BEXiZT<1U"0D^CkJl,DDb<BJ3E+
JpR:$_0)pL;.1abtb.c]A#pE[6k<kH!#A]A<Qj^'NXeqEf:R68XR%hDW(@8*ciAAot#;`XE'j?
C81)D6I?"tV#SW_<UGZ4KuKi)IVt`,Z`k:@c&Qb<8MNf-#b]AkX(+R\oX<c2`dRP2aFb[%?)l
jZ3.q_8rBg'Hsb>c_b(!TS8Cbn[l/<9>M@:Hh\T)B:toZplpm0g/Fd=n=7[P5Mq*EX!W[P%Y
YCTr8!/*![\n_XDV^B<>BG(*eMQK=$?Zkn&ENhR]AD^\d@aci6)Bp6Ul:j_qm%?O*t</RYoA(
WgC+`7W:jpiLg*mS9mDKM`o6*F/b=r@?kZ*DcRa`:[HEEM7:rXq#-&-^4Ddj,+^Fh>.d?p?Y
-2rW>\OGnao"Y=7Vl@;%A@*&1sg,Bd;o1n>><``#5:1H,qDMk\R3AKs$8'oU`;Z"UGJ+e&BM
NE3e^UYXKTFP7Xn*ks5Feo,c."5&>L0Rt`=be_roSuIJkkG#3SHjd#;d/dmP/4$lC)?Etb/N
flr/"=t5;ub$V[i+j7%`>JJ]AK(tA<=)clp"nM;Gl-V:1,Es1%KOXMk/-'C9LB4geDa2s%$?^
90(2_.b_"p%)58UQQC=RZVoZYn%27>`YnB8?O8Snq8'$IlckOAooi%ptd5\!*H?AU/[7bnC-
Kg4j&IYmVd(-/C9"inrO_`m,@MWfl_,``q-"a11MaaF\p`-UqF-)iZJ^fp#q.un"Vc?kn;S^
G_H@5^nY:"&B"Z^%^q=T]A*/EGmQ8S/tb>b@=ET'(?/]Ats?b>j0Jar4UeU>0?"ZUaP=sh%CZ=
-'W52DUQ;tngg0J[DmgobE.mWj/Cd3oe\!C@%.n@E%s/04l6pd3/-m)<=K\XQB@alpOfZ-^Q
5RhNAuDPhf#Z#H?fH9&jE28hu$V>Aph<$(sF6\ZVk?UUa5'$@UT<eFpaV]A0p=D]A\VgOH(R*X
De<F56Nq>1)r\Tho'5ksl6@_Zk?-*Z>Lt3b#U.\c14dXE7-AAWR>6'`#8XQ1t?d@p-Vc6Lti
?E\i7P(S>ST;<co)-Q&l$.19'lMlQLc;LNjF0Y)Dn\X?W:2jpo7H.=-?hgJbAllYWqg$9Q(7
2W,mKm%Y1+lPg#>Lc(EOM-c_Yp3F,H0.;H'lsdf_2NAC;\=_eY#oUt"t;7S=K(7Q&XIb"2ND
7_b%ir<oiXNR<+_/A;<rJ%&5HGD=lK`Uj+g:&QS3s,.HJ?`rp7TO[lYJ,]Afts'#J&#cRb@HR
o$.^]A"/8TDQA,Cf7deHN_!tCa*7K]A,5a)f#+Bl'p1Va-9_pCM[+n"i8'!fGe\\A?>lBgKH3]A
_E+TXMn1sM0$28$3P*99L:Vs*3#8'!>&sYtBUYN4Q<1+JP3\r!XHO`1kM+/KeZj(:a,ALLo`
,'1A=CQ$)2b0UqYL.$u,n(fN[<:4>Kq>n#d<eZB!8Cl_[c%FpNB\>98]AM`WqPabE595d'-f_
H-A7tg`IO(L1m7.1`OT@udV0I/"=ij!\%:9>up9.Sq8(VCY!FgejBYc`g*]AX<)qMiJ4nT-F'
mP4jTBB!3/P(D8imWZmIZOTVED8q`m5@MC@26+@/_A1_sqelC8*'JZM$g4_2P!p>Oo9M#c5_
#uRRT3R2l,%k2[h:hdMohYqWP`[k9Q"+IO17Ybi9+AL_hN+8ALhY'I>en62e2!W2>$j:nE6B
A@XnhF*+ULnhmXZB_RZ/?Geq^HIeW:p(W.k[b+b>ZVPiP9eB(@*?CNWqk"66Qj[)jW?.h6kN
f[IS6CP:K=L)Tl/ml2(lt`#G=Zs[njf8Z;QH3j"(TaNE!u<QFJGF9<LmeBPGC9=&V='LN5\'
R%9,H$$bl%ihB<7HNnSDn71M%Ymm`:FUIj-/J,3ma>_;U%06p&2#eClX`d/0Q3gIK7<rl?P4
R^!Q&*kcWn+UIt?\K-1\/7%.&XBW"7042@N^r.]A,p=7=hr3UG_<it#5EFWV.(f.$T=cNZ-mO
ZVIr&NZ]A`[_UdHg/rnqQ0?l[<sL]A^J.SL2a<9AW@[kZm&W;hqu>Dt&$W"8m;;e$rL`!GIQ,A
CYnoehM?jQHN?Ze>m(N."@U_!IM8nCHls18<HgeXWmi<o.JeX=W_p&"[[J$!hNCf'f\&986f
#'JbbacAm3W%Y$hJ9gnXqR0^DSCqt:7j9`ZY%L\rg6=lPbhKoH5@Vm-R]A-1(<Rrs&f^EDj2Z
Tr8g<HDglcj#`?pK]Aa1'N!cuh4<hR>jND,B6?$m\b!Itq`:BB..rRj(#7'+OAnUneedIe9//
if"d9%7:>KKDth`^m?8n@bfUMfY23`P*3sC=RLaQHNCX&,t_+NQt2VT0nX'24DWNWQo&deAk
cK)m9;.)H.nJdQnk)5JJiPlF(>o.qrU8W&&&^"&:TYCSQR`a8[+Nt:Gah/0h,,"e<4Bl?o,J
3f^cAKf<Kp7?kU5a'_se_Goa6g-%L=E@!ejnq$20S"D$lt2)+hPL7%k,GdGoqf)sk_J^3]Abg
K+CL(]A3FR"Dm",#?`]AV=cj#GB&N74>'Ta@FZ^[B$Sc!I6K40SJB6ifXZaIpF26g/5iQ("h6t
cF@8'H_%^D%YN9=;=^fJ!QD3Y")%d_1=_.>q]A]AZ,`CCJlR\c)?80"DU-ll6)H<HuV+iQA)$X
MI=q>'o\F]AC98o<&[6C#[ap/oZo/-Idk-+f5eo:&-\:%/=r=j.+!V:$@ESRg9\n55M\#O%M>
Jgn/E[)?9i#J2:=C[^H/6dpNjcr/Ae(,I#I[[\MFSQ>NZ:)UCnV;#h1J*kZ%=KQ%0`M!jT$8
bG"-*=M)<+fgn9Shhc6fr!Dg1D<:LA/JQ:$R53UI2YhYm=#>Lr=#SHT.02Lj8cTo"*o1&C&i
M*n)H2OD@*D$ktR5Dk_[IfYT/7e+7W@6rr#OcC:#afL&U<&LO)c3YW"?]Ar,;9?Km=uZJ?#2(
7r=[4Q9ZMd0^5\mlr$Pa$[:\QPZfm#bof1Hi4<si[%@a\ffp2CBQ+1T<"HJm2'kGkIYCi@a5
g$6lMa/J4i/'#AOklr"B\U1f&h$m_`>4buunRV3l&4E-*.d_@3a2WrniTBE`Z/__'!6/EP@G
PgG<N$"\EY56T^)hjt.`n@,AFWZp3Yud3;rQmQ%_L.(d(RUF!aCJ,JQhp#UkC!,2+N[\jj3:
1h/VYo=g_=COjO4>ki:p;r"3&3+jQ^n8`-;g1Uh)j=4?)3UCQs8>rl#9<-2&UW9b*'^D[P8G
4[o^gGkRYb3.#TL'm&@l*X!jE:tn`->EmnEfpT:?R4fB_DdCKrLWGnoN=%Kg!^K"jaBO!R>k
_Robg>bK+""2mEY*sE,i#]Af<RRa*m<`6]AsTsQd/2XtTBP!Deu1N6,c]As'm`4LI)5uW4T3E>*
2XZ`LcAE.6i3?\H:P]A;B5hBL/3<sH`r2<p#+u!99>SW2;nVt!4BYG#$$s,%TD;DKn`--"!b@
gt&C<<"]AghTm`6b0Loo[sg#A6d6IYH8@8E:]Ap)7`SG[m[nP[Eps]AI\(0\kW%L8>@aliT)i4"
1<he8lrp4d<*gNLOb0GE\YfjF*!NLLsS9^QQq<aM6i-!5-Y60macPs7[bP2".!T7ksgFKIq5
mqrU_!:q[H,,aC3aafun)[Kpq-Cf/lLO3j^monrn>/:_?eY\[/XH<=J,^igYC@+faXg.!eTb
STle#[/G\@kqNt4\'QThq8[lX5jnjMd>$$6F?-!#2WJF#!aktb^0G_Y"47$W9f"*6L43/Ma@
s*/Dd>l05knXKBZRLfP@a^O\/;?pOW_GPR_!<<3@Z*f+-[1Thi%,oAIfRa[K.L<.)>5o:qG,
n!WIU/$8>L/90keB-.(n3_omL$bfI0=KoLq+N9`mh[Y0^e=YNTV\J;:\<LhuRjl#r$DR44hm
@W^V2cVC[lXX-KlK:KrQa#*\o#+G65%W<t'>jGP/\<p84Z'O!E\9fHT=gqJ2tB)G+\H'F9WO
LDAG?57#lfT)X/CAKc?:Q9<3OM`bon2E*no]AbnR#h:u#p85ZVR&Y'L)FPh6ZYL,6pkcCQ8kO
iH_64IgEb*iT(U6crdC+0.38.D#h:eE2nE3sOiWYf>KXm%IW7Z`%Y#&1ViV3K9)))0<O[Bq!
E"*GbA:*WGU9)'%Vqi+7'jaMo4Gng%>kIGJ9#R:DfE]A:)KGR[kgn?tg94^d8EX]AGsoiQm?9,
;Rp@,46;5\7XrfY/.F_0$%=63JFd>QR:nf=H3Lq"ll_h8(S+68=m?mgPMp`&2,c,.KZ</)-5
M!U/-V$rW70A^KSQ:gS2&T6@@6U/VGC"P%61%L6T++K8p..b,&$Q)AeQ0k)=6IVb(Y]A2)V[7
9%DmLp;=Z(*/t]A!ba:$/bUa[`+\>Yq*>3q(-VB^W/Z,^S^G.B#QtC>KQgFmS&geVh)gZ)#k7
@[ShqCHG1?mQJoTr6/X8>29G;C*ISEBl@`4@2YUN^\"K&jpK+SaGOKOGO..:%A:3O@U0C:(P
.4Hu?cKG/<cVUEF=d1CB!@sIRQ".OWonfX>44(NZ[L7\2Q"E!q,g)i%aK#ZnNg4!fm4KU9]AW
BB$iTJMA7S$npfTl#^A*EsrengAt/c*og3"\k'G(?3'3$sTR6.]A@R^/TM_p6k_hqpkkR.T$u
#MqZ:K6-2@mV]AsG11aE,[I;9M#2\qH1gCij(&5<%&#6FgHC%BUN-]A_UM/#$L,>[_R2-.dJqh
^5:!V&lX;MP,#oJbm"l?2J!frk0./h\hhb0M>->N)]ADap2aWbbFg[FFhKnF=pfjg]A+=X/CrQ
&;?uLAQ4o$27[,:RM"8AkRR=DE`R$TZ#'!UJ5$XVXNHdf[<f=c'Lq7C!C<Nl>VYGU?p.Bju!
r@diI!O#icrI]A[GS>iBcfQm>7;UUVg]AOr;RNbaUnrG,hgO<)&X/;R;7!D(nM&Z43-!.e9Rp2
acmN&cUE##C1<4.Z]A#`8#I9\@`&i"2\LFFa]ALE'F``1Tl?PtZaq"tnG5$[e`HuJ@ge%kJkuS
&%7S@D&Cao"MC(t`d-rE4Zs"K-%P)=ibGnD2>SD]Aqlhk=DXm[T$%,+o)"8:6\Y[)B*MIPlEN
`^X?!q*^W7&hsO=mX>N)r3.^)Wl=0=\bJA:GtgUIC(io8("SNU?>oY/?M6UCu98$4Om3!\qD
:uNoKkmB<nEJqt)m`#Bp_dZUXV6A+tusfX(GdG4"(?4aZn_gt@T@8:9-<1]A^&WauKW6ij_E6
805[05O=Vce"L;(GS9>RG:SLS348e)ZWB_)TL&M"ah+M1eGuGJWaO%Po3g'uD:tX(-tgklpW
X$"R_Z`d#W&B[<H:Pc_p1q3@,otYW)0q:\-T_!259dI@,q(cC,me;'Bu@.O1La4b3k6WdGM-
2)f_fohWRm@7ce2:1[*`,rCBoJXc$8u_V)Q>8qcq9mb`@bD*N\:]A@`&+#Wd)F#!6T=ODXo8@
.-,BfQmfb[i`D^Mq;P/m`qp;Zt_W=cDBjDf;f^qJHeKVp&m@!A;O-Ko?reT;/TKW&?\deidS
Obr^PSi;VkR!7RZO=9M3BKjR@'o*%K<T6u%@C8RlVQ_#C)8N-kn=)rU(^7rlmb*iGZNrLPk@
qkADuL6sc4Xa!BB\o8Vcp)_8=8b34<C/Fqb@FWAt84pr<ID`#tQOn-5$!TE:nr=,N=eZq9$H
6@7#DNbZ/QOW<m6`UXp."E$G)3rn+NAlDJ,l.b12EVM:J2;mA]A'2u&)pI!E(-0?X]AVl5P5fE
)M50eM;a8eGs$&I*L);pqTr]A%!U`q62K-j(e@]A-PMboQnX-depWh<c.Yk\%BmV@>`,md3M`p
@KZd]ACu<':=Asj^0ch?fap&3'5?S0"^6X/s(nFq`2Zp.PUPfDR]A'iC_>(Msm&'BeB@d`s?F:
S5?L:S#BJ?^<[c0<f?<h:jR?Wej"8bhjHRb^W&Qb+ZihcUulh=i9fHkJe_q/E%4N]AUYj#KON
RjDBt19m$::mSu?Zt(`fp@;=7:c&)%Ia:DhO8mLM/*2mu9r2)%[*p*@A,d1sqPkhO1i^K>LV
Mf;:]A:Sd$[dc<?/$S&+O0&@go%bE)-Q4GW`YQ#&nnMkUk(PJR#\!ZGJ\6**EWoXQ'`1.^udB
s'^dbEi;$XiWm1ta@&p[X(r;+t&^%nt49S@rfN-Nj94!ANYr4ZA'S^L@#i%>bXF=)Bfjbu64
,cEW(rNi7`OL=JnAC)9E?Tc=&oe_eL1eTQc$1ZHfmMcY%+n7Xe-;>I#C1ga`jNFsWZ$ab'E]A
-jMJG8M9%hpc,p#S`cVh\BKmfl1Fo"^A,4j#O9,UeLF$-C]AKp,4Rgr_BCSeTbp!jhk&Hp__H
-AiV@Lhdg!Li6?i[Sls6nDRrf=jpFbF0%^0,++b=3>aUo^@.EWQ3"IRD):rdks_rM+>g(t.G
/3;&k"_<ABKsP[L#<\9'tSEXZIM:T\Zj7O@>s&M_jP[]AB4ON!C[Aq7S'YA(cH=Caue3@q(a,
arJJ!3'aM1ki+'#FjbrrlDAQ\ji"I4kX!&?`)1<DX4'o4oXe'",hW-5%(OtTH4_IX>[4Y&co
Yl#Qp52]AopW`UrCLqdM1[Nc-QhQU`5@is9T&SMDXQ*H"8j:Y\CeH>spZE@1kFcdF$IhkLo1=
8-<;XM(O+XdP5I%,@3--QQ?=V<_8i1N:lW=O#3t=^7;mTY^Or1fQ+c7+^7lkk1B\'[TSj#^^
;.2X9Cf01h5(Z$T8kk6Q.KuFl-E/Xl(cc-0Yj!od_74mO^;XCSdDH[jm.--0FDOTM'.]A3P<"
g<:80S&4K[M/]A@/8fQEm3,g`t0b67U$*TX7d8%iJ<TPZK06MT,=1q9\s!hGMVQ?iX6QF1QEe
K9aRn:_QS9,m+cVYjBiALYc-;,s#R`Wkuq^e=J[\REVD0Q:MsFHO-k7tROFD_V+jN@dV@i"N
<$m\c:3US9an,gU1qM/WY@^FNN[?Y5;$9`K32eU`)>L_IDOP([>U*b!7fpULaEBn1hi>0Vb^
6Q=7FO$bP,\]AV<m<QJLuqFkeQn0``r;EWUt4pJOYI&BOpO8J^aS_@Bo]A"QsT"V_otpU(ZRaV
#c!sWnRI>t8D:`^\^:q$HCBLlbsO"6#,5'8C_Gua>^Bs?S45>gp%ZNT3B[eZ1Vut3<[c+?)i
BNkf"C.#^m?6Y5mY=CKqJp\[Y@FAd$um:J#J&:56R\9l>X*VJEs^'"C2>d52-^'JQi10Ed&N
4fhr&bG.,9)aSn0nGUo@'D^$2.X=/m@XgX1P&=A4jTe:_KCeXOqeD:UW3B7H53$%hK'fIUZ.
Q:Z[[sE;s+9Mpi1k91*ZKkIJ+_Q+t+Y:-_3%MIR3>fkp-9R@8Pe@UQ=QGE%ror<a1n8E8M%S
:Xc>@3)E+bhSlON6TePMu:79hrr?WMd'$KPB-0^@2&O-7IEd'.sX)Uu)FN,@[^mBQjt`jQ1W
1me7ZLPG;=Dh8[4$S2qg+s@>B]A@6BF&a7qd*837h6f1lO)qRJ]AKN1$ZO2%GU6oS3_W?L]AQ-O
rA62E)4D2J.l[,V$ne1hgB`IpUF-Z`8lXhsD\T@^^''fZBMfN7+CeVSLd:)eGQAjRZNfh.V?
$MuYDt[t0(PNrZjCG^`U>\<f2@G3edSAD*s\(7"NSo%\mOL<_)a$)5O2'*<]A/c&0H8'k&VB3
Hk?=3cm7eJ)Z=0)idQL@1$Z*;/eGWkP`C6K;pBDH"Tl9Q?09Idh-"Gm(##iqD)oE0<Z?>2'l
K#rch<R>cSV-hG,=CCr5fn/)]AD(8AJ72k>!P"3aR\#(gfg.=uuW,W8WYB=#*T7Y-)$@",kbI
iPqkWG>UH#1EDMu!G<cpF"X1/UsaB^("U?OZ#&AO\SeQUGpk5tVJ'go1L_R`qe!dJ)roS5MZ
Olgo]A'=X6\'%PRf,##3OJ6)S\N1MHoZTD/0lUI^pQH`/=CX#Rkf5</ia(qiZ+Qk9.d&-a^=S
ak)BUS<SX,l$;RlSWiT]A0&\f4]A+5K^_YV-$[FTXIZkb0=XRX.)gmo(TO&[6PS=@%/L`FLJaV
;k+ElZ:PO,;bgFT^s4^>/'BDrE9WRmK'?GT<G@2r-Xq&bs4l+[<F:\:>Og'S6g7s.l&[\krV
u)VqN2ZC@sfYqSE3JS.FMtN;#NQjPn/K7>XoEgSQ35/6N$:NWtIc0W(br`L_qYlu]Am*#$,!b
%JuiA;1*IKPaWR!3s%>W#.Et+f]AEC5b5>*2bR[#o"5DgC6nAco@&',E0fDf$Dp?'eT[n:/&3
=Y67CVqUkeAhd"4m]Abkka$.H?1U<4S'"W5$NquX?/s-`Zim!.Nl`X1aXi.7NSe5XH=J+DJ!;
*[-C%`d%jVWGX-Ti*KRW\q\*K2';dJWX(=+)DoKEEcXfAcenU[6[5fe:PrKK`qR+5"a_NSYd
eB+eBr-&LSN1gmDY?B7(@4WtTOPHdfXNh;5jeF0V_W%1+SOi3j,Jt0mg@u,@%*pqpntc_01o
GK`Q7!oOHlZLpNY%e[Wo-G8@mG4_6D77UsEo^=2tSO]AC\LAn&kIH#Rfi?0$W]A_SO2Ktj'Yk8
&0"]AC;V!s6nSV6P2Cc4k&t:*M4Er1cSu/2bV&"#mWf<.YAeHM&>O%7:gkmD$l3l>Z!LPfE%D
EVV5ZV/LW<$r40OekL4t&cl8-V0##)uQsdo(]A>T2-b0X+nuOcJWQd%W+\PWH8tl#BiOP9U]Au
@(O'Vh%,fS^XV)3>Y1c^2,FOZ4F%uH;OH%[I_hQE*YsR!f]AB;+p%_`aoY?B>gQcB[]A]Ajs@+W
^d_*MW?s)rPL7&O,kR2E3b,4@M*(Ve6\\*H:.Ce.THbpalBj@<FYgc'k33fmSY"ecU;LEH)e
ZN'g?m2DUbo0FO#MM.J!&K.(Rs*@%Yp+du<MAnOmj[p@iHa\C`?A@2[!kX.rXVRMK;CIeBB[
o2l_7_Q"pFnC=c)-s=&0(=)qOqW.lT!dG6:pX1t$4X=lJ[:14`#PG#[6g=+^\^o17jNjC2JW
&^[;;6"41@bLl?at^_KLAH6\9O!EB3Tn'a4@$(+Pfo%OGf@".'Wb0q%H11C8JRC5[;^b-Ai%
pi".0D]A5+Y/&-s30XW^5S#`UnK\)?\6999>rGAl8gCZE_$r+G0KH(Y&>*bs6*>ueM:f(Zjo\
*LFDF4^`g1%cNSYSmF#mtKmikN=#fA0sYpqIhGbe'T$r<`Lk\/BDG_FIjC`>O%#8aO]A-#e).
oO]A,",)nopoKJS-Jk08D6AIKOhIAgTJ"<,u"==UUVmPu<P[7hAkfCY08"!"_0K%5n",(me=p
*]A6N@,=j'/O\662TQrW$!o%e2R%$^&"`^UV6S`m=G50;__6g)Pc$05CcsAe\&jmUCcoCn!JH
>8s'0:qVO">lk1jI0`Rp#q2jSkY\PU%mnRQ("tMn,pE'AQS,472NSHS>c`RJd\@)_\SgK[+V
ABOi^*:LF!f.4^)kC"X?;3DHS<]AotI/DPHDHne/,&e[]Af30ZfG?;^2]AP#49m+EU7cgZOF%uN
3j[5<.TV*2WnO7mII4e`e;B\UP4p`\sS+0XFfQQ6^%U.==Uu0Y2`dE(Hc6['Hhm6UPIhV+fD
>rI`dBX!P0ZrC5^=AT4ZqLKm[Jk[j.$=(=7<8`BV'8Z&0<e^-h-V8RLo9B>gXZaFGL"YCtHP
2NKZJIDV:!09D!G'I]A'BX>MjH,9YU[-/'=3-1*[+[lDCN]A^bA.Dj0\J,8)M[O&2[p8E$c*^e
grq=,nSP>O@#V/XmW6+h:aJV!bkcFgKK$>*-t1;tC@;)[$Eu5E*Gg^+^dm+N8=IWa&N,)cdu
'Iq\k(CFtU</H\KX`^4A.5-(5qN)obs_1G5!ieU#_LF)*fc#<mo$<cROje-.W/s>e?^Gu6k+
ff@40[CpkcTb!S1c'U=QM#B1NmWKLj%[sgk?If.h5CRmbb^9"Xe9suUoBB6TPqjBBcn(@gP"
%:7TdBXGRZ>ADK_BJ#\<rE4H1R)UXtU&VZ9FDQ^L9\lELK*EY'dBCeW0S&EmEu[CtHCjl(qo
Y.q_5B>=aTklVqJ$H-R\>+EOpi,7VRj#^X%gH3dMj"R/BcdV'c'6fd<EaCV1#EpVNIm&Y#Q,
Cb^&'/++a\D5AYBgl>k8'Oo!*sDR\(qtiQ`7t\4_,=D?C^abkh43kB,rS#i5[WjSl./%!/)8
MH'O`!]AU<eSr(VEs%IZDlE/up6H-k"[A83M?=Pk:77Z)Kh")D#,&?QS'W=`E!/%MJ)a1Ytn-
Ir&e/JkDtOri>6J&Z`7/kJ^-7t6AG?KQH,k?d63ddBT;QnM#E"l;QIjjj[cESeQoOYP(82^E
`>ma02_hB(P=2L!Bo09".T5TU"Ti%H0m\DW_%3-ko!6Is9/W?4;p)QgpGpM>CO(K$).hh+nU
jP&tkS[0$H"24aoR8#t5>cFc3A>hX=QF&V<;]A';s['^pEa9un06m]A^72g[cWa)i;GMLV/N6W
G0M/r8JS'Yb:g_jaN>j=;nAQon(cO5<Si`W3Ag_Z;f'Z5m@UgKCLinW.l._%eu1<k0G4a]A.7
Wnq[i[_lb)mN^\RH1dg*\.);F(X<"LI"cc80)"j6/l1"EEZKC%5T!EMfs!R""1L%h+j`r/R9
`R1O/UG-;QWG?H<dcbU-Pl;9*\r@<ETPEA-E/b_A"H++M>ANWST/&1.R1q8!q=I,il-*cED5
6CLbfW6J(6<&ZEDD=5rp:>r#0.[?j:J\D&bV\(#$d+0DJjh<j.P`G7d\2o!D>HDNFP/5bFlf
GF"24EihnV6k6Co-lG1_7hF8]A%>rhNST!@QA='l%-Ll]Al&/j_YM>CfjUPpL]AI,>U!Y+u,IVp
3rJ(V&%Z+GK&:qT+"L2__=(LHeW.7Ch[W=J,QSO->Q[qjb\B,'u!BSs8G`5('3d@ClhMX6J9
=5+=l3=QWkKW>=7.(LS&VWfSCCnb]A#Ad<\(E#eMkpcSpm2'P1&LK4eF5BP8CO\>FS%)Fg0Ho
+e+36;U$^$h19hhq)UtbAd_L\IKk&J.rm:&?Sl!_i>$W):l/?)%g3=Tm*"]ADgjIrU_L%%1&P
GFW`r2Ij$6O.AQdq+=97D@MC4?0"EDbnm[pF*iL9h]AH"Q@?'KZZl#Rp_X\a\BfFSh9oi&AHf
r.V3oaq1>OoJ0rGT^)Fkbho9e-)i*#[X8uZMN"G1U]A+$2>PJ$:]A"cB&B_M8M18k3:GSMP-@a
RK*P@0D8_(7,Lc)<bSWA$P/QTmki?Qur\*#341k)b.]A\WP26nE"G4U)mP2Uc??C^Ei(tl$'(
mCDd\CY:'hIi/kG6W.!m,_:Q%T72R]A2c`Ne0feJA!;5W-cLuP5*r2kgJct\.,8Gn@6'MS]Ao$
1J<O4q@pFGhYHtJ*fVM]ADMt"p*T7fB.u_c6GOAX^!!tr8Y>_An4(@/qlW2h>2k&8kj(+fDrs
m5[:mW]A!XjetSBV7R*3N+Rjl-MV@KN]Aan<C^Vm;/_GXJesdpD1-NNplpD709D3-nAl+?c&?g
=/IB):8oEdLf:8jDJ48oe.^'=ii52<@OdXH9PU6]A1)//tY7,!RI4<98HI?6ZhJ_,hA!aA1-[
0WGG+G)c/]AJ?Tl#36JY*]ATV?^!"#F@C[ZAP<'pftJX8%hor=QjR2&n,)eS<!%>>"A?J`\8\H
gd.Ckn:!`&>rakR^FiY!H'V*_<d?Nm/n.1r2h:qqA=-K30EQ0EhH>Pm-$L?Mql_aYpSRg0tK
$`Q6!TNN._hk<lV&4@g2$al@8PJSE#.`F=H5((Hj]AU'i%&9Zt(qt:P3te!9lhU-d&F@,el0K
k:5I%?Y<t`h"I9%.apiFCE3(AP^4*OpGZcn9T\ioZk#(i(tF6fjgG>9J9E5h$:(2%.14B>_-
PUu!Vr=%Xe)+^J3P"1e7LRuN<U[q#A@IK@$Fd]A1pLV]AnLS3,>biHe:J0))rtJMV=pS%@-E+Q
hqV\]A!sfW[8^A?;2ZEW,r1l/5bn)Oc0pE#QWSl!`\TLcSlJW[:^9(%AP15cE@P&gaOpt7i^o
J1s*/E1,jRI;@"@NlE`c.k]A@pP\W`R\lc-4KX9Mk;\a"Z@0_gG#E1GIFD=M3Z%k4As6Nc8V3
H*k*001L>?/D38/LaD>^Q=G^'iVurSdVd%K$`cKV/$lknAO\T-&F9&=\_K@r#<YMS=j'tl2L
*6BHA/.ED@2@)147>5.UL[e"W:)Ueqn*fa#P6<9W`=SN:>+i\H)WTM@WAhG1Qu@`(k`@EGk2
oHCA#^N8"^h1Pmu*OaoCGJIj%L!S;H\H)c^P#_!S=[H;W7<'\a2Qk'mV8mCNV;sQF89MY,n`
*&fp[7dL>GI97IuPp#nbX=cfs]A7^PQk8P,SED8O/aK)S#6(f4+j%j;:4ib"INnGqA^V!m_>>
_#?Kch#QurrYi>=tH#fjV_-M'uB$rj4YZ'G#ZR&2"JV*=8E,@'Ka@u=9i]Aj(?kI/26bWo2a2
4W5kf<9On3aWc>U:a".4+[YJW^Err%Q<?[_!G\BYP8]A[*cKY/`^>[=[1Sit`8-U.-A?2"&p.
"Kqi!"Z5rj2dVZq$#)huRBE>/)chuH>SM>5pF<Tn,W41qA]A'MANpm<Brihn!W"lI'I\L1+m;
e:Mrj'g/pe['^;+J*0bYrC>P^(Vdp%S8T)V>ArudPR;\"If,.m&Z9`*Qe8[lZG3?2`eOnAWF
P*jk'%BR($&cX)OQk0FZG/Z0oDh'S6V:No;%ED`MLj'U3XDPpD<aD6td;\d!sq!kqs4U6ZQ[
gF\0,f*DClBL_'l]Ab.bdq2r7qY/GuX,PSG^GM>lcKg9[Mt2f!4F4TV7p3UI4j)"7=OhSr<N1
CAeYm4+J@O=sMkJ[Rmq?P@NuDbZt.T=Z_UB<Y/@YiMM`?6Vb+$[8iE_Kc$V=pdrMH#MTrjc4
j3^@kH1Ffgq5^T_*Ba`rJE$O8=[p$A?F5(?_n<j4b$gWW?cGl0j]Apuad^*n(>i^UHcD$IBiM
^3^sg^hSS#,M*NaAi%$WOHVf)bA+(,("9$o@0U+ZckqdqGpaCYOQF0nac;U?3"^57``;;mUQ
X]A^4EsGu0Ofru`hak*gS\S"524nT9"oi(oX*:Ue#K/p_OVZoj%#gfU;J&/3beo8-9_8tV6o,
WD7Mr*#)aY$#"D6$UYiUO\qNq0,#LbgF3E0CFSt3$8n(DmVG1/RRa&Q&$HCVtCnO-2Db^*;h
G[BV,$$%&1&^/&J/@tamRGV&)<;\Fgj9dnVb`Epl=Q[0ojLr*3gLj&=SLqa#M`KqSqQ#Le]A(
MOS.KNe.?EXdqEub#RtL&Ln<+Y^%X$e!#]A')fXlm<2L?i(C=RBcIZQ1JIk5M'L<Q+KcX8dfR
BDo=QraX.\^@UiNAub3qY2a%bX[2tU7NEZ8!A4(I%'N!VQ;s9lF2t"`MQ7lEP2K+t&iG_^b!
<NM"(YseI6Tk*0oPUL$c0(9f8L1R)-m9n!**=M6AG[H,XANs`4L'uf[ICMesel6l^QVMBn->
r^,mI7s%OACL<%<86e6dZ!_uKAY%(lb=:+jB<JU%4s)1pcP7^9ss%3PhaaK46akUs"6Q#sTs
+pLo5[rjkUgYL%HGk[9R2;R)R6Z-a4DuICSYWrXF:UVT6".+7rAa,H^qK_%N(BAGc-e_^.X!
M290]A6PcofufVa4DZNXTo4Q`c:,T+;%[Y.GRn64<b>g;%dc=0l5YhKl!V3dUgBqBR1$e$_:F
7on@5+4nL7+ZC]AH[8!07EJYIp!L=g6HD-D)Bj-Ogq[@dV(Y!)<o\1;9]AQi35"sk)Sj#*1QnV
PDhjFE]Ak*O\5c5QS.kSQ*rt2p,pqZ)&RECj/OBrVN^u#dL"to:9FM&hd6"nnu;Y<$D,B>;ZE
4k=!1:F&/eOg%6bqE/$Yk:p9:W1tS'Ac(@5u4sEFD"EEX9Vc.XD/gM4YB$RUHXCln5/S:@&R
\:KeH!>*USGoHr=L(JTd<(W@)07k6Ka):C8a/%.M"RJS)h.Ik]A[t`G!RQf8YI!HKVRKH`2&F
4jp'62]A]Am>^#B&5BpL+-tW?Mhg-UElQX<0@q_EYC!kRJ)MN0]AAK3R2#,m4+/L"naitsr.Hf(
KJZS&._OmJ1PWb"8NYoTUI2(W*8\16X<Q',_25EHk&G:ieS.+4f+,'8>'Aun!R#t:?,b*4m<
=#S!&Sgk\]A;&g&iF@7P.#5X?<b*LRi*]AUic`0(b%82k@He9g#[pL$k?e$,n"U/lPHC./0siQ
gk+gIb0FO9+q]A>Q]AOc"hS]A75-T:\K_K[q[lFJPVB#*pEC"c%f;?Ipb),s!VL#MtQFD:=_VoN
64GV[1mTaS/*1i^P`H"'^8EACpl'/+Gtb$6[bW-rO[(,o!T-sT\;9CksNsh-*2U++lCM"(UV
?u^gB&6`MNY_QBSg1G`o,fb,MKf5+JR[dASknf-A$,bb^3qIH.4^fVTNAXd7_6H#U+AooH^A
D4^l>D%nH:h@KPR\_n[TN[!m'%)jp8Q!>E,6"i^t#f%=+]A7nj^4qH7l]AF-EiIsH`FKu/!Mqd
Fo3oUpdAINk_HWG>+jmD]Aj[r8U/J;mKqu)Q'SV!ahC*cUH]A``%1t]A!glM(ku2E7oEfEq.gO1
bFkGj,pHC2G2;5=mM^ZURR!l4K)mh8R/gO#sT@81^5M`%+]A5bb'A=/IhlAau&SWQ03;c/.\\
QYT2N#r8c-@HR-]A"Zcud@mV5@#eYZ'pZaBs!ogd`GXFl*)bH4Frs*%W=nkcMuQ1/LA`WZJ\i
f*iF\"oad%W,kRY:mo'C,mRl5Yg/a1=UnY]AM06^oBj&3&8Uh1p7;((2Xm,^T(Ek8e%=4eO#&
UecWqO,i>rSMR/IMZXoZTZP1=NNi?9Id*:;+m+\6&lu7:n>#CK%p\Y[0]AG[*K.3E:Xq9.D\0
8AuV/RXkCuRPf\%#e4,QA\@j&?C1]AK$2ErJs4o\h?84W8enO=`+/YGYNUt[siZ)Iq7i<oaQ9
p]Ar)N)R`;^Cl=#^.8'^dOg>E"#IO#6N<'\=dQ0WY\mN]Acso/6/_D6hi9U4VLo,HZ/NTq0ZoC
Sl>Q_Bt43Ym"<(C,><6?O^+L@:3]AkY!(bn"rWoC+,h52fRqRNF;WiJ[s-Ud70^`!+q#bP5j#
QN_\^Q,I==^oFW?pf7a@$jA?8bm*I!ufg>noY,INMBZgBPi?&XYaSp2N0F@:Tc"sX_"nJGV#
;r4'<H-ajX#5\6'rTf\]AcVW.eKb;2mqME\ji@!TTAqRqRZ>/ZU<,&RsU-58(gH+Ns_+87=ZY
)9MS&\6Wd8?d(c*&*fd^5m/RoFmBS.Ep7I)4/7hY=4Dq96>p.P)L1pCS@@qn05V),#>Prdop
<a*8H?a'g5rW!"C+B.MgPM["bI;WZZQ#gGT>'ZnBgns>[/j($QPa>g[W=a@M_U)s2mnD!sp*
ie:b\s0BsYFmo"n-M'pUNJ=i"TOoA$TRD,!YDEjk79'k%-9W/8jVslf).l>Vq&t+)q_a7p);
i,dbH7DYP'X\G<j2:8g/.93J#b/?mdq$X2+P+9#.tsg\iJYfLtsCZkX4(26r\Ll04bqc2'Y(
*&"F<B4_@XD^>u<@Z!jA;`=NS0E2.12)*sYN(F5T@rBR%`<3NI@S7G+_I)Ac!V8iHU+ucjKS
8;49#=9<F'LGa`*qb]AI3;%,"'H,V#QmY`:YR2f$L:t'OhNk54(A>A=%1X0Hk@+a0I3%g_9pj
%")R?&-<Shebh6H)b4_)+!l7NW?]A$D-:gTo\cQij-``=+-?3cs5#t="KiV-0mPB@\9S)`gd^
nk;#P'ijZJUo"[2A"l'lGJ/ka`Nb)bLK^9fV6`--_YkU4>21%2ArR0^Q[31l1)Pj,p)0JYHH
":'m_m+#1"=3U+KojaS?@r&7Yk1+.Dc7-7XL;Uuf;DNV7UHKgq+iaFo@!piEu:]A0>0nY_Lid
:R:bR:6>`.2)XnG&::<;g_7[LD?XkJgS2V)b6Kb;@.[$X!/#]A8GJH3K6655?\*%$^7rhB&U&
2$7OF"H%8?HMDh@.5#W\A0&Z3G,@-[M4+CGG?aT]AhoRLX7@n*j;bH3>-n*\L^*%KKJ>H<MCs
87m?dU9V(Vcnd#!lBA3lAF"ZH5LD;nbMA:CNhi4C5ONjLDJj@c+q=QKBk?FG]ADm_YmN0!kma
h'CGpcMuK&:(:?*Y'2_mL3)AD98ERLPti:"8%C-l4UU82aS_0G\0EG)k]AS$>!GG6f#K@KNVm
ZqAho9^A!['1?:O_j@9j('_tsc=K\rn[AD."@Ama`D*)9-:hJq''poukcH1:0Y0Q.$,Sqg5l
O?@CCnBRL@`cQU$^-DTLkKH*+/GkVo]A$UqH0s1PjL[bqdA@38lMuTbg'ki(9\\d@kZ*4;:%^
%kgc/l,*Zj1'<r5e>')6h9-MW&j=fB=LMkr.1`ZheGQ-^nBo[0/uXn,V.ZW=;FC^E!X=mX,#
cDYi\7B58Ks1t!B:;kRl"IIJa*]Aj3pb,-0n#iC5n?Hl;`j;,.2W9(3ok,XD&H$,Ue4Use)5>
MnZ0F5OG0SP]A@G`gu9$7YoZVZfrJRjoI-/[eMdMAgP=h0PHrc-MkM/WaGLqlhbUJ`t>,RHSb
(meWK9&7OqOfmcu?&HL[TNle#$8Iaajf:D9,<$BP[)2m0Cu^(NXt\1:.:#k.AOi:Q+s4fQ$2
:Q@BJ<#09<E_TmddEN[5c(UJ]Agf;Ren(iGb9X2$T#kHLQ5#s@g`ne]AARlb:>L4R,:_$)P;jn
1m;)bGlRc3b/or^Of)HlrMTpcjD2^@IlrG+r>=Aa2=+;I^*aKWefUf9I6t9uJ"SM)NG)r&Mr
!PV!O>45@/%/2$>F[6A0$!%s0IBCcauS2#l=e/H]Ar%;+6c)!MBm$J1kt5]AKm1rP:>2fQ33M_
kmn%D\YSn>tl,9;!+\<QG>8>U9GX\6c)tG+;&U*5e3bdm0=k"W^=.V=]AetG2RN+A21A3.ME,
$#[I$]A<d=(i$^=Fk#o6dgr/JE%LSP:+^eildWFod'gFR)&acg"\)(GDTYZp")>EU!4Ag6W>F
#"+XA`:/H(@U"r%*t9&MZI2,f4%Au/.%B;WmSlN-qQ&W5"r\K'cU@c`EBM:@;Z(n;;C(_V9:
NYR.gWf<ReX2mGGs(io9G4X]Af`8[D!!(?E`IH2UqXFqQoEI<A!1i*#o$J5/56ZGbf4uo@od7
!Uh*SU7'n$+,\^Fu/]AU94).ZAu^T3F]AdVJUBCqT&t6o+f8g\WC(JGo"dCT0L'P@Z\^DMF3&b
/:F\=cG0Zlg:+Eh)%Fg1+R4ZhXkBK2TpLJnBP=%-*W6:48Y;/jcA??&oq_;ntZ<3]AW4d_Ip`
4P(.*%Hd;&#QQKgN?'h.o-7KRsQPo&IM0(83T[m(1?3TY>Nn./U\jkh=WG$r,d9I`4UCn9IG
qG_5SI_k<`C7f&PE8\jiB<Rj\#0IQj'6"1>AD4\fR53^9LiSZ_hP9]A;Tu=>cAT"@c>TcbD<p
q*\TPST,b"kcuaE5T*BGtVF"Yq:4ZC=K467pG<aS]A=tXr[1EATirA]A-gaC0X'oqe#qnV[pYb
t\_Gdic%/YP;iCbSZl9'!L.`g<I_;7;hl-PGdp6S8jHGIKG>?S??*+Kk0Hb@K=PW*=6W:510
I2]A`'c^*VZ_XAHKtE*eN&!ODKNf'G/?md>>HD*<I\bG&Y[Z?i-laONF^romD43o2c/Q&?:[H
E!.U:[,Tus_cddXTq)bop0F168s2e]A[D@PUs,,fu4('Uj"8i+?]AQ(<%7A7:Oc(AF4;kKH\/D
&pisfA47X*pBBteOt!+3'6*o?9%./!p-ka66^%Kpg[W/+<.F=<LG1%P0s?p8;MtlH@Z(%mfp
t$Jj7<\EdH<Lq;!KFMQ(=qtYneJeR5W\=Tl5<!>NfH&Lj5d$4[+]AOX>pqTd(p4\>Q]A+qaF19
WMqqM\hu$.FP0dm[CJ,f3FGl:,7u4R;[7,kun2kVNr>jh0osCT#]A4<&\N0O^Wr+q(@gl)"B2
XQ#!KsoWRDp((GXWLZ`?Q@X$M;p!1(^2qGlf:CfPK3.X4n:6UTO1$7<;J-WbIpS5`[7ju>_!
KTFA#G4Zr%LV7'ntV[.M$GZt!'6FiU_agBrse*/-Ln"eP\!qJ$oP_f.@jEX1D>8(2566SAP(
b'J_'%YB4m=aAul[rs$NVT?/7qG_BCPX!9>5PuqtM+(/QXBK%$]AUk8OnC5Uh5*rjH.))c_iD
&k4>Ff=UpLTJjeZHWHRUrR[2GB!o+Yh2)lC"dRaPsfS<?/DHVC+[6DL<*8BLDtK'DTC!+u1h
Ki6%)hd@TU?6V-0V@G\ZjDj%N/:NsR,o//\_\&ZP[R60R`@E4imO:12Tr7*]A2"RMPL#o^]AN&
RNU2[n"j+onGluK30s$T5Hm"\-M)eT[[hG"^3PL]AO"i'7Ic[A._uM#4D]A-QPJ$N\CL$sC:*M
#J<R2P3]AHV0_p$Ob:mKKu=*=X9TALQ.$M6BNi!qnY1UCB.X%umo/ZuY0<dR#hfL^Q9!&6jka
V7fMDk9S^kaisRQQQ]AX;;f*U9'gM_A)-I3_kDFu*UZ!UF4h0iV[TV4NGgkd.3+uq,*P14J>I
"?G?OhVl2Q9D1`1MumXODF(a8$p>`lIFJ\'AW_Ml&"Pk3tF01Y9[V1qEfjbDc3Hp_0"[`\8F
ZA+5%Gk>_H7K-H[0?!:4.a?lQ'^<T0H_]ANS#`Ur`==h)("M2s(L9T,(P+MmL]A\'Qiu*l!tVT
q?Q23nf(C2a'EF??0c*?CI&Oo<s2_ia'6q=`n$W^$jc5[Mbe+<fG-Q's`$&cB^nGHG?rPdo.
OZAH-f%[gkaOmM'[pW=oAXRq7X[]A5J1tHn_[aHXqX@?]Al`%]A-LU>n9I8-4V\P3#;RO^Vh]AAA
#^\rFXXgj1!,ric*b,cTYh4cO>^1W;`1G"R/JU:_]AU!8nJj0gAL@]AnB1j+gC\o/*+0&aQrbb
4%PF6@sRn6IrsXlQAtrO1/r9j8hf]AH-,]ACtRf40^cN1Vd5:tn^P!]AY35bqg4V<\gKa2b>qTT
c#;%0IgtBAu'^tP12EdYF8^3r/Z.%q6ia%eJ3I*d^T"J%"-/r$,6"8,Pau'bN\_r8^F5l$XE
:+`l\0I.Do5Fm85S5U.hY^^Ga8'd)=1ao2G_')ojE0pPC#erg[X0majL3k-IsqHJI4-';[iM
<?<V8F5[[s.DLK>GW:rAH+NQ*)h@"X]A=8q)P2lL:XY'M*l/PHu#g>s)o?(]AB4V4Lm'r5[MO9
LRT??LV*/[hU`FuP4TQFGH&0&a99K2c;]Ai+.EVRBEM,hp'-?U0ij-N3RnPt.l^-/g=k,q3p$
13`N=N;`Hp+H>`X3"d'+\`)&r\c8G>^ttSs.-lSY?h>n!g`]A*9Nd,ZQ$<i)u[TH=[WJGHeCE
@qZfYuT1G&+h;pIsDSqEIEGR@@`MW'`?]A[^FhCp\XhjB"Dj#LctKsa)s/78h98hTV\`1fUR7
t)^@QtLqa%GQut1N/(O$0Z;bGm#0rp%/_!X-c>5"(&#K0Wj*oq[Yf87RFggpk'Og5]At'JWAQ
&-Kk]AfR?5.kqpfU']A`]AU(Ss5GaJqMci&=c'`SXlLi>MX]AkY9r^[_LmfFOU<P>5>e!Y2%,:=(
7,gDNX6iTiSa,c7`7'4%,btlJ956A"q`l6([2RZLVudhJQ]AEb%S#S7O3*H!AAjEph+"6W;2n
R<'p%\G:SRledXlC/(ZTUMBV4H$_Ht9+6#HSC,5?C3Cj]Ak^:&4C]Ac]AM&(j*!&sLVXU5ChH2$
8ocS9YO!.+_DqL2QO\0qIa8",f0QJ-C:WmJOjK&6:Zi)0>_6Os7j#'s^,6VgKfhHlFOCCm)`
*HJ+oMdKuY"YI!pr=WU/GSB:VbpSZa\WeA"HH'$HL-:=cN<"+bf%a-7:S(t+\X9]A!Hjf.Ck(
lb5P0>c6d<&Fhp->qr?.@u#n3^l$\>3FEInJ@cZuLk,ICsjp%8&X^Ou/a`BL$,KZEIBq64p_
!VoAL9lN&h%H4&/$$rB+;<K2aU/Z1?H3OrA5ip:9-Zl49qF,K6bK0jlSFW&U`Y@d6=u(^Mr)
:!4S7+#"J_r8+#0,@'6!S\O5:a/eZ74gern>CCa?(4sZc4bW3iobHoGJO&Y-tk4qE)cVH+;#
qn0SpO0uiADWUV1c$?K&2F=pDP8kb0A4OV#5G,e\]A)TCqTL-\i_-ci'@'X-n$1sPaUGt->+%
^&%PAk#X:G"98ALr()uZpi8fnb+J4js5>_eqB&g<`<.TAN$F9R00!7c=e?+0FcA*KPXn7;Ss
%S.jT:e=f-_Abn;SC<Lh9nlA3![)'0\od2jlV.jpe+G8!L`5qrVKM("]AV)O>."`tL1=^73.T
F0;FXF,5X*=g.6T1L.@!iOb3AT?A0r39)A?:2FhbPE0[_Ao0C.?OdUWH!UE/FN"l5&!"8J*s
fk9.Y[Bm=Ek`@[B-Ljl?UV_-l;*dI-r`82PQ%CCVL@N7qg.XI+<ArL'[ep;*6Fu'_]A71LNf[
FMdC846:sdN4LjS$BCg/l2#/9\Qh^E7@%PQ7,gmk?<+Hg+p5P)6`j6^9.FbJ*Q'(cMG`FV%k
uCoG1I4O54!@QnFbT=Cc6h9=/RGOWM0H\KnFeSn@K8Ce)Uj$jRiU<&jP1WrE)?=t^u;Y9\Bp
Go%u:1,NQdO@*DU%92U]A"#@oS>#982Q+MFUXN3n7Vlp@.o&0BBf@KCufH?^r.p7eJjC6h\K)
D._s9Y(%CR5TV)Go\t<q'Y#e+1Q;&,*Drhs?_j"_'U@8%E'U.1pNDZ`l`*E#*]A9DoBdf=LRI
N-!%=Y<eR1:j(TV=ad*r0\[VJ0nieL,!XF,&s18]An-`kn6>D&ujpr\%k!2J/(:BdH2E>QT1b
`mKbmB/656h2%p\nat_V<^Jmh'\NqMOfmgeT3b1&C8ppEp[/Cf,V9.(gbf,>%^U<@ar`Zr4/
8URPOmo=ola%3B*``tq4huGjd69$kD>h::k4tR>3YdZZ5X:49_lC`X_*NU\pr\$*-[A]AinG=
\AA=$E)FhK+$:6P[5#cR>3p*Xh7(.CJ2L!Fs62TB\[[j2?Z%bB?G.bn&"%=\W=^l0X[3Cp_'
'Eh\OMiT:\Qep3mTf*Q<#G#0cIH#DME*<Fo4/n@4T8-!TSWVj$Ku'3[:"=cq3ce!22^oj6W]A
RGh7@#iqZ`uJjTJRn:7+2;/eQ&j)+tRf3V-+1'YpO[/Bi8Dr/lVDU^"%hh'Idj6,/S4J;#.J
=kB:MlU>%KeXNY^a9u%6T4nW"(VVq6Bi>7!SJMd$J9h<OobcQB%X>cHf4"Sm"5_rEC-((JQD
5sA<:Wg_'a>H+E2FJg(@na8C+m/.6KmTenKAo66Oho9$hc&WLKjJ2hcq*Ha-<HH2rAf^q.jV
c!9&G@QL."?5/hCkZ.p(\Q5_rKOKHQ#N@>M^Z)[5(I8Uj<:<1-r#"jboNDlf\nUV%WX'li?_
Q"uf-f,*5M!DIgUJOii=iC$lFR0I(mAo>Q:o;'1#rX_#jcUFd#=*;D(?u"b\$BV4a/="clOZ
=gG?Quu6B(._2fqU)JF$8+>9BnJ(nWU/;&_\4MM.f4K%(rYG8i.euF7,&E7sS9uUtl,+_kY]A
SLVa8jf`H?jZu_c!^H,T=0\OE(P$;tU2X7TrE9;FJpg1\Y^F;0Vl?=Wnn0B@b$QJ;k<./$<e
S3rUC*qO^a_qQs(EH^T=jg9lRj^-I3-lPh1,WXU!2PD]Ad3&P$M`N4]A&-n"T+-nDX1Yo#c@$u
9`3V1+_Q)%U52MkJ3=0R+1Zm0tsq?__8%4h=+^05PYmG(PT1:Ld3`&C11Xl3(#-0-9iI<QQd
9c=O]A=`jD!itFJn+eS(4I$U^DD7L8RpFrb1rtXNAbQE,.e,DkPQ*`=&(.OaFM<=.XfHt1"h]A
5/<+'lrVDh#%"j24e#JNcYk,YQ3<1:i1UF9,>nk1!Odo`MgK[/Y^_F;kdp]AmBfqrt(P<N>3f
Lh)&bV?"HnjZO4sO=5Ipp6teCnnG3>46L1PZW!X-_R=<kH?D3pGHN!h+*cd+>E*I;?,3o?*e
a.?NJ?C)C/pgMuI&Am+Tun0_h(=r3F0d0:33#V_Gqe_H]A.N%PVk4dZLp\5oZlgAJ)tQ:ABcA
a:G<"J-,.!p$hm+_;"[kT9c4H!nccO4*#pS7H$%-(?&.c=nW&@Hq)bko+:S0J77Ta!2bDbBo
f4gDJi4Lmkr_%DP\+j1l43t(*LN\pl:Z_#RT6"lYo@'[DGO21j`SY0(-+oZJOKNH:#47_0^!
ar57s"N53QVG%-*c$.a.DhkOr3P'*'EFF>P)hBS0U;uH?2=<pboBs4CP\DIsD1[?rtFNS(7<
.-%"A7jgg8tf^koIUk.;hKU=RmX)c!k`sWIG+n/E*J0S'l.qcGuU[RO'r]A,6]ANlb.!g,ZiN5
fUd<0B]AmeYc$:8VdfHS0@k?-r@Y6i("'g!%NPZQr$Ob#cL_jBV=C0#<C@O"Pm?r'KdqUYi3o
4p*aSA59nX5iK"d)7ISe38N=W+:mh=b%S]Aa@(DO6^7UC4>qna\)u62f$gU5&=lZ,_rg)M=8\
<E=/8k&>VHSr>+\HleDtr(]AXcInG,20=``(<-6Sn:7b54',$k82H6O\elee:@iqDDn<[?B1/
N]Aa\Ad)pcGkFTe08Fg&3gTu?WJB=EkWF)m[Mu<EWuqO`jMMYL,+>L4JWo)NK9AdO/[%nf&O/
s;+?<*/:Whf9B^UTX4.=kFI`d`SoKVq+Kj3P^"a(HhXjeX%]AGn)()oM#m"h2@]A4kahoVB*:]A
8""ShL&Wmp&ZMrSkK:W]APjt(s"<2ef=p)3?U!#!$OZ&Z42-Pi^`6`.G@?_"*NK,F"g$Onk!V
Mq!YBuNV"9`'C?CD\S4b%+V6B_4.UgG0XaAUUOm&L:0h%C^Z",mT87.\fGKLZ1>)lGG>iTYp
Rk[]A,IIfrCp_]A[fCWLZ9ED00egsF43KR_o(X1u#9akQaM_b9S[\>fh.$*(NId?$SKm@iHC-f
\t7Y2b*T=D8N,.,ppsXWCF.::bbOL"GnfYVUYO"8jS!k-^gqj'1LJ:6"`/r!7U_J3>pkeZJ:
rfh8bKZJI92/>c\8onCe,6Shhrpc7rX`\am-a5bJ.V-rnIhaN"-,kqlO-`kYq@[R=2,Pn%QL
#uF*2r7kUKD$fChpsqO<N-I[49+EYkh4("#>!je7l+iS$(G%S#6_pY*X)UURd#XV2;eFShrU
OLN#aaQ$5d9Y%Su>e!9K^(SZpj=(PXu^'EIsZM!G<,&3uLO`juat7[ut6"$$^q3E.DALQh_c
a,sqLc`0p1GY1Qm?[f<1`%piuBUBQ-#!:o\n6,PU=lf&Vg:hZ)U=@C`,!.n45V1jFe,Upm]A+
9%<,lC85E6.6^ir5aW/WhJ8B5D39g-[HG_E'U'fVn/.'l/HZ0+Hbn/`0>r0m]Ab9f%/Dq\IR2
\hm!3NGh3e0\&s`f7OtYk02.T?b;i!h/!=)89EAYl;_lBSa)'W]A"SW!0TOXnGebcN^k7>.Q2
3^;M*>BVom9AlE^#VN:eDVj[oAIR*Ueo."QK<h=_NjIp_`q"9?V;sbD39Y&mWpN"eY%6%GY\
Qg4Z(DM3cc]A-W)XMLm%K[I/Q'kHJ\[Q'pU@8siB4+H!Y+LDOTA!;XA++C-3nNL`LE9*8ULsi
WV!'Q$@+\K,R/OMM%2&CeUd(URCJn:pYK;USCY*-G`iedZBrM,Ocp:FctBTUZXEIcgU^BRg.
(Kl!)8*r&gFOX"9_0`rKe@U-i/Ppm9F\C%84\#NVRP;c&PeiS"IPK)+",6]Akbr7?_.?^Z`^3
:iWD0kd@i#u.FOJtg\NXgE;685DCFa4T/Jo8`QgBcdQ:nj[5_%\XGM=t'#V?pX"a;+-3lB5L
DqgI3J3J,eau8=0uZ;Fb4l>gQI\$c3)r^Bi1]AS(1Tc[<Zp5h1(q<]A.B]Ae9FQuU:5k$hEuo\8
h,nb9-[Gn7bKoQ,8@ZmQ1':i,96e;Inc*OEkMLrV!"S5iKdjVc<dXi(L\o%Q7al/HlEc*94;
KRd`0O^\i"+D$`tP$ZdE2^k$!r2!ikc=-5,r*.\.0*nZp2<n3JHceR`?C$_^(0=Dj*o='q@I
gmc!KTS!;`c>%hpDFSO`D0'PX,f<etF\jYd>HQeSf!DfWG[rAkJ"j"Estd2X4LfJfCSeCFFL
5H_IttULo4b]AH1c.%*i_m9/N#2`@d^`=AJ>.f%@'U=+4ZD#JnB2:[Bockm08$ku_dFBs,.^%
ZI]AfcqQr,?a7buLnY5%!'CC1,dc\#s/nncE3T1(4F:VnloXCqCBoL&'-:hRc<`^VdkilGN>6
7]A]A70Q7JEEa_ou)a4BWYtX8^+XgNUhG^:9d!<,`;9LHXifP^GV@e5JZeDM12l3CKJd.b/'R1
Qe0:LLY]AEurU"JRkk2*1pa[N3"'f<8WWt*6@Qh;(!FdgC:[?B8BX)>mN%0Eoj]ArI;h%:A2"F
'Y+>5F61oo.Mm*Ca6b.Ut3;oi$2/=l1)P0R.,H>;M2[ipm"FT+pJ@NI\`E;de'ER8cqD@Y6W
9?&_YU#>-e66BW'9T&Y_^KAcmGC;3bf;AlN)L,UeOB]Aah1+17p-p*Cp:b"8n3F$l9`EFn"kN
U9uCRj?mB3e,="QC@!4/Pc@Fht_5WB"g,*Y69dc/^Fcr#;(aXrRWs=%W,NF=)Md!)?Of%?d$
CRhboLMi]AUHE'lJt.g#r1-#i6c)q;P3BN2Z.!d6#%Z++is,1.YH>ltMKG3M62]A?8:""I7<tF
:pHMWj7uXO6,UTr:B2X&(qip[;.@EIcQ7:O=2B^Z[F0IQrNr._F6j0E`D?%ZB9ClS"\.$eqh
MruHO/-In^e$Ck^BOr?`UkR_iP$rOXUO1aJG@Vn=%if"H#>o`?59^'W$gY#-p>Dmm_o3ZPhM
^h&FjeY66d_qAeQ,Y/"[)F!c=7Ge1c7j9`7!DsHqcGJY1B=D9!bAOKkSJsh8-m+b!;=c9.D^
1<EZ:-G9hKltpXX=)PO@>Oj-0&S&tCuP)iO<d\lm#dj=#4e59o;i,'<ejVHXf.3rb?&L"EPP
"Q"`;P;aN+3XXS9Dg#ua4DMN/9A9lABO2E#Zd9[WFA520_Iho31^dt.719$O6aLuY,iY&07'
Fr[qpN#)RrEQ#&o>'B<FZ\fQ`Z(=h8D.eF"?[m$k]ACq;6[B,%=.9\(0rlW<B<'_)"E"[/]Aa^
KTjJCo61_7.W(%k_u9r93cF,F60"XS_0u0^tEiSk2,h6E:S!Kin)&fmo7U[uj>00XC+[lXi_
Skh/1lnjgP(7L_gfn,7Z3eAY'0huTF/4,Z)LU-r3)V/:)^V8Onm>ENp@"&[F7.Sm.!:Kr.Zr
W\^Bs%cNCs+=PuJF)htc$TqFn-3li_Jnbd[uiee6W_sfS-F:GZtl7dEG8dgSAC(I*u#I+Kr*
_A-ZH?]AOK^O(bG`_[gshW$ZkNc"rA;[6EI$$6o+>_8LuP+,#4t\'F7.kW-k0eEOq&Y<iO]A*9
>N`@G:LFJ-H.pc)-Ym!:'lggs)jnt?C#uCgb`S_Mgel\U[*g]A_Y=38V]A8h9CfJ^&4YFesM<"
S8`"[)>W:!mF`IUb,d9VkA+HmZe9%4J6H]AGt/;1]A$t<K\fn17s,fm/WRKCTLA9b[+uJCY#Ls
(GNrfQ?m?)C1(&)onM2@+_mT$J"&HtV]A&]AiJT/_p)G9a\`IHA>[_<fp>^_9mh&YOCVhnB>Eq
=%f2mV/?!GLg0KF@9u,:/*H(/bV\;EkoM@'*p+JDc+'7UjBNSd':p8i7,Bd;j[(%a!QNr+g3
3k.%!qJ<QL\KlT)H%0FCR7klo$$YKrm@:!?%roGZiuF%d!aco(307Nn&;VKR8_P'q+7^!lKZ
Iq#hB>fW7ThCh$NGdJ\VHf63>Y%6>QBod(IE[RkIf8iHDgeZ#&$0kPAnk@^s)[0G1$8TXd]A>
0YVoXiXBN[H7WMOT[t_^W3Sh?Z@aEl#ha0q#N5EC;Mc<Dq_"ls<]A>a--BuPE3QuAD&pX1g0A
pjE$'QrCikT/4lCK9J[7A?m(56$8t<C,KL[$m,-fh[EYEYcd@)fbn@pBI6W\WF38ZG9n4+Lp
++l4UEnNZbH_fsRL.$[s6L6(<_Ib.bUqP)gHYn3*s(8@m7RDB/HaWeY%Bo)>HUh?dkh<SO-B
HBSG41//_5>[Q8]AND5Q;^RN.r1TQsuD[N=n/.>Bg^io$3\`jU\?<';\==4q*CtOZ^",W>08<
E`imrCd;U)Er*R")+u!62A27eXM4TJ?RDc8AH'!p4mr@c#2lW!/"8+&Rc7#hE8\ig-Urn9A,
LQ3*0\D"DJ3:;hK8*_WWEFiq?)_Npj_`'DYn'Y+FCo]AG605d[D,YE^1j=bf2u5/K2[u00NI9
`8XF=J71J)[r/\.]ActajcPo(g9deoBr0.rV+(#g,dCh5Ep4nX!:lt']A^?/\"Ti*Y,3OB`L`:
OU."B;)qHgt34RUY?;LD6&S@XU"l+W.BcA!GV^ql?KD!mC</L$ZIe1=!.ESY@@f<qQ;h;>dJ
!^*kf,oG6Qd_3hjCH4jj2"+TH^1.I]Aq0[_@1_EARPcD2jM`@%`&LPN.J6,/?h0"QE*OG_2E#
DauXBL7,'o,sa0`VfJ=4754ceRdX-u(#8e<fmatV*m=<nQI^8.FBLH*n6]AD`0K$?kiCh*?iT
doJWLj.6\>c%,3);NtV0j'igo\;olMkE3"i(2US?H+@;`\k&q"uMZF,pf!n85jR,Z*Z?2#kK
plQG?iZ[iTTC30p##':ssmhL<`!W=tF'c8i6(?PQ9pA#YbrEh?E*FJCMs0qW*leqdO0i>gfI
Hgg0pA_5j/3.1Z:VgeDRLf/]A;3Y"CXcYLNqHj~
]]></IM>
</FineImage>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="2">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$para_date]]></Attributes>
</O>
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
<Style vertical_alignment="1" imageLayout="4">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style vertical_alignment="1" imageLayout="1" paddingLeft="0" paddingRight="0">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1" paddingLeft="0" paddingRight="0">
<FRFont name="SimSun" style="0" size="56"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[buoBudeDVe4?^`nQ+F)cRC@@N346-#6rRNrMsIaW9q=9t</.K""YZe[Zs;9QV,ka]A$^I!&AR
Yl#@*Ku%.@!sA,st'(+]A1Wmi1Vaak>T]AP<nls,nE996rI3Y]Ap\Xo7J%hH.lg&'YcAHf]A/6H;
mldP6./6MC#e:Il((&jM]ArefUt*JFk:3/6nU^,7%0@&sleSsr\=1p27s_"D#V\oi;K[gS4B<
`-=KpZu2\\#jiWDC6E."03E5*^_JFrPETr.d&laNhH)Mh%&5OA'rm%,!Xp&^O8'pdX=L&M2t
E6*f6VFd%S@j2oCG_<G>Q0C&8#kQ'SsAm-X=B'>L1q7lp,<Zdu<3-52&P-1:ThV-C0VB;*C:
"W)8-A=RLcF"&ka@t9:Ner[!/aef4t!Eg$\h"m(3@<kVk;80%4e1IQd>E"XWDc7;jRPoAdSn
\.fE,BSfiAp8qWqMD=46tLPD3,H*2TI2uXEJjp)``e[^#Zb=e'4"B\o9/(-<]AYLVcIVSrA<R
3cV#19lm^&m-=ofF=O\RIELlD"^K2_]A0eJapc0\KZmX6c0bm;3%ZCKF%AMB/a+(T&'6Lb?9X
CeJ/QO2X8mh\D2*T$,Q%AAPmCO'5K`'WlLre3C!rbR0>g%6i5,rB,C!Y]Ak!BMGa0p'ourP`u
lJQZ7l_F),qfh7$4"X&n*Sp)ph&fYjHej6AK;/o&jEl>kC@Z9R8K[3>:)POCpe?U7glQcr]A<
@a=F4LF;#ShaL!H"IE/Z5R9#"@(?`8n[@s6bkU_\$iRAhc4+5haEbUuK3V5Ia'l-Y&U*X5W-
:%IRt>RYnNS6_cc[^E/+V8f26L`/$dN]A%bt'Z`iY%hd$mL9I\/ll_"/B1p*kKL?pih2aY5\V
$NLeMjcRsgs1^1ju3.[\26FpCW[U<RV]A13@iNSt/lqcCP#$se&X&bke)Z/q'k7n6&XA16tW$
T4Z)K4JEM1)+pkk'Dk'(.XZlQPuKs`8..R]A!UXL)SuQJ.2d73f2cJEf"qoo21ASQ*E0.k]A!Q
SM/<'J.pA$Mf'f-l">-(LA6V.#3FS.EpF4?&:'WlNcT*n8Xr.H'('?-c`8IdmgCrD%h3#Bd^
$e-In(>:U?^U&+PZ32e9p*2Q$MQ0o-B\iV5+kPL]AT2p=M_j&eRXCFWG8M8j@JOIQlkQTS5kN
&/T#hTkP]A=[.r#^Ms(f5r$*F9u<dp,]AOh\)(]A5m^TO7>^am1'!<`5<=/CrYTa#//DW/<OcaO
Ef>ad`,%X1$i[s0#MA3`R</di$;U!clX531V9H5eLb;n$d)`SXu5h(VK27UVS',i<[SuuTi@
qU&2eGL<Z]AbKs*H+o5&oI+VlRPj0c20Wh<MfYaCADA4EFTs9aad(+o)7!#gk%ftA0QTS)/[$
84RF\Zi=YHa901,Ci$[E9Gfi/Ob$8_2n]AKm=pOK-q8R73f$$jLbs)15$$/k%t0(ZtPj@F6%t
VbG(K.(f`0RXH2L$>1Wie'OMgBO-J$1Sg%,&NoRImXc[G'k/(s<7U/#S0%*,?!c#[>lfC`$q
lZ<L<5@9$Xm?>N*7nZMpMl4[ZD`q]A*,7\I\lDccB-bJ-c[;OT=uo$Q&De$V)V"q)L%fE;1/f
\eNO*j"jlKj,o=S]A:4<f%Z!;8r6.(H3/G4/#]AIr8GKiQ"'NIiRWqQ$U*dO>K[hI)UnIquJ&]A
j(U3_3X5^[u35n8PD>(!KncQ,9POuj[NsRCKSW@,%(kjcKg-%P,lY=bsada3mq:iHrnnI6a)
mq233hLH03K3U6P;UoV]A:I5]AGEZJKW:)lOTD@K;?=;;u7-rU0uZge2p?0^FEqLbF5.3WP_FC
@!B]A2,(GZ14gkj/g*]A!LogsET!cfM9VdfVbfNL&?l\>%Db\"sW_0&D-]Aq#mUX2fZ0s/Usqb@
"TRSP`O2#VKA_,[qjqrd2;UEWAu`T-eXdmr'g%1e?&E]ANI'c!UolD&:r_:c:,$J@*2^=*oT'
\#K9Golp>Z`>dt.d57fngWLp%_jRY]AZgn11"Pm'%1KdLkKJo[gP)a-gL@oW<o%VH#C?_TbhB
@G9FcRln;:_4*_AeHRXd]A!QVJuZstp:=tt/LQ$@CfkN-';k,bLgA"9_c7]Atrc30hdN'Z4LCo
M@JBYnj/!RGn&fhUb,hPHW`mR?70P($F$JYIc[`$Rh;HkSPK=:SR2cIV`r"dtVh[_RN_*hbT
#Z9Mo/L`=_,H=WJ#Qcmg<[X.,YY8.tQ%&;mR8ohV.(qr:0uk!+$d*b\K5`''Y]A%URE4)pT9Q
#%oeDkr2MEE`_1/e9$'N.h;R./TQ*WhL"jp9.hRB"ca+j02-]Ad&=lTVJ@NMu(tJ]ABr@PW$4;
#RPo;+C;Gj5TuGQ6QoK2DLMF>d35miLT%rZ%jN'Z"-@#):=\;V:ZUa6nL!i_#rIYO@8\:^F;
uLAYR>4f*ZCL/8LEXNg[aQ=rNpMLL7B^[hnK4#W/IqNhV)jjV75/1O.$A^0f66oJI_mLc%FN
G!(gqWg?S5rJ;du$IHU'8g:6J<:L^9*-,4.sl/fA/Om5GVV$cQI\B>cMU78[obLJX;Q6ru[W
DAL-:8ldc8]Ak6tX.Q@C[Y`;eJXptKo3msU"\q&VRM$,D]A:JBN,?=/6\=gu]A+H^Z6rT5]A\=oP
V\po)qigL^#5?i7bS%4f#M/il^>1[t6;L><nbG1.HK37hM#87LdbTpg@8EMj<n$7Klk6etY)
c4ZBYE.\uiUS24>B-@<]A<K?i@+/QGgC*XG`RmN=R1V.fFf:oi*:_3A%1-W[#\9k`?dEaC=`?
Ypd`1d@%e>/YZlGbi@XMTmhIiKl^sZ#`S"Hp@(>;G(ohgKPBI"P-*M;<oHS'Lf$T@,!U6S@;
8]A^"bTW`nB2_1@sin;=W+%dn\_d:!/Z<je?`-Ah8hYb]AOWY"!c;P72#tH2KQ4B\(oP7/IY`@
F2o/&c,H^'-GZlo]AU.t`cG@uqR;/<gMnEO8e4JF7M-$V(gFF`O?g6'O&;5M!XQ=VYb$0qL[$
pLVnN-du)i&"#01U.-FD\FoV<h2Zac;6<b+?2cSh[+f*DJja,R!5Wlc5(-m`/=mZ<J14o_0!
%,^&"]Ak/ueeeX#R?W1,qUliK8\o#ip:>f@%NG(rL0Ue3M9,f2hlBlA8l9Ro/qJfs9]A'o>HT0
81S\CJ(dHl*AJR+&C%WI3%=<bVtT82mHa2k.W-1.cKn\c8F#6id9f93:?D!.J'<RbiQD<=Uj
a,n5Qf3^_A_eDf5aJ)Fl]A/I2Z<;aFgb2'broC(Y?qbL-o%l3'3tUQ._ts&&HXp4T+>'4@D8*
B%Wci`e<.BB&e:*R*l1,oY[Xh?qQh0T*A0./gSnoj\iMC8OII^V8VWchNBM',Q</K[G'L1'^
kicbu@b9Q7&<5\hIE5=2*ELJK5RA-GR[,:?q`seol&>r5P(ca&TSia-P1oI7ZT4E:CdLJQ=?
K&`n",nns#gL@#*s9^9(2<o7C/<`#'Tn[JNN(C=@ln`WQl4WD@SVtq@dTB##JQm$?F:Y5\e<
l52CVeX%lQctEB_8`AHV%.%)g+U<;>s^aBEd!bKqAku\;*UBDj5ZkOi]AUh9A<Dh4lfsDuj2;
3\be[Wf0M\'3SR[>OKEVZV%1B&PaSG!%Q9El`$EilO8kePiAC`+sa@1Kb$LaBaLe:0n)Qu'e
a*5Xj!t\DJ"AeoF4COu8_lKj^.o,+TG^!\/%DL%^5#KfPYCc!m4m*-:Bh9;lS]Ak:,Y'\g"5r
$?Z4_s=(@kEMVT/]AMLEZJHl_</WsQD4eXdg$Z3=j%HM5.=2#\(.<gU,AE3WI'54^BrE>UL93
Cb2M&Z<$U9=-6MW<;qR\i7TGViXsiChG.]AO)dE#`%4HfTo3u6U_LEH1Filqm_=G<^Q@!XBV<
Ut\$Y;s^s+R7B4A"u]Aqj:?\#,tF?AGjnf,X%NtBd8ohGrU8@oi+o[B70sr8mFBOi,&]Aas/n)
N81KS5PP4\8l/oK4KjAp!k@MN<apJ28C+2^4CSTmq,.1G%aTA5HMe"dS@%4"9;9aWmd?lNkl
lC4q*.8%J?Wck4p6IiWbc5tDBN:s$.f]Ao-flFr1^T.omcbgB`((cCoDL:jW6XqQNI<qaOj0J
"Y*L`$Iu0k;IMiXPT7.8a?mUDfV7j5&-3jM<>rgdYRD]A_;<#OeoE@odm"q:*&IiBPW<![@ZD
(XLt'Gb04i>hX7s)9dB,kEP<FNr+uG0A48/J;6XAGH]A`.KXrWRo/:N<j.nG&t9C<k>VNq%h\
ajSo>Io,SbBP2"<OiIMRE.slCN,@,p*'!2p0J-h8Gb\VaRtFp&0e/G=b5pC(6Sosac@RV(/l
1f@$7&MEsTn8hfA+_^GiU)5"Vt"hF&i\5!HfoL/W'&,>%3f<o0uoVi]AEe*[BQ>#aTJZ-)t_`
BrE3Xq6Pn52_!!)-s3BGI.,,rlqI&MQ]A$">EUK(`B0YisALL*7m#qj(9tIcc=(.RP,@[!+c>
ljPf*dah$A43+8r-WFA=/O8dntK\O:O^N<Vbb,MRlqSKa;"2=N\E65IFN#+6X>oTBj/m*0.i
EaV@5"N)4E+?0KGkQh?:FMaj$khhrn8&,4=bE@nLCC,D^9XuMc1n+7VubmeCDKceIi^[shCK
;.ZcF`<I#CE'mH2NpfI^]Ak0'DIH!2-.?_).oQ/'s&$Y'St<C06q^/LA#TK(p=r@ohE3E!?U,
LF[u@Vnh4"tI<]A\@g=T9nO3U0@hh;\q`K:1odNY$+pJW*rlEn"gHb[?(Sjig-gZ27#L;p-Q]A
;'*%e?s@,H"F&8_U&Kq*TaN8oO/BiJ+3fYPn#+db\n02P\2"GoEGIQSg\p&_?aIN7-%.je]A0
G74eb&iH)jG7M^O6X'qM0qD9Zj&u94Sj7&8_4T_BB;H.bIn8.ko!MrfO,2Qb;NM1DLtYRoDX
:`:_2L+%]ARSostCPiu)2:E-tYYPH3:*5(`Sn_Iq&XS?qu1s1Bo/LCXr!l%oT)o6MM%?.i5nN
8MJ(.!pJPIR.k>#a5DI.:!RNBXQ"6\muh?%oto,IZ&5[2R@#&qCq8[.n(OkGqM1D'/<V557`
\1=$7!PmeGej%hZ\'W6(gLh7GSok;%q+kFObSb&H;Y?PrGCJ%9UP*QI=Qq+u@dU&N$`J/O)N
(Q8d7mf[S!%<dk]AlLWGP_[6lncfY0!nMU67`#!L?4RTP>[?;s34H\Q>ec(8h=2OESdfO["pp
\B$Q-\9A70FV=5SsLZ:t]A#2Ia52k0:k!IcTSgr<9GaapXVui7>kRiYr.rS09$F!OQISA5$7j
ENCLALm)#0LYVsBWeD4=!HRDQoAc:@O=dKB=5&b5D;k#nW1<HWn^m+eEhq[$srA+@ZClsC>^
#*qrV2$@`:X+?i/pPb`[rU!R3(LmK_g%2J]AUEC0_oH*_KMp&h%5qDf1)"8Y"+TM+?:b[.'fH
in1XaCnQ0e\Dm^pN3h6[)*`2[UZR9L^cdLWQH!#/QgYP<'[?R4M!:iXRk!^5=(;]A-c-_*Bt-
aH>*2/`bNuHH'5oL3mP(^q)VPY-51X+\&g8biq:A9QaH#.oLE\ilmCFiFO\!O$/[i4#;$S@'
]AB04huJI?5dF/b1:D,H\kDZbM^A\g\ru'd=ZEt*'EA^Z_f*glg"r2R-\6m!dB&Koc*%"p!1[
Gn(ZlSO!>L6bYC*c)ee_;o%Er:%0dIgS&HH8FYpTLOS.+D%tHZ@ScP5=?/FEYIpgu[MY>kf2
(!)I]A/F?@!H;S.`\ReR]A3s:(H"_R92\8W/d8OtQZO8T#Gf>V>gZCtlJIE(%#m!.HH+A<6Ucc
TM>0oACTD*Hc_Ahi*LC-A8?U*Xj;>"C!aF*He`sR;U1Mc$``Ep2!!7oIZq=a/9OEPDHYs1>I
L$dBG%qj/$W,@&Y;:!MV=umHrTYHOsXo(,hi-F`^Hdt;@@<ML<)mP:k-lkBu5&^G7_4asm)&
PpJHGC'p0MRZ^]AW]AN=IMakGqqX>HDl]AghZo>eg^\qW<G=+QAm-QIE8;<+9#BY^uUfRh8(?66
if.RfmQ2,`8\2F;8CBV;/_4sYt)"B<rM4_GBr<(51#m2+Z1L=7PAR2MN`E%<?5b^3:4aO"Wn
9eCFVS*?k$,N>lJ"WONH&\1%7)S#Zp/Q#7)^5o18);a,a==/tn$B@Nl1hMn"pj#4C2u:YIIo
7^IDo(rDK%tZ'lG9<iU`T`AM0SVW6idX;KdQn#T%l;]A6V0o!+1C>+Fp!]A,B35?8arG"/g*/!
qMs6aNkdJFARhH+!3'0DRWFB-FdWa;S@;fCalsD\Kc=_eG5nCD\Vf8tM<$K2FSc+RB`d=Yqm
0:'[]Ak]Asp_=q*<is^CX3bR*WnR6>TqFg>X3H<A<R<6(-QmD42Cr.Vc^>6nd>?Xf7O$$;b63,
.QDJZ3RCrZr#jC-Leqeem7^,[249UgR*6AB:^%-)k:&Y80>Okqh%=JgkpYU%()g9u?6;)W/3
;o,DRE(MY.;G`tUW`\Cg1Ng/"5,sa3:+Q`>jF$tfgO)*-`c:4Z]Agh7igb&E[KS(,YaU[YW'&
c3gB)<>-bpXYU:Oh"QW*$fZ6Z\]A(#h6kjoP=5V!jIt(_,u^/C40pZY%N=rM]Abp&]A:jLaSab_
L#CS_NsF!>(*Q@,RtFLJ_V_"=W,5@:A!;rRk1^MmVCh;T3A[1lkAleFc."a)::j)dOME@&`.
O,=!CRdL2/<[,p]AKGY@#5(Jhcrk?7YB*=UP$.G"g9#X$mV,Vj0S<bJiTcRL%4R7f2>M$?Ji<
8;M9-?dTQaW5sWV&Brsqg6/Ma4:8G:a5m!`=&Q4,qa:.'NgENVj[i'_?`hOo\Z%dQ]A^MZPoL
)Phf$lkQbe@2i,6/g^jD)o;LA2DTr%<k(:m9A6Dn6+&D0tGS<op-D#@8AOC-bfO)*3_Dak[T
7X/RO)*=bKb7QiL#^T5QGWpc6H;IUl,A$NQn1`I9A9p]AK9H>1i/-CqYJcKu@-b7bu@SQ_Z:a
F!h$!@3EMa0JhdF[Qo_+;n6k;B0G$9?d.nL-&?EU85`87eAm[B:5Lf86Y/=YCS$+$NhqTG0R
UGg!EW\>!++%QX&gpGX7NE`EG)p!eUSR@=(n;%Y1Rc\^J-KlE8/TK?0[Clqf>^`W^BKWZ%/$
%ES6`b$oPhd^%#iW*3+HA%K\V,9[41[=+(9P-\ptL):8]AY,auI%f^0)d?7Cc>SZeBOjW+&[c
Tl_P-6O9P1W4G-YII."Ec<-dQ"6;sIN.rm)`Ol)9sU&H)5bNWHDg0>hYB7N'g3p[kh`s0\Dh
e#RB^E$7_iS<T!JUV?6>a^r?hV!DO0X?6idrV:RZJE#s=#g::E(AoHun4\*eW4&s4bnrPe`G
D)dGC')%CU6eU%Ep]A%'DdBq``G"i<X50&%JYYfq31L$=En?.r5g#`@Y\&eglPU]A`.\J-+2Ik
8=HF>em#6Zsr+PlNK_5cmK'H-0r;.I8dZj8L2dM`oOd%u^5cDhM(_m$UJ]AJUBA"-(;i81BDb
uhjT+470)%)mmWb2VdfbL>EAF9=i$Z:4N,fgCb\3$>M7@>G*1Kj1WM]AU<]A@q4%]A@i=5_u#`a
o"Z"luNk]ADZ5^u,'*K,:4rJ`s4aU,f("?\1dEMR>FCQA+jG!46aPml/7trmSj_sCP.d1jdb8
.=d`]Aa/+t-U"C1'WgdI8-_A:m86,Jn93b%ZQI%*VU$!M$>VEr#%JC.MW>DR/XkK=)MIgXkBG
3qjg&Ar9Kf(S2gZg!>1uNq=6Hj-g"EkU&loZWSoeVoL>l9@MpU%3$T@mMhDb^t`:qh<,2+:=
U;4ie3nQn'-Sf4^D9n?d[17'5[D$Y'Kdan>FAB``mH=@pV%B6`/2jo,t(QFB369\5`%jW]A"W
QA:9'h(BPQ]Ab3tt(!?QeSNt?(_RfHXDgXL?i,I)Nceu-HF8O/2DBn>Q<pR2&b_:@Nr.8,hJS
H<@Sd/S:VnD.FDao8(8!r~
]]></IM>
<ReportFitAttr fitStateInPC="3" fitFont="false"/>
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
<WidgetName name="report0"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
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
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[`E6nT'5&5DAQrDXWEZu7+J`mNO*V?jcrD]A]AY\G+^'XW#K,*gfTU90;-9%8s@edJBE'!!o+$`
5g_FD]A87Ta?I8mDYlQ-K:j-8P%YL!sk*2*Q)ENSX>g`@]AWVa*h-N)RIC!bch"lspV"<qNAGT
WfJ"5'2KE-HgfJ3s+T`SLM.o>L_V^/-8#^40n;[&%raYJaP"sc+[)j3??E$_jOC#^%G[p3km
U:V([iUcT-bm2Iou/j7P4s)]AZZVlc\h.L;\N+F.5K/u7bl(:6juD"$1J=qn8I>!-.OT&sN(k
<)Q#=>%QJU)'[mWRKXTIV,3CYHYRIC.0k)-RKf;HMJADEqXq+*uL61e)WiRReq,M>NqSL+7h
6*#2'36^6(D3GHU@6-O+ADqtaoVuQ3C\1;3BkZ7*%<;qG!2%?(&<>s;"1RZX-AgnYaQ&E<&U
G&`0qP1mH^#+>BrPiu)0W9FD]AFe@5eX/+Y2Tj7PP#AZVp719.]A$=En#Hirj4Up@.)9.Q]AB/7
>cK>hTb!1uSgNgKuX^7!k`T+A@1D<g0_JEb]AXk@_5g;TNfB2rqRgLU4.Ggi5LSc5MNP0@-Cf
F.&8muB46Zp30b;g<%3j_0%+Xu421e*C>_?Y[qYmU1uME<GrK+XaA+E*9'Jhn&l+X\XI#=CQ
H@:[(egWtDmY<f5Gc#K2D\=QF8Xe5nYQ]A;5plFm%&nmAh0ZSaO%^ETVTj[^U+OKB^'J!6'YZ
'LMb2mWPXMKZ%oK0h!2I/s2GLjn)[-C=9'T]AQuLD[DDl:PFsIFkBphohk42!+=n[3?A-makD
]A:C&IV)ZY?j8\D(US6s#]A7I2\)jU!&_gpo5=%E%e<tpBM<]Ai<b`t^Gkn*E0hn:WL^m5%gOgh
C<]A7nm?5>e8BBXAEErT:VMs48'';[iqZQdfA/C(@aP$-VDj%MAgFmb"%a2jTTrLNke1<"?B:
O5,cA\2D4SCFe&/e[c8"<46n&q,:+Ag$s*^V7u8o$XBF+4b)U>%R3M$m'ZMA@7>^NN+'!l&f
dh=@uq9k0J^7QV[LGDE7f0;(_CA3_.Fos0*g*CPi@gM4Lpm&#=+sBs*?h(SA?^M<Mt7eJn?,
@Jsn,0#XL8Z_r4&-+:NM+cd12gN>h>a0H"X"?24!5^_9:2)hCn&4@@@,E5RAGlON5="e@Q7i
p.lN1SLqd43LT!5T<&kjEB)E\I#0BI1tW,IXo.CstB,q3P?`F0)hpb+K'h7%&errr15q?Xjg
tGkOK(6b\Bc5tML_pZI_&p]AlJI@g@Y&-mR=*C>%r5e(s_m'T1B6D/!GGoRE#V%3n`k[YA)p_
AWsc<ud$gmFdKS?U,t&Men6b8HoQGlDJ</@DlXabY^5Dc.U;N)SpF/>U@U!PodRUqa/:)fCH
-L7nD#X4a"5.3A"=HAf,gQgKh4]ATu8=Kqf>qjOY7S.i5=GPYR(=aO_<REN=8tj[&uB5.AfZD
H.Rjf8IpbK[0$PX*--iL$q&8Z4.(GZ;Z@)]A99W=nABsn`k!U#Z:]AE0lj>(Rs6"d44:RqN%4g
fLI9D]A\O>-<=rL&f$o4KPcm\"t";&7#irV(Hr6&O$L,$8um:iltk_3\'blQ>Rt'`"UiLLmRD
>_5]AK=bn@7T'VjSGBhtUB#oQFWn]AuJ+&<?s'S\_aN4Alrr^TEn.9"@jY3M>kZSr-aoV7<#q8
+";]A!hdObgEWN"fHfU^0<3)G>r*9]AK#W6thO\%tpXu,Hf;9!H?AX*bYDIP%#6lolKp364pP#
cAmG/)IVug369\dub+Ha)X$1OZZ`&Hc2IB,iQ5Q-]AI@X;hPWlH;j\J4ubFRpGNOFgH5k%^Z/
AcXg5$s&@O6\MRf,C@5"!+b9%$Xn[$l@&"V=+ql$/!9S#n.EL3d6XT0.#\,k.IP,fC['a>72
Xb`9lJKET!q',Et2CXo$n)gF,f^;STaF(&s[^(eaDg\"ta`TejU;Gf7+d#TS&mb^.F@jAOW3
t-/_3>hW1W<MG,3@0b)\Uin</5qLb%#K;-&)3Xce6!YT^3PhY3K15"_XJ:#k2>r,m\d]AX6q*
G_$8r1/9:@:QTI.'_J)OMPb!8u1A8,hp7AD6>P_'/WOU.5r]AVMQeG;F#B%'Gh@%7%@ApK]Ak7
L1Wr\L[(SLom?>TXs!fGbO-?_$EhM?#(M!4hl<Sc6YCI&GGKA\"C6stM02`2`DRFXW+,LKf4
phBJ9faDXY#Vh4VFCSN'H$"d)og`T.4^,4Mr=kp@`K9Z-`7\999uLuD$0',n34:+,6_kBLi-
!$5PrrnX1c/KoHlcNW_@]AqH>VmGM_RoH=``5<LT(pV1ODFPHh1isU!qCY>QoQAJ5fPEn#2IQ
fk!IJ)rP@@">J5(..OU8o["9Z5P;.1OioqcP<6GrUM<=t'DsO2&O_4g5T$VJB]AauufWTd+<Z
IrAD-]A0]AG3TQn&IQ[u*8I>9K`f:P>*kAa9:3qVnZ5*ub/4tUe?i)O6]Aa/oWJ+DI%DZat:g.#
Dg]AsusoQX2E3IO$k.VZqd.4c8_u/@\j>=:fkc=D*nU%3aiYe-@2TU"nrj>(eS5:T-b-SG3GW
$VimHX#s;J2?m47fEMoad^<,@-om?TP6,tZ(l,'W>"[N:Fi>g4"jGfD7upSOn(Ta\OohsjhX
?g,"3ff[105(@2ktlMpTgk6i?5K!>3KI`mr/'?S0;2l<0:b5BRi@C7cG95#S3sC%I16++3hR
13ZL^8`]AjW`UHl"<)4DW1'CjjUpnf+2SXOGa!@n6pq2-O\?Bl8PnMeOASYWHDo3Z,bXLngo3
q<k/P&jsIjg,Of5i'fL*+q]AlYVNI)!Ee3(]A=b0[j8Br#Gg/9=8dXg"0OQa@!=n,B_f=rGaWX
9?/"+$)*CC`bFV2#+9oj/C+$!!gc`L&O)!"h,aJN*,b&MD0i6IUd&Fj\B+b=n%)&GO!S/'9:
)KT_>!#<$-p9h1q$R,L+-A&IUe9@6*L82[*0jF(*!.h?ZC3Y%_J.HjuoO(6IC$YqL%\Q,05V
7_Ya!0_YO>FkhTuU;r)PUk9*r9c$DAcHcGe(eG@0o..:,bsK,q;)N&+s4\Ho^D+O9l?V*LQA
cQ#!lWJbIXSLFFEuqQ>IT`n8mZB$sLdF<=!"0$i8mqRXH]A'<`95m.3^5AD&f1\!\utP?en>E
[2_;G_Bhs#^Z)79S5D=&sF+?",g%ko#=JHYQtqjHbo/<+oc[^D:sq;.HLJ:cnsH074XKE4?Q
#tQk5:Vi.6@_?5fXdi+Hn&]A3NYdXN<IUKH"NOe2DkEJUodDg35g4oDtf6g4Q[Z5SQY%*k?'3
rmG#+'^2.i2,i2Gg?=G,;NM*aWCu-h53+!!@\Ji"KKoDu09qPa@Y;rep"j`so44LIS**Ed*4
6aOYY,<g-$msA`C2$N"c9eJ,d-j6.Om4l7=?Q\.<26EB9\D-Vr#=lBWieGH@\dQ)S3er+D?<
Em(\T7lhK[1Dqe*$#BUR)^DG3'^nG2foB>MU1<?L:im&R$l[]AeoC"#V!78OFjXDU@r7bi@V8
6V:\X9i+'r`7JX5a,^G`YYT4`+-ASVUn\5kCh1RlUVCsTeD]AWp/..s_R^>?pJfV==b91M*rl
f/IRSHbWLXLE+i!?JJO>r&)g,uMLKN5<)\>2YR4=Ptoa&phIMo^beRY#&mbnKPilO=S66/-1
!I7BX-RC(j2<4JeQMV$A?n_"u7k9@9UMT(b[.431oOhMjC@(0F"@.TV5H&=("pj\0SgMcNG_
/dR[fTo[hImS>1('29CE%rKrK1'fBe`+Up\DMF^"fFH/K4LPo(XGK<e2b9S+tI;IJTt!e1/q
A3q&7_L9DNoaq'fe2#K<$jg;RrAhSZ&rr~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="373" height="37"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0"/>
<Widget widgetName="report1"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1440" absoluteResolutionScaleH="900"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="570"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="absolute0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="1"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="570"/>
<ResolutionScalingAttr percent="1.0"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="4"/>
<WatermarkAttr class="com.fr.base.iofile.attr.WatermarkAttr">
<WatermarkAttr fontSize="20" color="-6710887" horizontalGap="200" verticalGap="100" valid="false">
<Text>
<![CDATA[]]></Text>
</WatermarkAttr>
</WatermarkAttr>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="a56f2002-9ea7-41e7-bf08-b4cd4b5a7e74"/>
</TemplateIdAttMark>
</Form>
