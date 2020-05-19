import { Component, Input, OnInit, ViewChild } from '@angular/core';
import { DailyCountryData, HttpClientService} from '../service/http-client.service';

@Component({
  selector: 'app-widget-country',
  templateUrl: './widget-country.component.html',
  styleUrls: ['./widget-country.component.css']
})
export class WidgetCountryComponent implements OnInit {

  countrySelected: string = "";
  dailyCountryData: DailyCountryData[] = [];

  public barChartOptions = {
    scaleShowVerticalbars: false,
    responsive: true
  };
  public barChartLabels = [];
  public barChartType = "bar";
  public barChartLegend = true;
  public barChartData = [
    {data: [], label: 'Confirmed'},
    {data: [], label: 'Deaths'},
    {data: [], label: 'Recovered'}
  ];

  constructor(
      private httpClientService: HttpClientService
  ) {
  }

  ngOnInit(): void {
  }

  selectCountry(country) {
    this.countrySelected = country.country;
    this.httpClientService.getDailyCountryData(country.country).subscribe(
        response => this.handleSuccessfulResponseDailyCountryData(response)
    );
  }

  handleSuccessfulResponseDailyCountryData(response) {
    this.dailyCountryData = response;
    this.barChartLabels = [];
    this.barChartData[0].data = [];
    this.barChartData[1].data = [];
    this.barChartData[2].data = [];
    for (let i = 0; i < this.dailyCountryData.length; i++) {
      this.barChartLabels.push(this.dailyCountryData[i].date);
      this.barChartData[0].data.push(this.dailyCountryData[i].confirmed);
      this.barChartData[1].data.push(this.dailyCountryData[i].deaths);
      this.barChartData[2].data.push(this.dailyCountryData[i].recovered);
    }
  }
}
