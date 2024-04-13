package com.personal.jspdb.util;

import java.util.List;

public interface GenericRepository<T, ID> {
	
	List<T> findALL();
	T findById(ID id);
	T save(T entity);
	void deleteById(ID id);
}