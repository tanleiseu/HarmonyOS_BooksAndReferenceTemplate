import { BookApi, BookCategory, BookSubcategory, NavHeaderBar, GetBookCategoryRsp, BookCategoryItem } from 'common';

@ComponentV2
export struct BookSortPage {
  @Local categoryChannel: Resource[] = [];
  @Local currentSortIndex: number = 0;
  @Local currentTitleId: number = 0;
  private categoryList: Array<BookCategory> = [];
  private navTitleScroller: Scroller = new Scroller();
  private bookListScroller: Scroller = new Scroller();

  async aboutToAppear(): Promise<void> {
    this.categoryChannel.push($r('app.string.boys_channel'));
    this.categoryChannel.push($r('app.string.girls_channel'));
    this.categoryChannel.push($r('app.string.free_channel'));
    this.getBooksCategory();
  }

  async getBooksCategory() {
    const rsp: GetBookCategoryRsp = await BookApi.getBookCategoryList();
    this.categoryList = rsp.category;
  }

  @Builder
  categoryTab() {
    Column() {
      List({ space: 15 }) {
        ForEach(this.categoryChannel, (item: ResourceStr, index: number) => {
          ListItem() {
            Text(item)
              .textAlign(TextAlign.Center)
              .fontSize($r('sys.float.Body_L'))
              .fontColor(this.currentSortIndex === index ? Color.White : $r('sys.color.font_primary'))
              .fontWeight(FontWeight.Medium)
              .height(40)
              .width(100)
              .backgroundColor(this.currentSortIndex === index ? Color.Black : $r('app.color.common_background'))
              .borderRadius(21)
              .onClick(async () => {
                this.currentSortIndex = index
              })
          }
        }, (item: ResourceStr) => JSON.stringify(item))
      }
      .scrollBar(BarState.Off)
      .listDirection(Axis.Horizontal)
      .padding({ top: 10, left: 18, right: 18 })
    }

  }

  // Right side list header. rightTop
  @Builder
  goodsHeaderBuilder(headerName: string) {
    Row() {
      Text(headerName)
        .fontSize(16)
        .fontWeight(500)
    }
    .width('100%')
    .height(56)
    .padding({ left: 8 })
    .backgroundColor($r('sys.color.white'))
  }

  // [Start list_sliding_event]
  // List sliding event.
  listChange(index: number, isGoods: boolean) {
    if (this.currentTitleId !== index) {
      this.currentTitleId = index;
      if (isGoods) {
        // IsGoods is true, controlling the data in the right-hand list to slide to the specified index.
        this.bookListScroller.scrollToIndex(index);
      } else {
        // IsGoods is set to false, controlling the left list data to slide to the specified index.
        this.navTitleScroller.scrollToIndex(index);
      }
    }
  }

  // [End list_sliding_event]

  @Builder
  SecondaryLevelList() {
    Column() {
      Row() {
        // [Start on_list_change]
        // [Start tabs_and_navigation]
        // Left List Data Display.
        List({ space: 8, scroller: this.navTitleScroller }) {
          ForEach(this.categoryList, (item: BookCategory, index: number) => {
            ListItem() {
              Row() {
                Text(item.categoryName)// [StartExclude on_list_change]
                  // [StartExclude tabs_and_navigation]
                  .width('100%')
                  .height(56)
                  .fontSize(this.currentTitleId === index ? 16 : 14)
                  .textAlign(TextAlign.Center)
                  .fontColor(this.currentTitleId === index ? '#ffffff' : '#000000')
                  .opacity(this.currentTitleId === index ? 1 : 0.6)
                  .fontWeight(this.currentTitleId === index ? FontWeight.Bold :
                  FontWeight.Normal)// [EndExclude on_list_change]
                  .onClick(() => {
                    // Pass in the current list item index and true.
                    this.listChange(index, true);
                  })
              }
              .width(88)
              .height(40)
              .borderRadius({
                topRight: 12,
                bottomRight: 12
              })
              .backgroundColor(this.currentTitleId === index ? '#E84026' : '')

              // [EndExclude tabs_and_navigation]
            }
          }, (item: BookCategory) => JSON.stringify(item.categoryName))
        }
        // [StartExclude on_list_change]
        // [StartExclude tabs_and_navigation]
        .width(100)
        .height('100%')
        .scrollBar(BarState.Off)
        .backgroundColor('#F1F3F5')
        .padding({ top: 12 })

        // [EndExclude tabs_and_navigation]
        // [EndExclude on_list_change]

        // Display of List Content on the Right.
        List({ scroller: this.bookListScroller }) {
          // [StartExclude on_list_change]
          ForEach(this.categoryList, (item: BookCategory) => {
            ListItemGroup({ space: 8, header: this.goodsHeaderBuilder(item.categoryName) }) {
              ForEach(item.subcategory, (bookCategoryItem: BookSubcategory) => {
                ListItem() {
                  BookCategoryItem({ categoryInfo: bookCategoryItem })
                }
              }, (bookCategoryItem: BookSubcategory) => JSON.stringify(bookCategoryItem.subcategoryId))
            }

          }, (item: BookCategory) => JSON.stringify(item.subcategory))
          // [EndExclude on_list_change]
        }
        // [StartExclude on_list_change]
        // [End tabs_and_navigation]
        .width('100%')
        .height('100%')
        .layoutWeight(1)
        .lanes(3)
        .scrollBar(BarState.Off)
        .sticky(StickyStyle.Header)
        .edgeEffect(EdgeEffect.None)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
        .padding({ left: 8, right: 12 })
        .backgroundColor('#ffffff')
        // [EndExclude on_list_change]
        .onScrollIndex((index: number) => {
          // Pass in the current list item index and false.
          this.listChange(index, false)
        })
        // [End on_list_change]
      }
      .width('100%')
      .height('90.5%')
      .justifyContent(FlexAlign.Center)
      .alignSelf(ItemAlign.Center)
      .margin({ top: 12 })
    }

  }

  build() {
    Navigation() {
      Column() {
        NavHeaderBar({
          title: $r('app.string.book_sort'),
          hasBackButton: false,
          hasBgColor: false,
          isMainPage: true,
        })
        Column() {
          Scroll() {
            this.categoryTab()
          }

          this.SecondaryLevelList()

        }
        .height('100%')
        .width('100%')
        .padding({ bottom: '27%' })
      }
    }
    .hideTitleBar(true)
  }
}

