import { Constants, TCRouter } from 'common'
import { call } from '@kit.TelephonyKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { baseActionSheet } from 'base_common';

@ComponentV2
export struct ServiceCard {

  @Consumer('tabController') tabsController: TabsController = new TabsController();
  @Consumer('currentIndexTab') currentIndexTab: number = 0;
  @Consumer('isHistory') isHistory: boolean = false;

  build() {
    Column(){
      Row(){
        Text('常用服务')
          .height(24)
          .width(72)
          .fontSize(18)
          .fontWeight(500)
          .width(Constants.FULL_SIZE)
          .textAlign(TextAlign.Start)
      }
      .padding({bottom:12})
      .width(Constants.FULL_SIZE)
      Column({space:8}){

        Row(){
          Image($r('app.media.ic_reading_history'))
            .height(24)
            .width(24)
            .objectFit(ImageFit.Contain)
            .margin({
              right:12
            })

          Text($r('app.string.reading_history'))
        }
        .height(47)
        .width(Constants.FULL_SIZE)
        .backgroundColor('#ffffff')
        .borderRadius(16)
        .padding({
          left:12,
          right:12
        })
        .onClick(() => {
          this.tabsController.changeIndex(this.currentIndexTab-3)
          this.isHistory = true
        })

      this.serviceButtonView('app.media.ic_reading_preference','app.string.reading_preference',Constants.PREFERENCE_ROUTE)

      Row(){
        Image($r('app.media.ic_contact'))
          .height(24)
          .width(24)
          .objectFit(ImageFit.Contain)
          .margin({
            right:12
          })

        Text($r('app.string.contact'))
      }
      .height(47)
      .width(Constants.FULL_SIZE)
      .backgroundColor('#ffffff')
      .borderRadius(16)
      .padding({
        left:12,
        right:12
      })
      .onClick(() => { baseActionSheet.show({
        id: 'PhoneSheetBuilder',
        title: { title: '联系客服' },
        height: SheetSize.FIT_CONTENT,
        backgroundColor: $r('app.color.pure_white'),
        customContent: () => {
          this.PhoneSheetBuilder()
        },
      })
      })

      this.serviceButtonView('app.media.ic_issue_and_feedback','app.string.issue_and_feedback',Constants.ISSUE_AND_FEEDBACK_ROUTE)
      }
    }
  }

  @Builder
  serviceButtonView(iconUrl:string, serviceText:string, url:string){
    Row(){
      Image($r(iconUrl))
        .height(24)
        .width(24)
        .objectFit(ImageFit.Contain)
        .margin({
          right:12
        })

      Text($r(serviceText))
    }
    .height(47)
    .width(Constants.FULL_SIZE)
    .backgroundColor('#ffffff')
    .borderRadius(16)
    .padding({
      left:12,
      right:12
    })
    .onClick(() => {
        TCRouter.push(url);
    })
  }

  @Builder
  PhoneSheetBuilder() {
    Column({ space: 12 }) {
      Text('000000')
        .fontSize(18)
        .fontWeight('medium')
      Row({ space: 8 }) {
        Text('一键拨号')
          .fontSize(16)
          .fontWeight('medium')
          .fontColor($r('app.color.pure_white'))
      }
      .padding({ top: 10, bottom: 10 })
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .borderRadius(20)
      .backgroundColor('#E84026')
      .onClick(() => {
        call.makeCall('000000',
          (err: BusinessError) => {
            if (err) {
              console.error(`makeCall fail, err->${JSON.stringify(err)}`);
            } else {
              console.log(`makeCall success`);
            }
          });
      })

      Row() {
        Text('取消')
          .fontSize(16)
          .fontWeight('medium')
          .fontColor('#ffffff')
      }
      .padding({ top: 10, bottom: 10 })
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .borderRadius(20)
      .backgroundColor(Color.Gray)
      .onClick(() => {
        baseActionSheet.close('PhoneSheetBuilder')
      })
    }
    .width('90%')
    .padding({
      left: 12,
      right: 12,
      bottom: 16,
      top: 16
    })
    .margin({ bottom: 40, left: 16, right: 16 })
    .backgroundColor($r('app.color.pure_white'))
    .borderRadius(16)
  }
}