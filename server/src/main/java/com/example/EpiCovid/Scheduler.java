package com.example.EpiCovid;

import com.example.EpiCovid.DailyReportTotal.DailyReportTotalController;
import com.example.EpiCovid.LastestTotal.LatestTotalController;
import com.example.EpiCovid.LatestCountry.LatestCountryController;
import com.example.EpiCovid.LatestUpdate.LatestUpdateController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class Scheduler {

    @Autowired
    private LatestTotalController latestTotalController;
    @Autowired
    private LatestCountryController latestCountryController;
    @Autowired
    private DailyReportTotalController dailyReportTotalController;
    @Autowired
    private LatestUpdateController latestUpdateController;

    //@Scheduled(cron = "0 0 */12 ? * *")
    @Scheduled(fixedRate = 43200000)
    public void FetchDataCron() throws IOException {
        System.out.println("Automatically fetching data from API");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        System.out.println("Fetching date and time : " + dtf.format(now));
        latestUpdateController.fetchDate(dtf.format(now));
        latestTotalController.fetchTotal();
        latestCountryController.fetchCountry();
        dailyReportTotalController.fetchDailyTotal();
    }
}
