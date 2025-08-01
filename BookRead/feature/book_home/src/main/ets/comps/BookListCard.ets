import { BookInfo, BookLittleCard, Constants, TCRouter } from 'common';
import {LazyDataVM} from 'swiper_card'
@ComponentV2
export struct BookListCard {
  // 今日力荐 展示两行书本 + 换一批按钮
  @Param categoryName: ResourceStr = '';
  @Param @Require books: LazyDataVM<BookInfo>
  @Local prep: number = 0;
  @Local angel:number = 0;

  @Builder
  bookCategoryBar(category: ResourceStr) {
    Row() {
      Text(category)
        .fontColor($r('sys.color.font_primary'))
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
      Row() {
        Text($r('app.string.more'))
          .fontColor($r('sys.color.font_secondary'))
          .fontSize($r('sys.float.Body_M'))
        Image($r('app.media.arrow_right'))
          .width(20)
          .height(20)
      }
      .onClick(() => {
        TCRouter.push(Constants.BOOK_LIST_ROUTE, { category: this.categoryName, books: this.books.getAllData() })
      })
    }
    .width('100%')
    .height(30)
    .margin({ top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  aboutToAppear(): void {
  }

  build() {
    Column() {
      this.bookCategoryBar(this.categoryName)
      List({ space: 8 }) {
        LazyForEach(this.books, (item: BookInfo) => {
          ListItem() {
            Column() {
              BookLittleCard({ info: item })
            }
          }
        })
      }
      .cachedCount(6)
      .scrollBar(BarState.Off)
      .listDirection(Axis.Horizontal)
      .lanes(2)
      .height(400)
      .rotate({ y: 1, angle: this.angel, perspective: this.prep })
      Button('换一批')
        .backgroundColor('#0d000000')
        .height(28)
        .fontColor($r('sys.color.black'))
        .width('100%')
        .margin({ left: 24, right: 24 })
        .onClick(() => {
          animateTo({
            duration: 1000,
            curve: Curve.EaseIn,
            iterations: 1,
            playMode: PlayMode.Normal,
            onFinish: () => {
              console.info('play end')
            }
          }, () => {
            this.angel += 360
          })
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }
}