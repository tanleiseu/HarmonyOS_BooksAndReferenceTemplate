import { BookListPage } from 'book_home';
import { PersonPage } from 'book_person';
import { BookShelfPage } from 'book_shelf';
import {BookSortPage} from 'book_sort'
import { Constants } from 'common';
import { UserInfo } from 'base_common';
@Builder
function bookList() {
  BookListPage();
}

@Builder
function person() {
  PersonPage();
}

@Builder
function bookshelf() {
  BookShelfPage();
}

@Builder
function bookSort() {
  BookSortPage();
}
const bookshelfBuilder: WrappedBuilder<[string]> = wrapBuilder(bookshelf);
const bookListBuilder: WrappedBuilder<[string]> = wrapBuilder(bookList);
const personBuilder: WrappedBuilder<[string]> = wrapBuilder(person);
const bookSortBuilder: WrappedBuilder<[string]> = wrapBuilder(bookSort);


@ComponentV2
export struct BookHomePage {
  @Provider('currentIndexTab') currentIndexTab: number = 0;
  @Provider('tabController') tabsController: TabsController = new TabsController();
  @Provider('isHistory') isHistory:boolean = false
  @Provider('userInfo') userInfo: UserInfo | undefined = undefined;
  @Builder
  tabBuilder(title: Resource, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndexTab === index ? selectedImg : normalImg)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
      Text(title)
        .margin({ top: 4 })
        .fontSize(10)
        .fontColor(this.currentIndexTab === index ? $r('app.color.font_overdue') : '#E6000000')
    }
    .justifyContent(FlexAlign.Center)
    .height(52)
    .width('100%')
    .onClick(() => {
      this.currentIndexTab = index;
      this.tabsController.changeIndex(this.currentIndexTab);
    })

  }

  @Builder
  tabContentBuilder(text: Resource,
    index: number,
    selectedImg: Resource,
    normalImg: Resource,
    builder: WrappedBuilder<[string]>) {
    TabContent() {
      Stack() {
        builder.builder('');
      }
      .height('100%')
    }
    .backgroundColor(Color.White)
    .tabBar(this.tabBuilder(text, index, selectedImg, normalImg))
  }

  build() {
    NavDestination() {
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        this.tabContentBuilder($r('app.string.bookshelf'),
          Constants.TAB_INDEX_ZERO, $r('app.media.shelf_tab_active'), $r('app.media.shelf_tab'), bookshelfBuilder)
        this.tabContentBuilder($r('app.string.book_case'),
          Constants.TAB_INDEX_ONE, $r('app.media.mall_tab_active'), $r('app.media.mall_tab'), bookListBuilder)
        this.tabContentBuilder($r('app.string.book_sort'),
          Constants.TAB_INDEX_TWO, $r('app.media.sort_tab_active'), $r('app.media.sort_tab'), bookSortBuilder)
        this.tabContentBuilder($r('app.string.person'),
          Constants.TAB_INDEX_THREE, $r('app.media.person_tab_active'), $r('app.media.person_tab'), personBuilder)
      }
      .clip(true)
      .width('100%')
      .backgroundColor('#F3F4F5')
      .barHeight(50)
      .barMode(BarMode.Fixed)
      .padding({ bottom: 18 })
      .animationDuration(0)
      .onAnimationStart((index: number, targetIndex: number) => {
        this.currentIndexTab = targetIndex;
      })
    }
    .onWillShow(() => {
      if (AppStorage.has('userInfo')) {
        this.userInfo = AppStorage.get('userInfo') as UserInfo;
      }
    })
    .hideTitleBar(true)
  }
}