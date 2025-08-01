import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import { systemShare } from '@kit.ShareKit';
import { fileUri, fileIo as fs } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import { Logger } from '@hw-agconnect/ui-base';
import { BookInfo } from 'common';

@ComponentV2
export struct ShareBookCard {
  @Param @Require book: BookInfo;

  setShareData() {
    const contextFaker: Context = getContext(this);
    let bookUri = `${this.book.id}.png`
    let filePath = contextFaker.filesDir + `/${bookUri}`;

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
    const context = getContext(this) as common.UIAbilityContext;
    const filesDir = context.filesDir;
    let bookUri = `${this.book.id.toString()}.png`
    // 用图片名称获取资源
    let book = this.book.coverUrl?.toString().substring(10)
    let resUri = context.resourceManager.getMediaByNameSync(book)
    let file = fs.openSync(filesDir + `/${bookUri}`, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
    try {
      let writeLen = fs.writeSync(file.fd, (resUri as Uint8Array).buffer);
      Logger.info('write data to file succeed and size is:' + writeLen);
    } catch (e) {
      Logger.info('err====')
    } finally {
      fs.closeSync(file);
    }
  }

  build() {
    Image($r('app.media.ic_share'))
      .width(35)
      .height(35)
      .onClick(() => {
        this.setShareData()
      })
  }
}