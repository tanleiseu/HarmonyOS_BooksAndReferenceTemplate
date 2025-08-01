# 滑动卡片组件快速入门

## 目录

- [简介](#简介)
- [使用](#使用)
- [API参考](#API参考)
- [示例代码](#示例代码)

## 简介

本组件提供了展示滑动卡片的相关功能。
<img src="./screenshot/swiper_card.PNG" width="300">


## 使用

1. 安装组件。
   将模板根目录的components下swiper_card目录拷贝至您工程根目录components/，并添加如下依赖。

   ```typescript
   // 模块下的oh-package.json5
   "dependencies": {
     "swiper_card": "file:../components/swiper_card",
     "@hw-agconnect/ui-base": "^1.0.1"
   }
   
   // 模板根目录的build-profile.json5
   "modules": [
     {
       "name": "swiper_card",
       "srcPath": "./components/swiper_card"
     }
   ]
   ```

2. 引入组件。

   ```typescript
   import { swiper_card } from 'swiper_card';
   ```

3. 调用组件，详细参数配置说明参见[API参考](#API参考)。

   ```typescript
    TUISwiper({
     isCovered: , // 中间图片是否覆盖两边
     imgWidth: , // 中心图片宽度
     imgHeight: , // 中心图片高度
     interval: , // 间隔时间
     isLoop: , // 是否循环
     builderList: , // 图书卡片布局
     bookList: , // 图书数据
     onImageClick: (index: number) => {
       // 图片被点击时执行的操作
     }
   })
   ```

## API参考

### 接口

TUISwiper({
   imgWidth: number,
   imgHeight: number,
   interval: number,
   builderList: LazyDataVM<BookInfo>,
   bookList: WrappedBuilder<BookInfo>,
   isLoop: boolean,
   isCovered: boolean,
   onImageClick: (index: number) => {
   }
})

展示滑动卡片页面组件。

**参数：**

| 参数名          | 类型                                                       | 是否必填 | 说明       |
|-------------|----------------------------------------------------------|----|----------|
| isCovered   | boolean                                                  | 否  | 中间图片是否覆盖两边 |
| imgWidth    | number                                                   | 否  | 中心图片宽度   |
| imgHeight   | number                                                   | 否  | 中心图片高度   |
| interval    | number                                                   | 否  | 间隔时间     |
| isLoop      | boolean                                                  | 否  | 是否循环     |
| builderList | WrappedBuilder<[BookInfo](#BookInfo对象说明)>                | 是  | 封装全局的图书数据 |
| bookList    | [LazyDataVM](#LazyDataVM对象说明)<[BookInfo](#BookInfo对象说明)> | 是  | 图书数据     |

### LazyDataVM对象说明

| 名称         | 类型                          | 是否必填 | 说明   |
|------------|-----------------------------|---|------|
| dataArray  | [BookInfo](#BookInfo对象说明)[] | 是 | 图书列表 |

### BookInfo对象说明

| 名称        | 类型                                    | 是否必填 | 说明         |
| ----------- | --------------------------------------- | -------- | ------------ |
| id          | string                                  | 是       | 图书id       |
| name        | string                                  | 是       | 图书名称     |
| coverUrl    | PixelMap\ResourceStr\DrawableDescriptor | 否       | 封面         |
| rankUrl     | PixelMap\ResourceStr\DrawableDescriptor | 否       | 等级图标     |
| rate        | string                                  | 是       | 等级数       |
| description | string                                  | 是       | 描述         |
| author      | string                                  | 是       | 作者         |
| localPath   | string                                  | 否       | 图书本地路径 |
| epubUrl     | string                                  | 是       | 图书的epub   |
| category    | string                                  | 是       | 类别         |
| isFree      | string                                  | 是       | 付费类型     |
| count       | string                                  | 否       | 字数         |
| popular     | string                                  | 否       | 热度         |
| gender      | string                                  | 否       | 性别         |

### 事件

支持以下事件：

#### onImageClick

onImageClick(callback: (id: number) => void)

图片被点击时执行的操作

## 示例代码

```typescript
import { BookInfo, LazyDataVM, TUISwiper, bookSingleSwiper } from 'swiper_card';

const bookSingleSwiperBuilder: WrappedBuilder<[BookInfo]> = wrapBuilder(bookSingleSwiper);
@Entry
@ComponentV2
struct Index {
   @Local books: LazyDataVM<BookInfo> = new LazyDataVM();
   @Local imgHeight: number = 250;
   @Local imgWidth: number = 150;
   @Local builderList: WrappedBuilder<[BookInfo]>[] = []

   aboutToAppear(): void {
      this.books.pushArrayData([{
         "id": "1",
         "author": "作者",
         "name": "设计理论实践应用",
         "coverUrl": "app.media.book_image_1",
         "category": "艺术",
         "rate": "8",
         "count": "102万字",
         "popular": "10.5",
         "isFree": "0",
         "gender": "2"
      } as BookInfo, {
         "id": "2",
         "author": "作者",
         "name": "小羊肖恩",
         "coverUrl": "app.media.book_image_2",
         "category": "文学",
         "rate": "7",
         "count": "102万字",
         "popular": "10.5",
         "isFree": "1",
         "gender": "2"
      } as BookInfo,{
         "id": "2",
         "author": "作者",
         "name": "小羊肖恩",
         "coverUrl": "app.media.book_image_2",
         "category": "文学",
         "rate": "7", 
         "count": "102万字",
         "popular": "10.5",
         "isFree": "1",
         "gender": "2"
      } as BookInfo])
      this.builderList.push(bookSingleSwiperBuilder);
      this.builderList.push(bookSingleSwiperBuilder);
      this.builderList.push(bookSingleSwiperBuilder);
   }

   build() {
      Column() {
         TUISwiper({
            imgWidth: this.imgWidth,
            imgHeight: this.imgHeight,
            builderList: this.builderList,
            bookList: this.books,
            isLoop: true,
            isCovered: false,
            onImageClick: (index: number) => {
            }
         })
      }
   }
}
```

<img src="./screenshot/swiper_card.PNG" width="300">