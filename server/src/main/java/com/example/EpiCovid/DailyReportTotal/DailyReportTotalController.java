package com.example.EpiCovid.DailyReportTotal;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(path="/epicovid")
public class DailyReportTotalController {

    @Autowired
    private DailyReportTotalRepository dailyReportTotalRepository;

    void SendGetRequest(String date) throws IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("https://covid-19-data.p.rapidapi.com/report/totals?date-format=YYYY-MM-DD&format=json&date=" + date)
                .get()
                .addHeader("x-rapidapi-host", "covid-19-data.p.rapidapi.com")
                .addHeader("x-rapidapi-key", "51a98edd51mshc3b01a5112ba55cp1cc428jsn7c929be8741d")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
            String formatted = response.body().string().replaceAll("[\\[\\]]", "");
            //System.out.println(formatted);
            DailyReportTotal tmp = gson.fromJson(formatted, DailyReportTotal.class);
            dailyReportTotalRepository.save(tmp);
        }
    }

    @GetMapping(path="/fetchdailytotal")
    public @ResponseBody String fetchDailyTotal() throws IOException {
        if (dailyReportTotalRepository.count() == 0) {
            LocalDate start = LocalDate.now().minusDays(14);
            LocalDate end = LocalDate.now();
            List<LocalDate> totalDates = new ArrayList<>();
            while (!start.isEqual(end)) {
                totalDates.add(start);
                start = start.plusDays(1);
                SendGetRequest(start.toString());
            }
        } else if (dailyReportTotalRepository.findAllByDate(LocalDate.now().toString()) == null) {
            SendGetRequest(LocalDate.now().toString());
        }
        return "Daily Total Fetched";
    }

    @CrossOrigin(origins = "*")
    @GetMapping(path="/dailytotal")
    public @ResponseBody Iterable<DailyReportTotal> getDailyTotal() {
        return dailyReportTotalRepository.findAll();
    }
}