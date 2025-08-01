import { readerCore } from '@kit.ReaderKit';
import { display } from '@kit.ArkUI';
import { WindowUtils } from '../utils/WindowUtils';

@ObservedV2
export class ReadSet {
  @Trace readerSetting: readerCore.ReaderSetting = {
    fontName: '',
    fontPath: '',
    fontSize: 18,
    fontColor: '#000000E6',
    fontWeight: 100,
    lineHeight: 2,
    nightMode: false,
    themeColor: 'rgba(251, 240, 219, 1)',
    themeBgImg: '',
    flipMode: '0',
    scaledDensity: display.getDefaultDisplaySync().scaledDensity > 0 ? display.getDefaultDisplaySync().scaledDensity :
      1,
    viewPortWidth: WindowUtils.getWindowWidth(),
    viewPortHeight: WindowUtils.getWindowHeight()
  }
}