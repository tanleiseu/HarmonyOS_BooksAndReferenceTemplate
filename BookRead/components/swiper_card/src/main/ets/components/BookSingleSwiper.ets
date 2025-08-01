import { BookInfo } from '../model/Book'

@Builder
export function bookSingleSwiper(info?: BookInfo) {
  Column() {
    Image($r(info?.coverUrl?.toString()))
      .width(150)
      .height(200)
      .borderRadius(10)

    Column() {
      Text(info?.name)
        .padding({ top: 3 })
        .fontSize($r('sys.float.Body_L'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
      Row() {
        Image($r('app.media.ic_public_star'))
          .height(15)
          .width(20)
          .padding({ right: 8 })
        Text(`${info?.rate} ${info?.category}|${info?.author}`)
          .fontSize($r('sys.float.Body_M'))
          .fontColor($r('sys.color.font_secondary'))
      }
      .padding({ top: 10 })
    }
    .padding({ top: 5 })
  }
  .width(150)
}