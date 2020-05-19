package com.example.EpiCovid.LatestCountry;

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

import java.io.*;

@Controller
@RequestMapping(path="/epicovid")
public class LatestCountryController {

    @Autowired
    private LatestCountryRepository latestCountryRepository;

    @Autowired
    ResourceLoader resourceLoader;

    @GetMapping(path="/fetchcountry")
    public @ResponseBody String fetchCountry() throws IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        OkHttpClient client = new OkHttpClient();
        Resource resource = resourceLoader.getResource("classpath:countries.txt");
        InputStream file = resource.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(file));
        String line = br.readLine();
        if (line == null) throw new IOException("Expected file content");
        String[] countries = line.split(";");
        latestCountryRepository.deleteAll();
        for (String country : countries) {
            System.out.println(country);
            Request request = new Request.Builder()
                    .url("https://covid-19-data.p.rapidapi.com/country?format=json&name=" + country.toLowerCase())
                    .get()
                    .addHeader("x-rapidapi-host", "covid-19-data.p.rapidapi.com")
                    .addHeader("x-rapidapi-key", "51a98edd51mshc3b01a5112ba55cp1cc428jsn7c929be8741d")
                    .build();

            try (Response response = client.newCall(request).execute()) {
                if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
                String formatted = response.body().string().replaceAll("[\\[\\]]", "");
                //System.out.println(formatted);
                LatestCountry tmp = gson.fromJson(formatted, LatestCountry.class);
                latestCountryRepository.save(tmp);
            }
        }
        return "Country Fetched";
    }

    @CrossOrigin(origins = "*")
    @GetMapping(path="/country")
    public @ResponseBody Iterable<LatestCountry> getCountry() {
        return latestCountryRepository.findAll();
    }
}