import { Constants, NavHeaderBar, ReturnButton, TCRouter } from 'common';
import { OptionView } from '../comp/OptionView';

@ComponentV2
export struct IssueAndFeedbackPage {
  @Local windowTopHeight: number = AppStorage.get('windowTopHeight') as number || 38.77;

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          NavHeaderBar({
            title: '问题与反馈',
            hasBackButton: true,
            hasBgColor: true,
            isMainPage: false,
          })
          Scroll() {
            Column({ space: 12 }) {
              OptionView({ text: '意见反馈', url: Constants.FEEDBACK_ROUTE })
              OptionView({ text: '反馈记录', url: Constants.FEEDBACK_RECORD_ROUTE })
            }
          }.layoutWeight(1)
          .scrollBar(BarState.Off)
          .align(Alignment.Top)
          .padding({
            left: 12,
            right: 12,
            top: 20
          })
        }
        .alignItems(HorizontalAlign.Start)
        .width(Constants.FULL_SIZE)
      }
      .width(Constants.FULL_SIZE)
      .height(Constants.FULL_SIZE)
      .backgroundColor($r('sys.color.background_secondary'))
    }
    .hideTitleBar(true)
    .width(Constants.FULL_SIZE)
    .height(Constants.FULL_SIZE)
    .backgroundColor($r('sys.color.background_secondary'))
  }

}
