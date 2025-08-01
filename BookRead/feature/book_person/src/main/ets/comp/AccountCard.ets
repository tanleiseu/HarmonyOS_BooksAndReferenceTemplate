import { Constants, TCRouter } from 'common';
import { promptAction } from '@kit.ArkUI';
import { BusinessError, emitter } from '@kit.BasicServicesKit';
import { UserInfo } from 'base_common';
@ComponentV2
export struct AccountCard {
  @Local bookCoins: number = 0;
  @Local isLogin: boolean = false;
  @Local userInfoFromStorage: UserInfo = AppStorage.get('userInfo') as UserInfo;
  aboutToAppear(): void {
    this.loadUserInfo();
    // 监听登录状态变化
    emitter.on(Constants.LOGIN_CHANGE, () => {
      this.loadUserInfo();
    });

  }

  loadUserInfo() {
    const userInfoFromStorage: UserInfo = AppStorage.get('userInfo') as UserInfo;
    if (userInfoFromStorage) {
      this.bookCoins = userInfoFromStorage.bookCoins || 100;
      this.isLogin = true;
    } else {
      this.bookCoins = 0;
      this.isLogin = false;
    }
  }

  // 更新书币余额
  updateBookCoins(amount: number) {
    const userInfoFromStorage: UserInfo = AppStorage.get('userInfo') as UserInfo;
    if (userInfoFromStorage) {
      userInfoFromStorage.bookCoins = (userInfoFromStorage.bookCoins || 100) + amount;
      AppStorage.setOrCreate('userInfo', userInfoFromStorage);
      AppStorage.setOrCreate('bookCoins', userInfoFromStorage.bookCoins);
      this.loadUserInfo();
    }
  }

  showLoginPrompt() {
    promptAction.showDialog({
      title: '提示',
      message: '需要先登录才能使用此功能',
      buttons: [
        {
          text: '取消',
          color: '#999999'
        },
        {
          text: '去登录',
          color: '#E3922F'
        }
      ]
    }).then((result) => {
      if (result.index === 1) {
        TCRouter.push(Constants.LOGIN_ROUTE);
      }
      // 点击"取消"，不做任何操作
    }).catch((error: BusinessError) => {
      console.error('AccountCard showLoginPrompt dialog error:', JSON.stringify(error));
    });
  }

  build() {
    Column({space: 12}) {
      Row() {
        Text('我的账户')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))
      }
      .width(Constants.FULL_SIZE)
      .justifyContent(FlexAlign.Start)

      Divider()
        .strokeWidth(1)
        .color($r('sys.color.comp_divider'))

      Row() {
        Column({ space: 4 }) {
          Text(this.bookCoins.toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('sys.color.font_primary'))
          Text('书币')
            .fontSize(14)
            .fontColor($r('sys.color.font_secondary'))
        }
        .width(72)
        .alignItems(HorizontalAlign.Center)

        Column(){
          Button('充值')
            .width(72)
            .height(28)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('sys.color.font_on_primary'))
            .backgroundColor('#E8402A')
            .borderRadius(14)
            .onClick(() => {
              if (!this.isLogin) {
                this.showLoginPrompt();
              } else {
                // 跳转到充值页面
                TCRouter.push(Constants.RECHARGE_ROUTE);
              }
            })
        }
        .height(44)
        .justifyContent(FlexAlign.End)

      }
      .width(Constants.FULL_SIZE)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width(Constants.FULL_SIZE)
    .padding({ left: 12, right: 12, top: 12, bottom: 12 })
    .backgroundColor($r('sys.color.comp_background_list_card'))
    .borderRadius(16)
  }
} 