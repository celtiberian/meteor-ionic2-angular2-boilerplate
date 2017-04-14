import {Component, NgZone} from '@angular/core';
import { NavController } from 'ionic-angular';

import { Meteor } from 'meteor/meteor';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  private text: String;

  constructor(private navCtrl: NavController, private zone: NgZone) {
    this.text = "You have not pressed any button yet";
    console.log(Meteor);
  }

  private onPress(id: number) {
    let self = this;
    console.log(Meteor);

    if (Meteor.status().connected) {
      Meteor.call('getTextForButton', id, function (error, result) {
        if (error) {
          self.zone.run(() => {self.text = 'An error has occurred in the Meteor Server'});
        } else {
          self.zone.run(() => {self.text = "Server says: " + result});
        }
      });
    } else {
      self.zone.run(() => {self.text = 'There is an error connection with the Meteor Server'});
    }
  }

}
