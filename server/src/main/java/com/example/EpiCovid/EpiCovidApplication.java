package com.example.EpiCovid;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import okhttp3.*;
import java.io.IOException;

import static org.springframework.boot.SpringApplication.*;

@SpringBootApplication
@RestController
@EnableScheduling
public class EpiCovidApplication {

    public static void main(String[] args) {
        SpringApplication.run(EpiCovidApplication.class, args);
    }
}