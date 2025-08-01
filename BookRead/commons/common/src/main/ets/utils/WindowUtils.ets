import { window } from '@kit.ArkUI';

export class WindowUtils {
  private static windowHeight: number = 0;
  private static windowWidth: number = 0;
  private static w: window.Window | undefined = undefined;

  public static init(w: window.Window) {
    // 屏幕宽高 px
    WindowUtils.windowWidth = w.getWindowProperties().windowRect.width; // 屏幕宽
    WindowUtils.windowHeight = w.getWindowProperties().windowRect.height; // 屏幕高 当前的图像充满屏幕，宽高和图像一样
    // 设置沉浸式
    w.setWindowLayoutFullScreen(true);
    let type = window.AvoidAreaType.TYPE_SYSTEM; // 以状态栏避让为例
    let avoidArea = w.getWindowAvoidArea(type);
    let topRectHeight = avoidArea.topRect.height; // 获取状态栏区域高度
    AppStorage.setOrCreate('windowTopHeight', px2vp(topRectHeight));

    type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
    avoidArea = w.getWindowAvoidArea(type);
    let bottomRectHeight = avoidArea.bottomRect.height; // 获取到导航区域的高度
    AppStorage.setOrCreate('bottomRectHeight', px2vp(bottomRectHeight));
    WindowUtils.w = w;

    // 3. 注册监听函数，动态获取避让区域数据
    w.on('avoidAreaChange', (data) => {
      if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
        let topRectHeight = data.area.topRect.height;
        AppStorage.setOrCreate('windowTopHeight', px2vp(topRectHeight));
      } else if (data.type === window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
        let bottomRectHeight = data.area.bottomRect.height;
        AppStorage.setOrCreate('bottomRectHeight', px2vp(bottomRectHeight));
      }
    });
  }

  public static getWindowHeight(): number {
    return WindowUtils.windowHeight;
  }

  public static getWindowWidth(): number {
    return WindowUtils.windowWidth;
  }

  public static async setWindowBright(light: number) {
    if (WindowUtils.w) {
      await WindowUtils.w.setWindowBrightness(light);
    }
  }

  public static getWindowBright() {
    if (WindowUtils.w) {
      return WindowUtils.w.getWindowProperties().brightness;
    }

    return 0;
  }

  public static getMainWindow(): window.Window {
    return WindowUtils.w as window.Window
  }

  public static resize() {
    if (WindowUtils.w) {
      WindowUtils.windowWidth = WindowUtils.w?.getWindowProperties().windowRect.width; // 屏幕宽
      WindowUtils.windowHeight = WindowUtils.w?.getWindowProperties().windowRect.height; // 屏幕高 当前的图像充满屏幕，宽高和图像一样
      AppStorage.set('windowTopHeight', WindowUtils.windowHeight);
    }
  }
}