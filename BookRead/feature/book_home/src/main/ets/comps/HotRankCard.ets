import { BookInfo, Constants, rankListInfo, TCRouter } from 'common';


/**
 * 搜索页面热搜榜card
 */
@ComponentV2
export struct HotRankCard {
  @Param info: rankListInfo | undefined = undefined;

  build() {
    Column() {
      Row() {
        Text(this.info?.rankName)
          .fontSize($r('sys.float.Body_L'))
          .fontColor($r('sys.color.font_primary'))
          .fontWeight(FontWeight.Medium)
          .height(22)
          .padding({ left: '12vp' })
        Row() {
          Text($r('app.string.more'))
            .fontSize($r('sys.float.Caption_L'))
            .fontColor($r('sys.color.font_secondary'))

          Image($r('app.media.arrow_right'))
            .height(16)
            .width(16).padding({ left: '6vp' })
        }.justifyContent(FlexAlign.SpaceBetween).padding({ right: '12vp' })
        .onClick(() => {
          TCRouter.push(Constants.BOOK_LIST_ROUTE, { category: this.info?.rankName, books: this.info?.detailBooks })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .height(46)
      .linearGradient({
        direction: GradientDirection.Left, // 渐变方向
        repeating: true, // 渐变颜色是否重复
        colors: [['#DDF3FF', 0.0], ['#E7E1FF', 0.45], ['#E1FFF0', 1]]
      })

      List({ space: 6, initialIndex: 0 }) {
        ForEach(this.info?.detailBooks, (book: BookInfo, index: number) => {
          ListItem() {

            Row() {
              Image($r(book?.rankUrl?.toString()))
                .height(24)
                .width(36)
                .padding({ left: 12 })
              Image($r(book?.coverUrl?.toString()))
                .width(48)
                .height(64)
                .borderRadius(8).padding({ left: 8, top: 8, bottom: 4 })

              Flex({ alignItems: ItemAlign.Start }) {
                Column() {
                  Text(book?.name)
                    .fontSize($r('sys.float.Body_M'))
                    .fontColor($r('sys.color.font_primary'))
                    .fontWeight(FontWeight.Medium)
                    .padding({ left: 8, top: 12.5, right: 8 })


                  Text(book?.count)
                    .fontSize($r('sys.float.Caption_L'))
                    .fontColor($r('sys.color.font_secondary'))
                    .fontWeight(FontWeight.Regular)
                    .padding({ left: 8, top: 4, right: 8 })
                }.alignItems(HorizontalAlign.Start)
              }

            }.alignItems(VerticalAlign.Center)
            .onClick(() => {
              TCRouter.pushByLogin(Constants.READ_KIT_ROUTER, book);
            })

          }
        }, (item: string) => item)
      }
      .listDirection(Axis.Vertical) // 排列方向
      .scrollBar(BarState.Off)
      .cachedCount(3)
      .layoutWeight(1)
      .backgroundColor('#FFF5F5')
    }
    .width('75%')
    .height('90%')
    .borderRadius(10)
    .clip(true)

  }
}


/**
 * 搜索结果
 */
@ComponentV2
export struct SearchResultCard {
  @Param info: BookInfo | undefined = undefined;

  build() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
      BookCover(this.info?.coverUrl);

      Blank()
        .width(16)
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
        Column() {
          Row() {
            Text(this.info?.name)
              .fontSize($r('sys.float.Subtitle_M'))
              .fontColor($r('sys.color.font_primary')).fontWeight(FontWeight.Medium);
            Row() {
              Text(`${this.info?.rate}` + '分')
                .fontSize($r('sys.float.Subtitle_M'))
                .fontColor($r('sys.color.font_primary')).fontWeight(FontWeight.Medium);
            }
          }
          .width(Constants.FULL_SIZE)
          .justifyContent(FlexAlign.SpaceBetween)

          Text(this.info?.description)
            .maxLines(3)
            .fontSize($r('sys.float.Body_S'))
            .fontColor($r('sys.color.font_secondary'))
            .fontWeight(FontWeight.Regular)
            .padding({ top: 10, bottom: 20 })
        }

        Column() {
          Row() {
            Text(this.info?.category)
              .fontSize($r('sys.float.Body_S'))
              .fontColor($r('sys.color.font_secondary'))
              .fontWeight(FontWeight.Regular).textAlign(TextAlign.Start)

            Text(this.info?.count)
              .fontSize(12)
              .textAlign(TextAlign.Start)
              .padding({ left: 10 })
              .fontSize($r('sys.float.Body_S'))
              .fontColor($r('sys.color.font_secondary'))
              .fontWeight(FontWeight.Regular)
          }.width('100%').justifyContent(FlexAlign.Start)

        }
        .margin({ top: 20 })
      }
      .width('65%')
    }
    .height(150)
    .width(Constants.FULL_SIZE)
    .onClick(() => {
      if (this.info) {
        TCRouter.pushByLogin(Constants.READ_KIT_ROUTER, this.info);
      }
    })
  }
}

@Builder
export function BookCover(image?: PixelMap | ResourceStr | DrawableDescriptor) {
  Stack() {
    Image($r(image?.toString()))
      .height(144)
      .width(104)
      .objectFit(ImageFit.Auto)
      .borderRadius(10)
  }
}