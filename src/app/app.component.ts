import { Component, OnInit } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AppService } from './app.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

  title = 'Dockerizing Angular App using Docker Multi-stage build - ';
  appConfig: any;
  envConfig: any;

  constructor(private appService: AppService) {
    this.title += environment.name ;
    this.appConfig = this.appService.config;
    this.envConfig = this.appService.env;
  }

}
