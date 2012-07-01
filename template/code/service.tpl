package com.i139.observer.daemon.service;

import com.i139.observer.daemon.domain.<{$table|javaClassName}>;
import java.util.List;

public interface <{$table|javaClassName}>Service {

	public List<<{$table|javaClassName}>> get<{$table|javaClassName}>List(int offset, int pagesize); 

	public List<<{$table|javaClassName}>> get<{$table|javaClassName}>List(int offset, int pagesize,<{$table|javaClassName}> param); 

	public int insert<{$table|javaClassName}>(<{$table|javaClassName}> user); 

	public <{$table|javaClassName}> get<{$table|javaClassName}>(int id);

	public int update<{$table|javaClassName}>(<{$table|javaClassName}> user); 
}



package com.i139.observer.daemon.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;

import com.i139.observer.daemon.dao.<{$table|javaClassName}>Dao;
import com.i139.observer.daemon.domain.<{$table|javaClassName}>;
import com.i139.observer.daemon.service.<{$table|javaClassName}>Service;

public class <{$table|javaClassName}>ServiceImpl  implements <{$table|javaClassName}>Service{
	private static Logger log = Logger.getLogger(<{$table|javaClassName}>ServiceImpl.class);
	private <{$table|javaClassName}>Dao <{$table|javaClassName:1}>Dao;

	public <{$table|javaClassName}>Dao get<{$table|javaClassName}>Dao() {
		return <{$table|javaClassName:1}>Dao;
	}

	public void set<{$table|javaClassName}>Dao(<{$table|javaClassName}>Dao <{$table|javaClassName:1}>Dao) {
		this.<{$table|javaClassName:1}>Dao = <{$table|javaClassName:1}>Dao;
	}

	public <{$table|javaClassName}>ServiceImpl() {
	}

	public <{$table|javaClassName}>ServiceImpl(<{$table|javaClassName}>Dao <{$table|javaClassName:1}>Dao) {
		set<{$table|javaClassName}>Dao(<{$table|javaClassName:1}>Dao);
	}

	public List<<{$table|javaClassName}>> get<{$table|javaClassName}>List(int offset, int pagesize) {
		return get<{$table|javaClassName}>List(offset, pagesize, new <{$table|javaClassName}>());
	}

	public List<<{$table|javaClassName}>> get<{$table|javaClassName}>List(int offset, int pagesize, <{$table|javaClassName}> param) {
		List<<{$table|javaClassName}>> list = null;
		try {
			log.info("get<{$table|javaClassName}>List(offset,pagesize) : " + offset + " , "
					+ pagesize);
			list = this.<{$table|javaClassName:1}>Dao.list(offset, pagesize, param);
		} catch (SQLException e) {
			log.error(e);
		}
		return list;
	}

	public int insert<{$table|javaClassName}>(<{$table|javaClassName}> user) {
		try {
			return this.<{$table|javaClassName:1}>Dao.insert(user);
		} catch (SQLException e) {
			log.error(e);
		}
		return 0;
	}

	public int update<{$table|javaClassName}>(<{$table|javaClassName}> user) {
		int id = 0;
		try {
			id = this.<{$table|javaClassName:1}>Dao.update(user);
		} catch (SQLException e) {
			log.error(e);
		}
		return id;
	}

	public <{$table|javaClassName}> get<{$table|javaClassName}>(int id) {
		<{$table|javaClassName}> record = new <{$table|javaClassName}>();
		record.setId(id);
		try {
			record = this.<{$table|javaClassName:1}>Dao.select(record);
		} catch (SQLException e) {
			log.error(e);
		}
		return record;
	}
}
