package com.example.EpiCovid.DailyReportCountry;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class TmpDailyReportCountry {
    private String country;

    private List<Map<String, String>> provinces;

    private float latitude;

    private float longitude;

    private String date;


    // Getter Methods
    public String getCountry() {
        return country;
    }

    public float getLatitude() {
        return latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public String getDate() {
        return date;
    }

    public List<Map<String, String>> getProvinces() {
        return provinces;
    }

    // Setter Methods
    public void setCountry(String country) {
        this.country = country;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setProvinces(List<Map<String, String>> provinces) {
        this.provinces = provinces;
    }
}