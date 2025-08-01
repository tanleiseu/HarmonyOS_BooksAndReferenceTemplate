export interface BookInfo {
  id: string
  name: string
  coverUrl?: PixelMap | ResourceStr | DrawableDescriptor
  rankUrl?: PixelMap | ResourceStr | DrawableDescriptor
  rate: string
  description: string
  author: string
  localPath: string,
  epubUrl: string,
  category: string,
  isFree?: string, // 付费类型 0：免费、1：会员、2：付费
  count?: string
  popular?: string
  gender?:string // 区分男生女生频道 '1':女生 '2':男生
}

export interface rankListInfo {
  id: string;
  rankName: string;
  detailBooks: Array<BookInfo>;
}