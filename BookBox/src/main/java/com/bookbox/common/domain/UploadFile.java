package com.bookbox.common.domain;

/**
 * @file com.bookbox.common.domain.UploadFile.java
 * @brief UploadFile domain
 * @detail 업로드파일
 * @author HJ
 * @date 2017.10.23
 */

public class UploadFile {

	//Field
	private int uploadNo;
	private int categoryNo;
	private int targetNo;
	private String fileName;
	private String originName;
	private int mainFile;
	
	//Constructor
	public UploadFile() {
		// TODO Auto-generated constructor stub
	}
	
	public UploadFile(String fileName, String originName) {
		this.fileName = fileName;
		this.originName = originName;
	}



	public int getUploadNo() {
		return uploadNo;
	}

	public void setUploadNo(int uploadNo) {
		this.uploadNo = uploadNo;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public int getTargetNo() {
		return targetNo;
	}

	public void setTargetNo(int targetNo) {
		this.targetNo = targetNo;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public int getMainFile() {
		return mainFile;
	}

	public void setMainFile(int mainFile) {
		this.mainFile = mainFile;
	}

	@Override
	public String toString() {
		return "UploadFile [uploadNo=" + uploadNo + ", categoryNo=" + categoryNo + ", targetNo=" + targetNo
				+ ", fileName=" + fileName + ", originName=" + originName + ", mainFile=" + mainFile + "]";
	}


	
}
