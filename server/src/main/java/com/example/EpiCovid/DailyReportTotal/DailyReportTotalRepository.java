package com.example.EpiCovid.DailyReportTotal;
import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface DailyReportTotalRepository extends CrudRepository<DailyReportTotal, Integer> {
    DailyReportTotal findAllByDate(String date);
}