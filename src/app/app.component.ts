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
  appconfig: any;

  constructor(private appService: AppService) {
    this.title += environment.name ;
    this.appconfig = this.appService.settings;
  }

}
