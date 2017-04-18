import { Injectable } from "@angular/core";
import { ObservableCursor } from "meteor-rxjs";
import { Demo } from "../../../../../shared/collections/demo/demo.model";
import { DemoCollection } from "../../../../../shared/collections/demo/demo.collection";

@Injectable()
export class DemoDataService {
  private data: ObservableCursor<Demo>;

  constructor() {
    this.data = DemoCollection.find({});
  }

  public getData(): ObservableCursor<Demo> {
    return this.data;
  }
}
