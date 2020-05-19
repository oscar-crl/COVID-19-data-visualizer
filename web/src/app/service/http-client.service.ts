import { Injectable } from '@angular/core';
import { HttpClient } from "@angular/common/http";
import { HttpHeaders} from "@angular/common/http";

export class TotalData {
  constructor(
      public id:number,
      public confirmed:string,
      public recovered:string,
      public critical:string,
      public deaths:string,
  ) {}
}

export class DailyTotalData {
  constructor(
      public id:number,
      public confirmed:string,
      public recovered:string,
      public critical:string,
      public deaths:string,
      public date:string,
  ) {}
}

export class CountryData {
  constructor(
      public id:number,
      public country:string,
      public confirmed:number,
      public recovered:number,
      public critical:number,
      public deaths:number,
      public latitude:number,
      public longitude:number,
  ) {}
}

export class DailyCountryData {
  constructor(
      public country:string,
      public confirmed:number,
      public recovered:number,
      public critical:number,
      public deaths:number,
      public latitude:number,
      public longitude:number,
      public date:string,
  ) {}
}

export class LatestUpdate {
  constructor(
      public id:number,
      public date:string,
  ) {}
}

const  headers = new HttpHeaders({
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
});

const url = 'http://localhost:8080/epicovid';

@Injectable({
  providedIn: 'root'
})

export class HttpClientService {

  constructor(
      private httpClient:HttpClient
  ) {}

  getTotalData()
  {
    return this.httpClient.get<TotalData[]>(url + '/total', { headers: headers })
  }

  getCountryData()
  {
    return this.httpClient.get<CountryData[]>(url + '/country', { headers: headers })
  }

  getUpdate()
  {
    return this.httpClient.get<LatestUpdate[]>(url + '/update', { headers: headers })
  }

  getDailyTotalData()
  {
    return this.httpClient.get<DailyTotalData[]>(url + '/dailytotal', { headers: headers })
  }

  getDailyCountryData(name)
  {
    return this.httpClient.get<DailyCountryData[]>(url + '/dailycountry?name=' + name, { headers: headers })
  }
}
