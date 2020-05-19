import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {HttpClientModule} from "@angular/common/http";

import { AppRoutingModule } from './app-routing.module';
import { ChartsModule } from 'ng2-charts';
import { AppComponent } from './app.component';
import { WidgetMapComponent } from './widget-map/widget-map.component';
import { WidgetGraphComponent } from './widget-graph/widget-graph.component';
import { WidgetDataComponent } from './widget-data/widget-data.component';
import { EsriMapComponent } from './esri-map/esri-map.component';
import {FormsModule} from "@angular/forms";
import { WidgetCountryComponent } from './widget-country/widget-country.component';

@NgModule({
  declarations: [
    AppComponent,
    WidgetMapComponent,
    WidgetGraphComponent,
    WidgetDataComponent,
    EsriMapComponent,
    WidgetCountryComponent,
  ],
    imports: [
        BrowserModule,
        HttpClientModule,
        AppRoutingModule,
        ChartsModule,
        FormsModule,
    ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
