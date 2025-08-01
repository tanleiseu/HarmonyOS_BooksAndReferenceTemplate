import { Constants, TCRouter } from 'common';
import { TextReader } from '@kit.SpeechKit';
import { BookHomePage } from './BookHomePage';
import {
  AboutPage,
  BorrowDetailInfoPage,
  BorrowPage,
  LibraryPage,
  LoginPage,
  PrivacyPage,
  MemberCenterPage,
  MemberAgreementPage,
  RechargePage,
  RechargeRecordPage,
  SettingPage,
  AccountPage,
  PreferencePage,
  ActivityPage,
  FeedbackPage,
  FeedbackRecordPage,
  IssueAndFeedbackPage,
  PrivacyPolicyPage,
  DataCollectionPage,
  DataSharingPage
} from 'book_person';
import { BookShelfPage } from 'book_shelf';
import { BookListPage, BookViewListPage, SearchPage } from 'book_home';
import { ReaderPage } from 'book_read_kit';


@Entry
@ComponentV2
struct Index {
  aboutToAppear(): void {
    TCRouter.replace(Constants.HOME_ROUTER);
  }

  @Builder
  routerMap(name: string) {
    if (name === Constants.HOME_ROUTER) {
      BookHomePage();
    } else if (name === Constants.READ_KIT_ROUTER) {
      ReaderPage();
    } else if (name === Constants.SETTING_ROUTE) {
      SettingPage()
    } else if (name === Constants.ACCOUNT_ROUTE) {
      AccountPage();
    } else if (name === Constants.LIBARY_ROUTE) {
      LibraryPage();
    } else if (name === Constants.BORROW_DETAIL_ROUTE) {
      BorrowDetailInfoPage();
    } else if (name === Constants.BORROW_ROUTE) {
      BorrowPage();
    } else if (name === Constants.SHELF_ROUTER) {
      BookShelfPage();
    } else if (name === Constants.BOOK_LIST_ROUTE) {
      BookViewListPage();
    } else if (name === Constants.SEARCH_ROUTE) {
      SearchPage();
    } else if (name === Constants.LOGIN_ROUTE) {
      LoginPage();
    } else if (name === Constants.PREFERENCE_ROUTE) {
      PreferencePage();
    } else if (name === Constants.ACTIVITY_ROUTE) {
      ActivityPage();
    } else if (name === Constants.ABOUT_ROUTE) {
      AboutPage();
    } else if (name === Constants.PRIVACY_ROUTE) {
      PrivacyPage();
    } else if (name === Constants.FEEDBACK_ROUTE) {
      FeedbackPage();
    } else if (name === Constants.FEEDBACK_RECORD_ROUTE) {
      FeedbackRecordPage();
    } else if (name === Constants.ISSUE_AND_FEEDBACK_ROUTE) {
      IssueAndFeedbackPage();
    } else if (name === Constants.BOOK_CASE_ROUTER) {
      BookListPage();
    } else if (name === Constants.PRIVACY_POLICY_ROUTE) {
      PrivacyPolicyPage();
    } else if (name === Constants.MEMBER_CENTER_ROUTE) {
      MemberCenterPage();
    } else if (name === Constants.MEMBER_AGREEMENT_ROUTE) {
      MemberAgreementPage();
    } else if (name === Constants.RECHARGE_ROUTE) {
      RechargePage();
    } else if (name === Constants.RECHARGE_RECORD_ROUTE) {
      RechargeRecordPage();
    } else if (name === Constants.DATA_COLLECTION_ROUTE) {
      DataCollectionPage();
    } else if (name === Constants.DATA_SHARING_ROUTE) {
      DataSharingPage();
    }
  }

  build() {
    Stack() {
      Navigation(TCRouter.getStack())
        .hideNavBar(true)
        .hideTitleBar(true)
        .mode(NavigationMode.Stack)
        .width(Constants.FULL_SIZE)
        .height(Constants.FULL_SIZE)
        .navDestination(this.routerMap)
    }.height(Constants.FULL_SIZE)
    .width(Constants.FULL_SIZE)
  }
}