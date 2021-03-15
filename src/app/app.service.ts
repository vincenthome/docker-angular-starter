import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../environments/environment'
import { forkJoin } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AppService {

  constructor(private http: HttpClient) { }

  configUrl = `assets/${environment.kubernetes?'k8s/':''}app.config.json`;
  envUrl = `assets/app.env.json`;

  private configSettings: any = null;
  private envSettings: any = null;

  get config() {
    return this.configSettings;
  }

  get env() {
    return this.envSettings;
  }

  public load(): Promise<any> {
      return new Promise((resolve, reject) => {
        let config = this.http.get(this.configUrl);
        let env = this.http.get(this.envUrl);
        forkJoin([config, env]).subscribe(results => {
          this.configSettings = results[0];
          this.envSettings = results[1];
          resolve(true);
        });
      });
  }

}
