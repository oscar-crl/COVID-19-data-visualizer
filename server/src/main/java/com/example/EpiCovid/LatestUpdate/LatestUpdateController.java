package com.example.EpiCovid.LatestUpdate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(path="/epicovid")
public class LatestUpdateController {

    @Autowired
    private LatestUpdateRepository latestUpdateRepository;

    @GetMapping(path="/fetchupdate")
    public @ResponseBody String fetchDate(String date) {
        latestUpdateRepository.deleteAll();
        LatestUpdate latestUpdate = new LatestUpdate();
        latestUpdate.setDate(date);
        latestUpdateRepository.save(latestUpdate);
        return "Update Fetched";
    }

    @CrossOrigin(origins = "*")
    @GetMapping(path="/update")
    public @ResponseBody Iterable<LatestUpdate> getDate() {
        return latestUpdateRepository.findAll();
    }
}