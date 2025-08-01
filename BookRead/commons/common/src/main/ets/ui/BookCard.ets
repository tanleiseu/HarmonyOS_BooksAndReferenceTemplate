import { TCRouter } from '../comp/TCRouter';
import { Constants } from '../constant/Constants';
import { BookInfo } from '../model/Book';
import { BookSubcategory } from '../model/BookSortInfo';
import { BookCover } from './CommonUI';


export interface CategoryInfo {
  category: string;
  isCategory: boolean
}

/**
 * 图书小卡，仅有图片+书名 换行：评分+类型
 */
@ComponentV2
export struct BookLittleCard {
  @Param info: BookInfo | undefined = undefined;

  build() {
    Column() {
      BookCover(this.info?.coverUrl, this.info?.isFree);
      Text(this.info?.name)
        .fontSize($r('sys.float.Body_M'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(104)
        .textAlign(TextAlign.Start)
        .padding({ top: 5 })
      Row() {
        Text(this.info?.rate)
          .fontSize(12)
          .fontColor($r('sys.color.mask_secondary'))
        Text(this.info?.category)
          .fontSize(12)
          .fontColor($r('sys.color.mask_secondary'))
      }
      .width(104)
      .align(Alignment.Start)
      .margin({ top: 4 })
    }
    .onClick(() => {
      if (this.info) {
        TCRouter.pushByLogin(Constants.READ_KIT_ROUTER, this.info);
      }
    })
  }
}

/**
 * 图书大卡，书名、介绍、评分
 */
@ComponentV2
export struct BookBigCard {
  @Param info: BookInfo | undefined = undefined;

  build() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
      BookCover(this.info?.coverUrl, this.info?.isFree);

      Blank()
        .width(20)
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
        Column() {
          Row() {
            Text(this.info?.name)
              .fontSize($r('sys.float.Body_L'))
              .fontColor($r('sys.color.font_primary'))
            Row() {
              Image($r('app.media.ic_public_star'))
                .height(15)
                .width(20)
                .padding({ right: 4 })
              Text(`${this.info?.rate}`)
                .fontSize($r('sys.float.Body_M'))
                .fontColor($r('sys.color.font_secondary'))
            }
          }
          .width(Constants.FULL_SIZE)
          .justifyContent(FlexAlign.SpaceBetween)

          Text(this.info?.description)
            .maxLines(3)
            .fontSize($r('sys.float.Body_M'))
            .fontColor($r('sys.color.font_secondary'))
            .padding({ top: 10, bottom: 20 })
        }

        Column() {
          Text('作者：' + this.info?.author)
            .fontSize(12)
            .textAlign(TextAlign.Start)
            .width('100%')
        }
        .margin({ top: 20 })

      }
      .width('75%')
    }
    .padding({ left: 12, right: 12 })
    .height(150)
    .width(Constants.FULL_SIZE)
    .onClick(() => {
      if (this.info) {
        TCRouter.pushByLogin(Constants.READ_KIT_ROUTER, this.info);
      }
    })
  }
}

/**
 * 图书类别，图片、类别名
 */
@ComponentV2
export struct BookCategoryItem {
  @Param categoryInfo: BookSubcategory | undefined = undefined;
  @Local pushParam?: CategoryInfo

  build() {
    Column() {
      if (this.categoryInfo?.imgUrl) {
        Column() {
          Image($r(this.categoryInfo?.imgUrl?.toString()))
            .height(76)
            .width(76)
            .borderRadius(8)
          Text(this.categoryInfo?.subcategoryName)
            .fontSize(14)
            .width(76)
            .textAlign(TextAlign.Center)
        }
        .onClick(() => {
          this.pushParam = { category: this.categoryInfo?.subcategoryName!, isCategory: true }
          TCRouter.push(Constants.SEARCH_ROUTE, this.pushParam)
        })
      } else {
        Row() {
          Text(this.categoryInfo?.subcategoryName)
            .fontSize(14)
        }
        .height(28)
        .width(76)
        .borderRadius(14)
        .backgroundColor('#0d000000')
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.pushParam = { category: this.categoryInfo?.subcategoryName!, isCategory: true }
          TCRouter.push(Constants.SEARCH_ROUTE, this.pushParam)
        })
      }
    }
  }
}