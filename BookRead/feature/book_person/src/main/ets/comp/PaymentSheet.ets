import { AggregatedPaymentPicker, ChannelType, MockApi, WxExtraInfo } from 'common';
import { promptAction } from '@kit.ArkUI';

@ComponentV2
export struct PaymentSheet {
  @Param amount: number = 0;
  @Param description: string = '';
  @Param wxOrderReq: WxExtraInfo | null = null;
  @Param hwOrderStr: string = '';
  @Param aliOrderStr: string = '';
  @Event onPaySuccess: (type: ChannelType) => void = () => {};
  @Event onClose: () => void = () => {};

  build() {
    Column({ space: 16 }) {
      // 支付金额显示
      Column({ space: 8 }) {
        Text(this.description)
          .fontSize(14)
          .fontColor($r('sys.color.font_secondary'))
          .visibility(this.description ? Visibility.Visible : Visibility.None)
        
        Text() {
          Span('￥').fontSize(18).fontWeight(FontWeight.Normal)
          Span(this.amount.toFixed(2)).fontSize(28).fontWeight(FontWeight.Bold)
        }
        .fontColor('#E39331')
      }
      .width('100%')
      .padding({ top: 20, bottom: 16 })
      .alignItems(HorizontalAlign.Center)

      // 分割线
      Divider()
        .color('#F0F0F0')
        .width('100%')
        .height(1)

      // 支付方式选择
      AggregatedPaymentPicker({
        channelInfo: [{
          channelType: ChannelType.HUAWEI_PAY,
          name: '华为支付',
          icon: $r('app.media.hwpay'),
          preOrderInfo: this.hwOrderStr,
        }, {
          channelType: ChannelType.WECHAT_PAY,
          preOrderInfo: this.wxOrderReq ?? new WxExtraInfo(),
          appId: MockApi.WX_APP_ID,
          icon: $r('app.media.wechat'),
          name: '微信支付',
          event: () => {
            this.onClose();
          },
        }, {
          channelType: ChannelType.ALI_PAY,
          name: '支付宝支付',
          icon: $r('app.media.alipay'),
          preOrderInfo: this.aliOrderStr,
        }],
        paySuccessEvent: (type: ChannelType) => {
          this.onPaySuccess(type);
        },
      })
    }
    .width('100%')
    .backgroundColor($r('sys.color.background_primary'))
    .borderRadius({ topLeft: 16, topRight: 16 })
  }
} 