import { BookApi, Constants, GetUserInfoRsp, NavHeaderBar, ReturnButton, TCRouter } from 'common';
import { AvatarIcon, SelectAvatarCard } from '../comp/SelectAvatarCard';
import { emitter } from '@kit.BasicServicesKit';
import { UserInfo } from 'base_common';
@ComponentV2
export struct PrivacyPage {
  @Local windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;

  build() {
    NavDestination() {
      Column() {
        NavHeaderBar({
          title: '隐私设置',
          hasBackButton: true,
          hasBgColor: true,
          isMainPage: false,
        })
        Column({space: 12}){
          this.privacyOptionView('隐私协议',Constants.PRIVACY_POLICY_ROUTE)
          this.privacyOptionView('第三方信息共享清单',Constants.DATA_SHARING_ROUTE)
          this.privacyOptionView('个人信息收集清单',Constants.DATA_COLLECTION_ROUTE)
        }
        .width(Constants.FULL_SIZE)
        .backgroundColor($r('sys.color.background_secondary'))
        .padding({
          left:16,
          right:16,
          top:12})
      }
      .width(Constants.FULL_SIZE)
      .height(Constants.FULL_SIZE)
      .backgroundColor($r('sys.color.background_secondary'))
    }
    .hideTitleBar(true)
    .width(Constants.FULL_SIZE)
    .height(Constants.FULL_SIZE)
    .backgroundColor($r('sys.color.background_secondary'))
  }

  @Builder
  privacyOptionView(text:string, url:string){
    Row(){
      Text(text)
        .fontSize(16)
        .height(21)
        .width(Constants.FULL_SIZE)
      Image($r('app.media.ic_arrow_right'))
        .width(7)
        .height(14)
        .objectFit(ImageFit.Contain)
    }

    .width(Constants.FULL_SIZE)
    .height(61)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left:18,
      top:20,
      bottom:20,
      right:18
    })
    .onClick(() => {
      TCRouter.push(url);
    })
  }
}