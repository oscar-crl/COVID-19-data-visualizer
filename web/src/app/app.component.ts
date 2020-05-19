import { Component } from '@angular/core';
import { HttpClientService } from './service/http-client.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  title = 'COVID-19 Dashboard by EPITECH students';
  total_countries;
  last_update;

  constructor(
      private httpClientService: HttpClientService
  ) {
  }

  ngOnInit() {
    this.httpClientService.getCountryData().subscribe(
        response => this.handleSuccessfulResponseCountryData(response)
    );
    this.httpClientService.getUpdate().subscribe(
        response => this.handleSuccessfulResponseLastUpdate(response)
    );
  }

  handleSuccessfulResponseCountryData(response) {
    this.total_countries = response.length;
  }

  handleSuccessfulResponseLastUpdate(response) {
    this.last_update = response[0].date;
  }
}
