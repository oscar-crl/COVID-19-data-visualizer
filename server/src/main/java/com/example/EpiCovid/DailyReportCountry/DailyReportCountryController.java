package com.example.EpiCovid.DailyReportCountry;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(path="/epicovid")
public class DailyReportCountryController {

    DailyReportCountry SendGetRequest(String date, String name) throws IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("https://covid-19-data.p.rapidapi.com/report/country/name?date-format=YYYY-MM-DD&format=json&date=" + date + "&name=" + name.toLowerCase())
                .get()
                .addHeader("x-rapidapi-host", "covid-19-data.p.rapidapi.com")
                .addHeader("x-rapidapi-key", "51a98edd51mshc3b01a5112ba55cp1cc428jsn7c929be8741d")
                .build();

        DailyReportCountry dailyReportCountry = new DailyReportCountry();
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
            String formatted = response.body().string();
            TmpDailyReportCountry tmp = gson.fromJson(formatted.substring(1, formatted.length() - 1), TmpDailyReportCountry.class);
            //System.out.println(tmp.getProvinces());
            dailyReportCountry.setCountry(tmp.getCountry());
            dailyReportCountry.setDate(tmp.getDate());
            dailyReportCountry.setLatitude(tmp.getLatitude());
            dailyReportCountry.setLongitude(tmp.getLongitude());
            dailyReportCountry.setConfirmed(tmp.getProvinces().get(0).get("confirmed"));
            dailyReportCountry.setRecovered(tmp.getProvinces().get(0).get("recovered"));
            dailyReportCountry.setDeaths(tmp.getProvinces().get(0).get("deaths"));
        }
        return dailyReportCountry;
    }

    @CrossOrigin(origins = "*")
    @GetMapping(path="/dailycountry")
    public @ResponseBody List<DailyReportCountry> fetchDailyCountry(@RequestParam String name) throws IOException {
        LocalDate start = LocalDate.now().minusDays(14);
        LocalDate end = LocalDate.now();
        List<LocalDate> totalDates = new ArrayList<>();
        List<DailyReportCountry> dailyReportCountryList = new ArrayList<DailyReportCountry>();
        while (!start.isEqual(end)) {
            totalDates.add(start);
            start = start.plusDays(1);
            dailyReportCountryList.add(SendGetRequest(start.toString(), name));
        }
        return dailyReportCountryList;
    }
}