import { Constants, TCRouter } from 'common'

@ComponentV2
export struct ActivityCard {
  build() {
    Row() {
      Row({space: 12}){
        Image($r('app.media.activity_center'))
          .height(48)
          .width(48)
          .objectFit(ImageFit.Contain)
        Column({space: 2}){
          Text($r('app.string.activity_center'))
            .width(64)
            .height(21)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text($r('app.string.activity_description'))
            .width(70)
            .height(14)
            .fontSize(10)
            .fontWeight(FontWeight.Regular)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width(304)
      .height(56)
      .padding({
        left:8,
        right:8
      })
    }
    .width(Constants.FULL_SIZE)
    .height(72)
    .borderRadius(16)
    .backgroundColor($r('sys.color.background_primary'))
    .padding({
      left:12,
      right:12,
      top:8,
      bottom:8
    })
    .onClick(() => {
      TCRouter.push(Constants.ACTIVITY_ROUTE);
    })
  }
}
