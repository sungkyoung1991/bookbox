package com.bookbox.common.domain;

/**
 * @file com.bookbox.common.Location.java
 * @brief Location domain
 * @detail
 * @author JW
 * @date 2017.10.12
 */

public class Location {

	//Field
	private String locationName;
	private double locationLatitude;
	private double locationLongitude;
	
	public Location() {
		// TODO Auto-generated constructor stub
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public double getLocationLatitude() {
		return locationLatitude;
	}

	public void setLocationLatitude(double locationLatitude) {
		this.locationLatitude = locationLatitude;
	}

	public double getLocationLongitude() {
		return locationLongitude;
	}

	public void setLocationLongitude(double locationLongitude) {
		this.locationLongitude = locationLongitude;
	}

	@Override
	public String toString() {
		return "Location [locationName=" + locationName + ", locationLatitude=" + locationLatitude
				+ ", locationLongtitude=" + locationLongitude + "]";
	}
}
