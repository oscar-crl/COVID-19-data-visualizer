import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WidgetCountryComponent } from './widget-country.component';

describe('WidgetCountryComponent', () => {
  let component: WidgetCountryComponent;
  let fixture: ComponentFixture<WidgetCountryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WidgetCountryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WidgetCountryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
