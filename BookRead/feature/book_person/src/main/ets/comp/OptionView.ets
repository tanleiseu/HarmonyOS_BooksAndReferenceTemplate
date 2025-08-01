import { Constants, TCRouter } from 'common'

@ComponentV2
export struct OptionView {
  @Param text:string=''
  @Param url?:string=''
  @Param additionalText?:string=''

  build() {
      Row(){
        Text(this.text)
          .fontSize(16)
          .height(21)
          .width(100)
        Image($r('app.media.ic_arrow_right'))
          .width(7)
          .height(14)
          .objectFit(ImageFit.Contain)
      }

      .width(Constants.FULL_SIZE)
      .height(61)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left:18,
        top:20,
        bottom:20,
        right:18
      })
      .onClick(() => {
        if(this.url){
          TCRouter.push(this.url);
        }
      })
  }
}
