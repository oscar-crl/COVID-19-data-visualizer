package com.example.EpiCovid.LastestTotal;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

@Controller
@RequestMapping(path="/epicovid")
public class LatestTotalController {

    @Autowired
    private LatestTotalRepository latestTotalRepository;

    @Autowired
    ResourceLoader resourceLoader;

    @GetMapping(path="/fetchtotal")
    public @ResponseBody String fetchTotal() throws IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("https://covid-19-data.p.rapidapi.com/totals?format=json")
                .get()
                .addHeader("x-rapidapi-host", "covid-19-data.p.rapidapi.com")
                .addHeader("x-rapidapi-key", "51a98edd51mshc3b01a5112ba55cp1cc428jsn7c929be8741d")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
            String formatted = response.body().string().replaceAll("[\\[\\]]", "");
            //System.out.println(formatted);
            LatestTotal tmp = gson.fromJson(formatted, LatestTotal.class);
            //Get total number of countries supported
            Resource resource = resourceLoader.getResource("classpath:countries.txt");
            InputStream file = resource.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(file));
            String line = br.readLine();
            if (line == null) throw new IOException("Expected file content");
            String[] countries = line.split(";");
            tmp.setCountries(countries.length);
            latestTotalRepository.deleteAll();
            latestTotalRepository.save(tmp);
        }
        return "Total Fetched";
    }

    @CrossOrigin(origins = "*")
    @GetMapping(path="/total")
    public @ResponseBody Iterable<LatestTotal> getTotal() {
        return latestTotalRepository.findAll();
    }
}