import {Component, OnInit, ViewChild} from '@angular/core';
import {CountryData, HttpClientService} from '../service/http-client.service';
import { EsriMapComponent } from '../esri-map/esri-map.component';
import { WidgetCountryComponent } from '../widget-country/widget-country.component';

@Component({
  selector: 'app-widget-map',
  templateUrl: './widget-map.component.html',
  styleUrls: ['./widget-map.component.css']
})
export class WidgetMapComponent implements OnInit {

  @ViewChild(EsriMapComponent) map;
  @ViewChild(WidgetCountryComponent) countrySelected;

  mapCenter = [2.32004103, 48.8588897];
  baseMapType = 'dark-gray';
  mapZoomLevel = 2;
  countries: CountryData[] =[];
  countriesTmp: CountryData[] =[];
  searchCountries: string;

  mapLoadedEvent(status: boolean) {
    console.log('The map loaded: ' + status);
  }

  constructor(
      private httpClientService: HttpClientService
  ) {
  }
  ngOnInit() {
    this.httpClientService.getCountryData().subscribe(
        response => this.handleSuccessfulResponseCountryData(response)
    );
  }

  handleSuccessfulResponseCountryData(response) {
    this.countries = response;
    this.countriesTmp = this.countries;
  }

  Search () {
    if (this.searchCountries == "")
      this.countriesTmp = this.countries;
    else if (this.searchCountries != "") {
      this.countriesTmp = this.countries.filter(res => {
        return res.country.toLocaleLowerCase().match(this.searchCountries.toLocaleLowerCase())
      })
    }
  }

  setCountryFocus(country) {
    this.mapCenter[0] = country.longitude;
    this.mapCenter[1] = country.latitude;
    this.mapZoomLevel = 6;
    this.map._zoom = this.mapZoomLevel;
    this.map._center = this.mapCenter;
    this.map._view.zoom = this.map._zoom;
    this.map._view.center = this.map._center;
    this.countrySelected.selectCountry(country);
  }
}