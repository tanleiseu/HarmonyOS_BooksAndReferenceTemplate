import {  Constants } from 'common';
import { webview } from '@kit.ArkWeb';

@ComponentV2
export struct ActivityPage {
  @Local windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    NavDestination() {
      Column() {
        Web({ src: $rawfile('reading_app_activity.html'), controller: this.controller })
          .fileAccess(false)
          .geolocationAccess(false)
      }
      .padding({top:this.windowTopHeight})
      .width(Constants.FULL_SIZE)
      .height(Constants.FULL_SIZE)
    }
    .hideTitleBar(true)
  }
}