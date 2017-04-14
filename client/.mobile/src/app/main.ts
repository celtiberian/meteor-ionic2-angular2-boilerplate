import 'meteor-client';
import { Meteor } from 'meteor/meteor';

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { AppModule } from './app.module';

Meteor.startup(() => {
  platformBrowserDynamic().bootstrapModule(AppModule);
});
