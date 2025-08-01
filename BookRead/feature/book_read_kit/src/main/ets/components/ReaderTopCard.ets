import { promptAction } from '@kit.ArkUI';
import { BookApi, BookInfo, Constants, TCRouter } from 'common';
import { ShareBookCard } from './ShareBookCard';
import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import { systemShare } from '@kit.ShareKit';
import { fileUri } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { Logger } from '@hw-agconnect/ui-base';
import { BusinessError } from '@kit.BasicServicesKit';
import { UserInfo } from 'base_common';
@ComponentV2
export struct ReaderTopCard {
  @Param @Require book: BookInfo
  @Local isAddSuccess: boolean = false;
  @Local isLogin: boolean = false;
  windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;

  setShareData() {
    const contextFaker: Context = getContext(this);
    let filePath = contextFaker.filesDir + '/book_image_1.png';
    let i = this.book.coverUrl
    let utdTypeId = utd.getUniformDataTypeByFilenameExtension('.png', utd.UniformDataType.IMAGE);

    let shareData: systemShare.SharedData = new systemShare.SharedData({
      utd: utdTypeId,
      uri: fileUri.getUriFromPath(filePath),
      title: 'Picture Title',
      description: 'Picture Description',
    });

    let controller: systemShare.ShareController = new systemShare.ShareController(shareData);
    let context = getContext(this) as common.UIAbilityContext;
    controller.show(context, {
      selectionMode: systemShare.SelectionMode.SINGLE,
      previewMode: systemShare.SharePreviewMode.DETAIL,
    }).then(() => {
      Logger.info('ShareController show success.');
    }).catch((error: BusinessError) => {
      Logger.error(`ShareController show error. code: ${error.code}, message: ${error.message}`);
    });
  }

  async aboutToAppear(): Promise<void> {
    this.isLogin = AppStorage.get<UserInfo>('userInfo') !== undefined;
    const rsp = await BookApi.getBooksShelfList('favBooks', Constants.API_GET_BOOK_FAVOURITE_PATH, '');
    let books: BookInfo[] = rsp.books;
    books.forEach((book) => {
      if (book.id === this.book.id && this.isLogin) {
        this.isAddSuccess = true;
        return;
      }
    });
  }

  async addBook2Shelf(isAdd: boolean, toast: ResourceStr) {
    const rsp = await BookApi.getBooksShelfList('favBooks', Constants.API_GET_BOOK_FAVOURITE_PATH, '');
    let books: BookInfo[] = rsp.books;
    if (isAdd) {
      books.push(this.book);
      AppStorage.set('favBooks', books);
      this.isAddSuccess = true;
    } else {
      let index = books.findIndex(book => this.book.id === book.id)
      if (index !== -1) {
        books.splice(index, 1);
        this.isAddSuccess = false;
      }
      AppStorage.set('historyBooks', books)
    }
    promptAction.showToast({
      message: toast,
      duration: 2000
    });
  }

  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(35)
        .height(35)
        .onClick(() => {
          TCRouter.pop();
        })


      Row({space: 8}) {
        Image(this.isAddSuccess ? $r('app.media.ic_add_book_shelf_success') : $r('app.media.ic_add_book_shelf'))
          .width(35)
          .height(35)
          .onClick(async () => {
            const userInfo = AppStorage.get<UserInfo>('userInfo');
            if (userInfo === undefined) {
              TCRouter.push(Constants.LOGIN_ROUTE);
            } else if (!this.isAddSuccess) {
              await this.addBook2Shelf(true, $r('app.string.add_shelf_success'));
            } else if (this.isAddSuccess) {
              //   再次点击从书架删除
              await this.addBook2Shelf(false, $r('app.string.del_shelf_success'));
            }
          })

        ShareBookCard({ book: this.book })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .width(Constants.FULL_SIZE)
    .padding({
      top: this.windowTopHeight + 8,
      left: 18,
      right: 18,
      bottom: 8
    })
  }
}