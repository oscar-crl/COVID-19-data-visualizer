import { Component, OnInit } from '@angular/core';
import {DailyTotalData, HttpClientService} from '../service/http-client.service';

@Component({
  selector: 'app-widget-graph',
  templateUrl: './widget-graph.component.html',
  styleUrls: ['./widget-graph.component.css']
})
export class WidgetGraphComponent implements OnInit {

  totalData: DailyTotalData[] = [];

  public lineChartOptions = {
    scaleShowVerticalLines: false,
    responsive: true
  };
  public lineChartLabels = [];
  public lineChartType = "line";
  public lineChartLegend = true;
  public lineChartData = [
    {data: [], label: 'Confirmed'},
    {data: [], label: 'Deaths'},
    {data: [], label: 'Recovered'}
  ];

  public barChartOptions = {
    scaleShowVerticalLines: false,
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

  public radarChartOptions = {
    scaleShowVerticalLines: false,
    responsive: true
  };
  public radarChartLabels = [];
  public radarChartType = "radar";
  public radarChartLegend = true;
  public radarChartData = [
    {data: [], label: 'Confirmed'},
    {data: [], label: 'Deaths'},
    {data: [], label: 'Recovered'}
  ];

  constructor(
      private httpClientService: HttpClientService
  ) {
  }

  ngOnInit() {
    this.httpClientService.getDailyTotalData().subscribe(
        response => this.handleSuccessfulResponseDailyTotalData(response)
    );
  }

  handleSuccessfulResponseDailyTotalData(response) {
    this.totalData = response;
    for (let i = 0; i < this.totalData.length; i++) {
      this.lineChartLabels.push(this.totalData[i].date);
      this.lineChartData[0].data.push(this.totalData[i].confirmed);
      this.lineChartData[1].data.push(this.totalData[i].deaths);
      this.lineChartData[2].data.push(this.totalData[i].recovered);

      this.barChartLabels.push(this.totalData[i].date);
      this.barChartData[0].data.push(this.totalData[i].confirmed);
      this.barChartData[1].data.push(this.totalData[i].deaths);
      this.barChartData[2].data.push(this.totalData[i].recovered);

      this.radarChartLabels.push(this.totalData[i].date);
      this.radarChartData[0].data.push(this.totalData[i].confirmed);
      this.radarChartData[1].data.push(this.totalData[i].deaths);
      this.radarChartData[2].data.push(this.totalData[i].recovered);
    }
  }
}
