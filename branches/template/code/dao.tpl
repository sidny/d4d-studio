package com.i139.observer.daemon.dao;

import com.i139.observer.daemon.domain.<{$table|javaClassName}>;

public interface <{$table|javaClassName}>Dao extends BaseDao<<{$table|javaClassName}>> {

}





package com.i139.observer.daemon.dao.ibatis;
import com.i139.observer.daemon.dao.<{$table|javaClassName}>Dao;
import com.i139.observer.daemon.domain.<{$table|javaClassName}>;

public class <{$table|javaClassName}>DaoImpl extends BaseDaoImpl<<{$table|javaClassName}>> implements <{$table|javaClassName}>Dao {

}
