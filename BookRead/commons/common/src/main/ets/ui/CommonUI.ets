import { Constants } from '../constant/Constants'
import { TCRouter } from '../comp/TCRouter'
import { MathUtil } from '../utils/MathUtil'
import { TSearch } from '../../../../Index';
import { SymbolGlyphModifier } from '@kit.ArkUI';

function getFreeText(isFree?: string): string | null {
  switch (isFree) {
    case '0':
      return '免费';
    case '1':
      return '会员';
    case '2':
      return '付费';
    default:
      return null;
  }
}

function getFreeColor(isFree?: string): string | null {
  switch (isFree) {
    case '0':
      return '#64BB5C';
    case '1':
      return '#F9A01E';
    case '2':
      return '#E84026';
    default:
      return null;
  }
}

@Builder
export function BookCover(image?: PixelMap | ResourceStr | DrawableDescriptor, isFree?: string) {

  Stack() {
    Image($r(image?.toString()))
      .height(144)
      .width(104)
      .objectFit(ImageFit.Auto)
      .borderRadius(10)
    Column() {
      Text(getFreeText(isFree))
        .fontSize(10)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .height(20)
        .width(35)
        .backgroundColor(getFreeColor(isFree))
        .borderRadius(10)
    }
    .padding({ bottom: 110, left: 45 })
  }
}

@ComponentV2
export struct ReturnButton {
  build() {
    Button() {
      Image($r('app.media.ic_arrow_left'))
        .width(8.68)
        .height(16.47)
        .objectFit(ImageFit.Contain)
    }
    .width(40)
    .height(40)
    .padding({
      top: 8,
      left: 8,
      right: 8,
      bottom: 8
    })
    .borderRadius(1000)
    .backgroundColor('#0D000000')
    .onClick(() => {
      TCRouter.pop();
    })
  }
}


@ComponentV2
export struct NavHeaderBar {
  @Param title: ResourceStr | string = 'default';
  @Param hasBackButton: boolean = true;
  @Param hasBgColor: boolean = true;
  @Param backImg: ResourceStr = $r('app.media.ic_back');
  @Param hasBackgroundImg: boolean = true;
  @Param isMainPage: boolean = false;
  @Consumer('tabController') tabsController: TabsController = new TabsController();
  @Consumer('currentIndexTab') currentIndexTab: number = 0;
  @Consumer('isHistory') isHistory: boolean = false;
  // 加上搜索框
  @Param isSearch: boolean = false;
  // 书架页title
  @Param isShelf: boolean = false;
  windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77
  @Consumer('isGrid') isGrid: boolean = true;
  @Consumer('isDeleteShelf') isDeleteShelf: boolean = false;
  @Local isShown: boolean = false;
  @Event gridSheet: () => void = () => {
    this.isGrid = true;
    this.isShown = false;
  }
  @Event listSheet: () => void = () => {
    this.isGrid = false;
    this.isShown = false;
  }
  @Event trashSheet: () => void = () => {
    if (this.isDeleteShelf === false) {
      this.isDeleteShelf = true;
    } else {
      this.isDeleteShelf = false;
    }
    this.isShown = false;
  }

  @Builder
  selectMenu() {
    Menu() {
      MenuItemGroup({ header: '书籍管理' }) {
        MenuItem({
          startIcon:$r('app.media.ic_grid'),
          content: '宫格模式',
          builder: this.gridSheet
        })
        MenuItem({
          startIcon:$r('app.media.ic_list'),
          content: '列表模式',
          builder: this.listSheet
        })
        MenuItem({
          startIcon:$r('app.media.ic_trash'),
          content: '删除',
          builder: this.trashSheet
        })
      }
    }
  }

  build() {
    Column() {
      Row() {
        Row(){
          if (this.hasBackButton) {
            Image(this.backImg)
              .width(40)
              .height(40)
              .onClick(() => {
                TCRouter.pop();
              })
              .margin({ left: 12 })
          }
          Text(this.title)
            .fontColor($r('sys.color.font_primary'))
            .fontSize(this.isMainPage ? $r('sys.float.Title_M') : $r('sys.float.Title_S'))// .width(Constants.FULL_SIZE)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 12 })
        }
        if (this.isSearch) {
          TSearch({ widthLength: '208' })
            .margin({ left: 24, right: 8 })
          Image($r('app.media.icon_history'))
            .height(40)
            .width(40)
            .onClick(() => {
              this.tabsController.changeIndex(this.currentIndexTab - 1)
              this.isHistory = true
            })
        }
        if (this.isShelf) {
          Row() {
            Image($r('app.media.icon_shelf_search'))
              .height(40)
              .width(40)
              .margin({ right: 8 })
              .onClick(() => {
                TCRouter.push(Constants.SEARCH_ROUTE);
              })
            Image($r('app.media.icon_filled'))
              .height(40)
              .width(40)
              .onClick(()=>{
                this.isShown = true
              })
              .bindContextMenu(this.isShown,this.selectMenu(),{
                aboutToDisappear:()=>{
                  this.isShown = false
                }
              })

          }
        }
      }.height(36)
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
    .padding({
      top: 16 + this.windowTopHeight,
      bottom: 8,
    })
    .width(Constants.FULL_SIZE)
    .backgroundColor(this.hasBgColor ? $r('sys.color.background_primary') : '#00000000')
  }
}