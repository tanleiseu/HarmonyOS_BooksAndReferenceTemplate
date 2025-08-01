import { Constants, NavHeaderBar, TCRouter, UserInfoModel, UserInfoUtil } from 'common';
import { CenterToolCard } from '../comp/CenterToolCard';
import { MyBalanceCard } from '../comp/MyBalanceCard';
import { MyInfoCard } from '../comp/MyInfoCard';
import { ActivityCard } from '../comp/ActivityCard';
import { AccountCard } from '../comp/AccountCard';
import { emitter } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import { ServiceCard } from '../comp/ServiceCard';

@ComponentV2
export struct PersonPage {
  @Local windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;


  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          this.headBarView()
          Scroll() {
            Column({space : 12}) {
              MyInfoCard();
              AccountCard();
              ActivityCard();
              ServiceCard();
            }
          }.layoutWeight(1).scrollBar(BarState.Off).align(Alignment.Top);

        }
        .alignItems(HorizontalAlign.Start)
        .width(Constants.FULL_SIZE)
        .padding({
          left: 16,
          right: 16,
        })
      }
      .width(Constants.FULL_SIZE)
      .height(Constants.FULL_SIZE)
      .backgroundColor($r('sys.color.background_secondary'))
    }.hideTitleBar(true)
  }

  @Builder
  headBarView() {
    Column() {
      Row() {
        Text($r('app.string.person'))
          .fontColor($r('sys.color.font_primary'))
          .fontSize( $r('sys.float.Title_M') )
          .fontWeight(FontWeight.Medium)
        Button({type: ButtonType.Circle}){
          Image($r('app.media.ic_setting'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .height(40)
        .width(40)
        .backgroundColor('#0D000000')
        .onClick(() => {
          TCRouter.push(Constants.SETTING_ROUTE);
        })
      }
      .height(36)
      .width(Constants.FULL_SIZE)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
    .padding({
      top: 8 + this.windowTopHeight,
      bottom: 8
    })
    .width(Constants.FULL_SIZE)
    .backgroundColor($r('sys.color.background_secondary'))
  }


}