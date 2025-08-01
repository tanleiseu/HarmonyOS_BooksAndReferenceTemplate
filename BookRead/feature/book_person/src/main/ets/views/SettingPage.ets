import { Constants, NavHeaderBar, ReturnButton, TCRouter } from 'common';
import { emitter } from '@kit.BasicServicesKit';
import { UserInfo } from 'base_common';

@ComponentV2
export struct SettingPage {
  @Local windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;
  @Local userInfo: UserInfo | undefined = undefined;

  async aboutToAppear(): Promise<void> {
    this.userInfo = AppStorage.get('userInfo') as UserInfo;
    emitter.on(Constants.LOGIN_CHANGE, () => {
      this.userInfo = AppStorage.get('userInfo') as UserInfo;
    })
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          NavHeaderBar({
            title: '设置',
            hasBackButton: true,
            hasBgColor: true,
            isMainPage: false,
          })
          Column() {
            Column({ space: 12 }) {
              this.settingOptionView('个人信息',Constants.ACCOUNT_ROUTE)
              this.settingOptionView('隐私设置',Constants.PRIVACY_ROUTE)
              this.settingOptionView('关于',Constants.ABOUT_ROUTE)
            }
            if (this.userInfo?.isLogin){
              this.loginOut()
            }
          }
          .layoutWeight(1)
          .align(Alignment.Top)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({
            left: 12,
            right: 12,
            top: 20,
            bottom: 50
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width(Constants.FULL_SIZE)
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
  settingOptionView(text:string, url:string){
    Row(){
      Text(text)
        .fontSize(16)
        .height(21)
        .width(100)
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
      if (url === Constants.ACCOUNT_ROUTE) {
        TCRouter.pushByLogin(url)
      } else {
        TCRouter.push(url);
      }
    })
  }

  @Builder
  loginOut() {
    if (this.userInfo?.isLogin) {
      Button('退出登录')
        .width(312)
        .height(40)
        .borderRadius(20)
        .padding({
          top: 9,
          right: 16,
          bottom: 9,
          left: 16
        })
        .backgroundColor('#E84026')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .align(Alignment.Bottom)
        .onClick(() => {
          const promptAction = this.getUIContext().getPromptAction();
          if (!this.userInfo?.isLogin) {
            promptAction.showToast({ message: $r('app.string.no_login_out') })
          } else {
            promptAction.showDialog({
              title: $r('app.string.ask_for_login_out'),
              message: $r('app.string.ask_for_login_out_again'),
              buttons: [
                {
                  text: $r('app.string.cancel'),
                  color: $r('app.color.button_color')
                },
                {
                  text: $r('app.string.agreement_and_login_out'),
                  color: $r('app.color.button_color')
                }
              ]
            }, (err, data) => {
              if (data.index === 1) {
                // 保留会员状态和书币信息，只清除登录状态
                const savedMembershipStatus = this.userInfo?.isMembership || false;
                const savedBookCoins = this.userInfo?.bookCoins || 100;

                // 保存会员状态和书币信息到本地存储
                AppStorage.setOrCreate('membershipStatus', savedMembershipStatus);
                AppStorage.setOrCreate('bookCoins', savedBookCoins);

                // 清除用户信息
                AppStorage.setOrCreate('userInfo', undefined);
                emitter.emit(Constants.LOGIN_CHANGE);
                TCRouter.pop();
              }
            })
          }
        })
    }
  }
}
