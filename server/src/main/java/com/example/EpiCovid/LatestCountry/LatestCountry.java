package com.example.EpiCovid.LatestCountry;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity // This tells Hibernate to make a table out of this class
public class LatestCountry {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCountry() {
        return this.country;
    }
    public void setCountry(String country) {
        this.country = country;
    }
    String country;

    public int getConfirmed() {
        return this.confirmed;
    }
    public void setConfirmed(int confirmed) {
        this.confirmed = confirmed;
    }
    int confirmed;

    public int getRecovered() {
        return this.recovered;
    }
    public void setRecovered(int recovered) {
        this.recovered = recovered;
    }
    int recovered;

    public int getCritical() {
        return this.critical;
    }
    public void setCritical(int critical) {
        this.critical = critical;
    }
    int critical;

    public int getDeaths() {
        return this.deaths;
    }
    public void setDeaths(int deaths) {
        this.deaths = deaths;
    }
    int deaths;


    public double getLatitude() {
        return this.latitude;
    }
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
    double latitude;

    public double getLongitude() {
        return this.longitude;
    }
    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    double longitude;
}