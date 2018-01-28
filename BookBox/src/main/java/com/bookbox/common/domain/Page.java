package com.bookbox.common.domain;

/**
 * @file com.bookbox.common.domain.Page.java
 * @brief Page domain
 * @detail
 * @author JJ
 * @date 2017.10.12
 */

public class Page {
	
	//Field
	private int currentPage;
	private int totalCount;
	private int pageUnit;
	private int pageSize;
	private int maxPage;
	private int beginUnitPage;
	private int endUnitPage;
	
	public Page() {
		// TODO Auto-generated constructor stub
		currentPage=1;
	}

	
	
	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		this.maxPage = (pageSize == 0) ? totalCount :  (totalCount-1)/pageSize +1;
		
		this.beginUnitPage=( (currentPage-1) / pageUnit ) * pageUnit +1 ;
		
		if( maxPage <= pageUnit ){
			this.endUnitPage = maxPage;
		}else{
			this.endUnitPage = beginUnitPage + (pageUnit -1);
			if( maxPage <= endUnitPage){
				this.endUnitPage = maxPage;
			}
		}
		
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getBeginUnitPage() {
		return beginUnitPage;
	}

	public void setBeginUnitPage(int beginUnitPage) {
		this.beginUnitPage = beginUnitPage;
	}

	public int getEndUnitPage() {
		return endUnitPage;
	}

	public void setEndUnitPage(int endUnitPage) {
		this.endUnitPage = endUnitPage;
	}

	public int getStartRow() {
		return (currentPage-1)*pageSize;
	}

	@Override
	public String toString() {
		return "Page [currentPage=" + currentPage + ", totalCount=" + totalCount + ", pageUnit=" + pageUnit
				+ ", pageSize=" + pageSize + ", maxPage=" + maxPage + ", beginUnitPage=" + beginUnitPage
				+ ", endUnitPage=" + endUnitPage + "]";
	}
}
