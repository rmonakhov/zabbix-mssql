# Zabbix MS SQL template

I presume your Zabbix Agent was installed in C:\Program Files\Zabbix Agent, so just put both directories in it and restart agent.

---

## 	Template DB MSSQL (zbx_mssql)

Requirements:
- Microsoft SQL Server 2008-2016
- Zabbix 3.4+
- PowerShell 3+
- Zabbix global regular expression "MSSQL Databases for discovery"

Functionality:
- instances autodiscovery
- databases autodiscovery
- log monitoring

--- 

## Template Module MSSQL jobs (zbx_mssql_jobs)

Requirements:
- Microsoft SQL Server 2008 to 2016
- Zabbix 3.4+
- PowerShell 3+

Functionality:
- simpe job stats

---

## To do

Add job discovery with following output:
```
[{
    "{#ENABLED}":"Int",
	"{#STATUS}":"Int",
	"{#DURATION}":"Int",
	"{#LASTRUN}":"UnixTime"
}]
```