import { Constants, NavHeaderBar, ReturnButton } from 'common';
import { webview } from '@kit.ArkWeb';

@ComponentV2
export struct DataCollectionPage {
  @Local windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '个人信息收集清单',
          hasBackButton: true,
          hasBgColor: false,
          isMainPage: false,
        })
        Column(){
          Web({ src: $rawfile('data_collection.html'), controller: this.controller })
            .fileAccess(false)
            .geolocationAccess(false)
        }
      }
      .width(Constants.FULL_SIZE)
      .height(Constants.FULL_SIZE)
    }
    .hideTitleBar(true)
    .width(Constants.FULL_SIZE)
    .height(Constants.FULL_SIZE)
    .backgroundColor($r('sys.color.background_secondary'))
  }

}
