import { Component, OnInit } from '@angular/core';
import {CountryData, HttpClientService} from '../service/http-client.service';

@Component({
  selector: 'app-widget-data',
  templateUrl: './widget-data.component.html',
  styleUrls: ['./widget-data.component.css']
})
export class WidgetDataComponent implements OnInit {

  total_confirmed: string;
  total_recovered: string;
  total_critical: string;
  total_deaths: string;

  countries: CountryData[]= [];

  constructor(
      private httpClientService: HttpClientService
  ) {
  }

  ngOnInit() {
    this.httpClientService.getTotalData().subscribe(
        response => this.handleSuccessfulResponseTotalData(response)
    );
    this.httpClientService.getCountryData().subscribe(
        response => this.handleSuccessfulResponseCountryData(response)
    );
  }

  handleSuccessfulResponseTotalData(response) {
    this.total_confirmed = response[0].confirmed;
    this.total_recovered = response[0].recovered;
    this.total_critical = response[0].critical;
    this.total_deaths = response[0].deaths;
  }

  handleSuccessfulResponseCountryData(response) {
    this.countries = response;
  }
}